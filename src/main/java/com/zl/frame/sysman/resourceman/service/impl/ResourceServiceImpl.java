package com.zl.frame.sysman.resourceman.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

import com.zl.frame.core.util.JsonUtil;
import com.zl.frame.sysman.resourceman.bean.Menu;
import com.zl.frame.sysman.resourceman.bean.Resource;
import com.zl.frame.sysman.resourceman.dao.IResourceDao;
import com.zl.frame.sysman.resourceman.service.IResourceService;

/**
 * @desc：菜单节点业务接口实现
 * @author lixin
 * @date: 2013-11-19下午2:29:56
 */
public class ResourceServiceImpl implements IResourceService {
	
	private IResourceDao resourceDao;
	public IResourceDao getResourceDao() {
		return resourceDao;
	}

	public void setResourceDao(IResourceDao resourceDao) throws Exception {
		this.resourceDao = resourceDao;
	}

	/**
	 * 添加菜单节点
	 * @param node
	 * @return
	 */
	public Serializable insertNode(Resource node) throws Exception {
		return resourceDao.save(node);
	}
	
	/**
	 * 删除菜单节点
	 * @param node
	 */
	public void deleteNode(Resource node) throws Exception {
		resourceDao.delete(node);
	}
	
	/**
	 * 根据菜单节点ID删除
	 * @param nodeId
	 * @throws Exception 
	 */
	public void deleteNodeById(String nodeId) throws Exception{
		resourceDao.delete(null, nodeId);
	}

	/**
	 * 保存或者更新菜单节点<br>
	 * node为新建对象时，则保存改node信息；node为已存在持久化对象时，则更新node信息
	 * @param resource
	 */
	public void saveOrUpdateNode(Resource resource) throws Exception {
		resourceDao.saveOrUpdate(resource);
	}
	
	/**
	 * 修改菜单节点信息
	 * @param node
	 */
	public void updateNode(Resource node) throws Exception {
		resourceDao.update(node);
	}
	
	/**
	 * 根据Hql语句更新菜单节点信息
	 * @param hql
	 * @param objects 可变参数列表
	 */
	public void UpdateNodeByHql(String hql, Object...objects) throws Exception {
		resourceDao.updateByHql(hql, objects);
	}
	
	/**
	 * 根据菜单节点ID查询菜单节点信息
	 * @param nodeId
	 * @return Node
	 */
	public Resource findNodeById(String nodeId) throws Exception {
		return resourceDao.get(null, nodeId);
	}
	
	/**
	 * 根据Hql查询单个菜单节点信息
	 * @param hql
	 * @param objects 可变参数列表
	 * @return Node
	 */
	public Resource findNodeByHql(String hql, Object...objects) throws Exception {
		return resourceDao.findByHql(hql, objects);
	}
	
	/**
	 * 根据Hql查询所有的菜单节点信息
	 * @param hql
	 * @param objects 可变参数列表
	 * @return List<Node>
	 */
	public List<Resource> findAllNodeList(String hql, Object...objects) throws Exception {
		return resourceDao.findAllByHql(hql, objects);
	}
	
	
	
	
	//********************************  treee	*******************
	
	/**
	 * 加载系统导航菜单树
	 * @throws Exception 
	 */
	public String loadIndexMenu() throws Exception{
		
		StringBuffer hql = new StringBuffer(" from Resource res where res.statu=1 and res.id=0");
		List<Resource> roots = resourceDao.findAllByHql(hql.toString());
		Resource rootNode = roots.get(0);	//获取根节点，因为配置了关联关系，这个根节点已经包含了子节点是一颗完整的树
		
		hql = new StringBuffer(" from Resource res where res.statu=1");
		List<Resource> nodes = resourceDao.findAllByHql(hql.toString());
		for(Resource r : nodes){//因为用了关联查询，所以查出来的已经是一科完整的树，这里把根节点的子节点设为null，为了测试下面迭代构造树
			r.setChildResourceList(null);
		}
		Resource jsonTreeNode = buildJsonTree(rootNode, nodes);
		return JsonUtil.obj2json(jsonTreeNode);
	}
	
	/**
	 * 处理树，根据跟节点和节点集合迭代生成树
	 * @param root	根节点
	 * @param nodes	节点集合
	 * @return
	 */
	public Resource buildJsonTree(Resource root,List<Resource> nodes) throws Exception {
		
		if(nodes!=null && nodes.size()>0){
			for(Resource node : nodes) {
				
				if(root.getId().equals(node.getParentId())){	//找出节点的子节点
					if(root.getChildResourceList()!=null){
						
						root.getChildResourceList().add(buildJsonTree(node, nodes));
					}else{
						
						List<Resource> tmp = new ArrayList<Resource>();
						tmp.add(buildJsonTree(node, nodes));
						root.setChildResourceList(tmp);
					}
				}
			}
		}
		return root;
	}
	
	/**
	 * 获取所有的树节点
	 * @param hql
	 * @return List<Menu>
	 * @throws Exception 
	 */
	public List<Menu> getAllTreeNode(String hql) throws Exception {
		
		List<Resource> nodes = resourceDao.findAllByHql(hql);
		
		List<Menu> menus = new ArrayList<Menu>();
		for (Resource node : nodes) {
			
			Menu menu = new Menu();
			BeanUtils.copyProperties(menu, node);
			menus.add(menu);
		}
		return menus;
	}

	/**
	 * 根据原生sql语句查询资源信息
	 * @param sql sql语句
	 * @param objects 可变参数
	 * @return
	 */
	public List<Resource> findResourcesBySql(String sql, Object[] objects) throws Exception {
		return resourceDao.findAllBySql(Resource.class, sql, objects);
	}

	/**
	 * 根据原生sql语句查询用户拥有访问的菜单信息
	 * @param sql sql语句
	 * @param Object[] 可变参数
	 * @return
	 */
	public List<Menu> findMenuBySql(String sql, Object[] objects) throws Exception {
		
		List<Resource> nodes = resourceDao.findAllBySql(Resource.class, sql, objects);
		
		List<Menu> menus = new ArrayList<Menu>();
		for (Resource node : nodes) {
			
			Menu menu = new Menu();
			BeanUtils.copyProperties(menu, node);
			menus.add(menu);
		}
		return menus;
	}
}
