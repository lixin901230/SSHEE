package com.zl.frame.sysman.orgman.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

import com.zl.frame.core.util.JsonUtil;
import com.zl.frame.sysman.orgman.bean.OrgInfo;
import com.zl.frame.sysman.orgman.dao.IOrgInfoDao;
import com.zl.frame.sysman.orgman.service.IOrgInfoService;
import com.zl.frame.sysman.resourceman.bean.Menu;

/**
 * @desc：机构信息管理业务接口实现
 * @author lixin
 * @date: 2013-11-19下午2:29:56
 */
public class OrgInfoServiceImpl implements IOrgInfoService {
	
	private IOrgInfoDao orgInfoDao;
	public IOrgInfoDao getOrgInfoDao() {
		return orgInfoDao;
	}
	public void setOrgInfoDao(IOrgInfoDao orgInfoDao) throws Exception {
		this.orgInfoDao = orgInfoDao;
	}

	/**
	 * 添加菜单节点
	 * @param orgInfo
	 * @return
	 */
	public Serializable insertOrgInfo(OrgInfo orgInfo) throws Exception {
		return orgInfoDao.save(orgInfo);
	}
	
	/**
	 * 删除菜单节点
	 * @param orgInfo
	 */
	public void deleteOrgInfo(OrgInfo orgInfo) throws Exception {
		orgInfoDao.delete(orgInfo);
	}
	
	/**
	 * 根据菜单节点ID删除
	 * @param orgInfoId
	 * @throws Exception 
	 */
	public void deleteOrgInfoById(String orgInfoId) throws Exception{
		orgInfoDao.delete(null, orgInfoId);
	}

	/**
	 * 保存或者更新菜单节点<br>
	 * orgInfo为新建对象时，则保存改orgInfo信息；orgInfo为已存在持久化对象时，则更新orgInfo信息
	 * @param orgInfo
	 */
	public void saveOrUpdateOrgInfo(OrgInfo orgInfo) throws Exception {
		orgInfoDao.saveOrUpdate(orgInfo);
	}
	
	/**
	 * 修改菜单节点信息
	 * @param orgInfo
	 */
	public void updateOrgInfo(OrgInfo orgInfo) throws Exception {
		orgInfoDao.update(orgInfo);
	}
	
	/**
	 * 根据Hql语句更新菜单节点信息
	 * @param hql
	 * @param objects 可变参数列表
	 */
	public void UpdateOrgInfoByHql(String hql, Object...objects) throws Exception {
		orgInfoDao.updateByHql(hql, objects);
	}
	
	/**
	 * 根据菜单节点ID查询菜单节点信息
	 * @param OrgInfoId
	 * @return OrgInfo
	 */
	public OrgInfo findOrgInfoById(String orgInfoId) throws Exception {
		return orgInfoDao.get(null, orgInfoId);
	}
	
	/**
	 * 根据Hql查询单个菜单节点信息
	 * @param hql
	 * @param objects 可变参数列表
	 * @return OrgInfo
	 */
	public OrgInfo findOrgInfoByHql(String hql, Object...objects) throws Exception {
		return orgInfoDao.findByHql(hql, objects);
	}
	
	/**
	 * 根据Hql查询所有的菜单节点信息
	 * @param hql
	 * @param objects 可变参数列表
	 * @return List<Menu>
	 */
	public List<Menu> findAllOrgInfoList(String hql, Object...objects) throws Exception {
		
		List<OrgInfo> orgs = orgInfoDao.findAllByHql(hql, objects);
		List<Menu> menus = new ArrayList<Menu>();
		for (OrgInfo org : orgs) {
			
			Menu menu = new Menu();
			BeanUtils.copyProperties(menu, org);
			menu.setText(org.getOrgName());
			menus.add(menu);
		}
		return menus;
	}
	
	
	
	
	//********************************  treee	*******************
	
	/**
	 * 加载系统导航菜单树
	 * @throws Exception 
	 */
	public String loadIndexMenu() throws Exception{
		
		StringBuffer hql = new StringBuffer(" from OrgInfo res where res.statu=1 and res.id=0");
		List<OrgInfo> roots = orgInfoDao.findAllByHql(hql.toString());
		OrgInfo rootOrgInfo = roots.get(0);	//获取根节点，因为配置了关联关系，这个根节点已经包含了子节点是一颗完整的树
		
		hql = new StringBuffer(" from OrgInfo res where res.statu=1");
		List<OrgInfo> orgInfos = orgInfoDao.findAllByHql(hql.toString());
		/*for(OrgInfo r : orgInfos){//因为用了关联查询，所以查出来的已经是一科完整的树，这里把根节点的子节点设为null，为了测试下面迭代构造树
			r.setChildOrgInfoList(null);
		}*/
		OrgInfo jsonTreeOrgInfo = buildJsonTree(rootOrgInfo, orgInfos);
		return JsonUtil.obj2json(jsonTreeOrgInfo);
	}
	
	/**
	 * 处理树，根据跟节点和节点集合迭代生成树
	 * @param root	根节点
	 * @param orgInfos	节点集合
	 * @return
	 */
	public OrgInfo buildJsonTree(OrgInfo root,List<OrgInfo> orgInfos) throws Exception {
		
		/*if(orgInfos!=null && orgInfos.size()>0){
			for(OrgInfo orgInfo : orgInfos) {
				
				if(root.getId().equals(orgInfo.getParentId())){	//找出节点的子节点
					if(root.getChildOrgInfoList()!=null){
						
						root.getChildOrgInfoList().add(buildJsonTree(orgInfo, orgInfos));
					}else{
						
						List<OrgInfo> tmp = new ArrayList<OrgInfo>();
						tmp.add(buildJsonTree(orgInfo, orgInfos));
						root.setChildOrgInfoList(tmp);
					}
				}
			}
		}*/
		return root;
	}
	
	/**
	 * 获取所有的树节点
	 * @param hql
	 * @return List<Menu>
	 * @throws Exception 
	 */
	public List<Menu> getAllTreeOrgInfo(String hql) throws Exception{
		
		List<OrgInfo> orgInfos = orgInfoDao.findAllByHql(hql);
		
		List<Menu> menus = new ArrayList<Menu>();
		for (OrgInfo orgInfo : orgInfos) {
			
			Menu menu = new Menu();
			BeanUtils.copyProperties(menu, orgInfo);
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
	public List<OrgInfo> findOrgInfoBySql(String sql, Object[] objects) throws Exception {
		return orgInfoDao.findAllBySql(OrgInfo.class, sql, objects);
	}

	/**
	 * 根据原生sql语句查询用户拥有访问的菜单信息
	 * @param sql sql语句
	 * @param Object[] 可变参数
	 * @return
	 */
	public List<Menu> findMenuBySql(String sql, Object[] objects) throws Exception {
		
		List<OrgInfo> orgInfos = orgInfoDao.findAllBySql(OrgInfo.class, sql, objects);
		
		List<Menu> menus = new ArrayList<Menu>();
		for (OrgInfo orgInfo : orgInfos) {
			
			Menu menu = new Menu();
			BeanUtils.copyProperties(menu, orgInfo);
			menus.add(menu);
		}
		return menus;
	}

}
