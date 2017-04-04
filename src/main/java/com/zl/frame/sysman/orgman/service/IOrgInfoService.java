package com.zl.frame.sysman.orgman.service;

import java.io.Serializable;
import java.util.List;

import com.zl.frame.core.exception.PersistenceException;
import com.zl.frame.sysman.orgman.bean.OrgInfo;
import com.zl.frame.sysman.resourceman.bean.Menu;

/**
 * @desc：机构信息管理业务接口定义
 * @author lixin
 * @date: 2013-11-19下午2:29:31
 */
public interface IOrgInfoService {

	/**
	 * 添加机构信息
	 * @param orgInfo
	 * @return
	 */
	public abstract Serializable insertOrgInfo(OrgInfo orgInfo) throws Exception ;

	/**
	 * 删除机构信息
	 * @param orgInfo
	 */
	public abstract void deleteOrgInfo(OrgInfo orgInfo) throws Exception;
	
	/**
	 * 根据机构ID删除
	 * @param nodeId
	 * @throws PersistenceException 
	 */
	public void deleteOrgInfoById(String nodeId) throws Exception;

	/**
	 * 保存或者更新机构信息<br>
	 * node为新建对象时，则保存改node信息；node为已存在持久化对象时，则更新node信息
	 * @param orgInfo
	 */
	public abstract void saveOrUpdateOrgInfo(OrgInfo orgInfo) throws Exception ;

	/**
	 * 修改机构信息
	 * @param orgInfo
	 */
	public abstract void updateOrgInfo(OrgInfo orgInfo) throws Exception ;

	/**
	 * 根据Hql语句更新机构信息
	 * @param hql
	 * @param objects 可变参数列表
	 */
	public abstract void UpdateOrgInfoByHql(String hql, Object... objects) throws Exception ;
	
	/**
	 * 根据机构ID查询机构信息
	 * @param nodeId
	 * @return OrgInfo
	 */
	public abstract OrgInfo findOrgInfoById(String nodeId) throws Exception ;

	/**
	 * 根据Hql查询单个机构信息
	 * @param hql
	 * @param objects 可变参数列表
	 * @return OrgInfo
	 * @throws Exception 
	 */
	public abstract OrgInfo findOrgInfoByHql(String hql, Object... objects) throws Exception;

	/**
	 * 根据Hql查询所有的机构信息
	 * @param hql
	 * @param objects 可变参数列表
	 * @return List<Menu>
	 * @throws Exception 
	 */
	public abstract List<Menu> findAllOrgInfoList(String hql, Object... objects) throws Exception;
	
	/**
	 * 根据原生sql语句查询机构信息
	 * @param sql sql语句
	 * @param objects 可变参数
	 * @return
	 * @throws Exception 
	 */
	public abstract List<OrgInfo> findOrgInfoBySql(String sql, Object[] objects) throws Exception;
	
	/**
	 * 根据原生sql语句查询用户拥有访问的机构信息
	 * @param sql sql语句
	 * @param Object[] 可变参数
	 * @return
	 */
	public List<Menu> findMenuBySql(String sql, Object[] objects) throws Exception;
}
