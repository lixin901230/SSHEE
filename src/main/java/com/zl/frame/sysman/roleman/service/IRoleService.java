package com.zl.frame.sysman.roleman.service;

import java.io.Serializable;
import java.util.List;

import com.zl.frame.core.pager.Page;
import com.zl.frame.sysman.roleman.bean.Role;

/**
 * @desc：角色管理物业接口
 * @author lixin
 * @date: 2013-11-19下午2:37:02
 */
public interface IRoleService {

	/**
	 * 添加角色信息
	 * @param role
	 * @return
	 */
	public abstract Serializable insertRole(Role role) throws Exception;

	/**
	 * 删除角色信息
	 * @param role
	 */
	public abstract void deleteRole(Role role) throws Exception;
	
	/**
	 * 根据角色ID删除角色信息
	 * @param roleId
	 * @throws Exception 
	 */
	public void deleteRoleById(int roleId) throws Exception;

	/**
	 * 添加角色信息
	 * @param role
	 */
	public abstract void saveRole(Role role) throws Exception;
	
	/**
	 * 添加或者更新角色信息
	 * @param role
	 */
	public abstract void saveOrUpdateRole(Role role) throws Exception;

	/**
	 * 修改持久化角色信息
	 * @param role
	 */
	public abstract void updateRole(Role role) throws Exception;

	/**
	 * 修改角色信息，根据hql语句修改
	 * @param hql
	 * @param values 可变参数列表
	 */
	public abstract void updateRoleByHql(String hql, Object... values) throws Exception;

	/**
	 * 根据角色ID获取角色信息
	 * @param roleId
	 * @return
	 */
	public abstract Role findRoleById(Integer roleId) throws Exception;

	/**
	 * 根据Hql语句查询单个角色信息
	 * @param hql
	 * @param objects 可变参数列表
	 * @return Role
	 */
	public abstract Role findRoleByHql(String hql, Object... objects) throws Exception;

	/**
	 * 根据Hql查询所有的角色信息
	 * @param hql
	 * @param objects 可变参数
	 * @return
	 */
	public List<Role> findAllRoleList(String hql, Object[] objects) throws Exception;
	
	/**
	 * 分页查询角色信息列表
	 * @param hql
	 * @param page
	 * @param objects 可变参数列表
	 * @return
	 */
	public abstract Page<Role> findRoleListByPage(String hql, Page<Role> page,
			Object... objects) throws Exception;
}
