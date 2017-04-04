package com.zl.frame.sysman.roleman.service.impl;

import java.io.Serializable;
import java.util.List;

import com.zl.frame.core.exception.PersistenceException;
import com.zl.frame.core.pager.Page;
import com.zl.frame.sysman.roleman.bean.Role;
import com.zl.frame.sysman.roleman.dao.IRoleDao;
import com.zl.frame.sysman.roleman.service.IRoleService;

/**
 * @desc：角色管理业务接口实现
 * @author lixin
 * @date: 2013-11-19下午2:39:25
 */
public class RoleServiceImpl implements IRoleService {

	private IRoleDao roleDao;
	
	
	public IRoleDao getRoleDao() {
		return roleDao;
	}
	public void setRoleDao(IRoleDao roleDao) {
		this.roleDao = roleDao;
	}

	/**
	 * 添加角色信息
	 * @param role
	 * @return
	 */
	public Serializable insertRole(Role role) throws Exception {
		return roleDao.save(role);
	}
	
	/**
	 * 删除角色信息
	 * @param role
	 */
	public void deleteRole(Role role) throws Exception {
		roleDao.delete(role);
	}
	
	/**
	 * 根据角色ID删除角色信息
	 * @param roleId
	 * @throws PersistenceException 
	 */
	public void deleteRoleById(int roleId) throws Exception{
		roleDao.delete(null,roleId);
	}
	
	/**
	 * 添加角色信息
	 * @param role
	 */
	public void saveRole(Role role) throws Exception {
		roleDao.save(role);
	}
	
	/**
	 * 添加或者更新角色信息
	 * @param role
	 */
	public void saveOrUpdateRole(Role role) throws Exception {
		roleDao.saveOrUpdate(role);
	}
	
	/**
	 * 修改持久化角色信息
	 * @param role
	 */
	public void updateRole(Role role) throws Exception {
		roleDao.update(role);
	}
	
	/**
	 * 修改角色信息，根据hql语句修改
	 * @param hql
	 * @param values 可变参数列表
	 */
	public void updateRoleByHql(String hql, Object...values) throws Exception {
		roleDao.updateByHql(hql, values);
	}
	
	/**
	 * 根据角色ID获取角色信息
	 * @param roleId
	 * @return
	 */
	public Role findRoleById(Integer roleId) throws Exception {
		return roleDao.get(null, roleId);
	}
	
	/**
	 * 根据Hql语句查询单个角色信息
	 * @param hql
	 * @param objects 可变参数列表
	 * @return Role
	 */
	public Role findRoleByHql(String hql, Object...objects) throws Exception {
		return roleDao.findByHql(hql, objects);
	}
	
	/**
	 * 根据Hql查询所有的角色信息
	 * @param hql
	 * @param objects 可变参数
	 * @return
	 */
	public List<Role> findAllRoleList(String hql, Object[] objects) throws Exception {
		return roleDao.findAllByHql(hql, objects);
	}
	
	/**
	 * 分页查询角色信息列表
	 * @param hql
	 * @param page
	 * @param objects 可变参数列表
	 * @return
	 */
	public Page<Role> findRoleListByPage(String hql, Page<Role> page, Object...objects) throws Exception {
		return roleDao.findByHql(hql, objects, page.getCurPage(), page.getPageSize());
	}
}
