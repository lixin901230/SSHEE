package com.zl.frame.sysman.resourceman.service;

import java.io.Serializable;
import java.util.List;

import com.zl.frame.core.exception.PersistenceException;
import com.zl.frame.sysman.resourceman.bean.Menu;
import com.zl.frame.sysman.resourceman.bean.Resource;

/**
 * @desc：菜单节点业务接口
 * @author lixin
 * @date: 2013-11-19下午2:29:31
 */
public interface IResourceService {

	/**
	 * 加载jsontree
	 */
	public String loadIndexMenu() throws Exception;
	
	/**
	 * 获取所有的树节点
	 * @param hql
	 * @return List<Menu>
	 * @throws Exception 
	 */
	public List<Menu> getAllTreeNode(String hql) throws Exception;
	
	/**
	 * 添加菜单节点
	 * @param node
	 * @return
	 */
	public abstract Serializable insertNode(Resource node) throws Exception ;

	/**
	 * 删除菜单节点
	 * @param node
	 */
	public abstract void deleteNode(Resource node) throws Exception;
	
	/**
	 * 根据菜单节点ID删除
	 * @param nodeId
	 * @throws PersistenceException 
	 */
	public void deleteNodeById(String nodeId) throws Exception;

	/**
	 * 保存或者更新菜单节点<br>
	 * node为新建对象时，则保存改node信息；node为已存在持久化对象时，则更新node信息
	 * @param node
	 */
	public abstract void saveOrUpdateNode(Resource node) throws Exception ;

	/**
	 * 修改菜单节点信息
	 * @param node
	 */
	public abstract void updateNode(Resource node) throws Exception ;

	/**
	 * 根据Hql语句更新菜单节点信息
	 * @param hql
	 * @param objects 可变参数列表
	 */
	public abstract void UpdateNodeByHql(String hql, Object... objects) throws Exception ;

	/**
	 * 根据菜单节点ID查询菜单节点信息
	 * @param nodeId
	 * @return Node
	 */
	public abstract Resource findNodeById(String nodeId) throws Exception ;

	/**
	 * 根据Hql查询单个菜单节点信息
	 * @param hql
	 * @param objects 可变参数列表
	 * @return Node
	 * @throws Exception 
	 */
	public abstract Resource findNodeByHql(String hql, Object... objects) throws Exception;

	/**
	 * 根据Hql查询所有的菜单节点信息
	 * @param hql
	 * @param objects 可变参数列表
	 * @return List<Node>
	 * @throws Exception 
	 */
	public abstract List<Resource> findAllNodeList(String hql, Object... objects) throws Exception;
	
	/**
	 * 根据原生sql语句查询资源信息
	 * @param sql sql语句
	 * @param objects 可变参数
	 * @return
	 * @throws Exception 
	 */
	public abstract List<Resource> findResourcesBySql(String sql, Object[] objects) throws Exception;
	
	/**
	 * 根据原生sql语句查询用户拥有访问的菜单信息
	 * @param sql sql语句
	 * @param Object[] 可变参数
	 * @return
	 */
	public List<Menu> findMenuBySql(String sql, Object[] objects) throws Exception;
	
}
