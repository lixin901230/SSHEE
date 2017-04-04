package com.zl.frame.sysman.authorizationman.service.impl;

import java.util.List;

import com.zl.frame.core.pager.Page;
import com.zl.frame.sysman.authorizationman.service.IAuthService;
import com.zl.frame.sysman.orgman.dao.IOrgInfoDao;
import com.zl.frame.sysman.roleman.bean.Role;
import com.zl.frame.sysman.roleman.dao.IRoleDao;
import com.zl.frame.sysman.usergroupman.dao.IUserGroupDao;
import com.zl.frame.sysman.userman.bean.User;
import com.zl.frame.sysman.userman.dao.IUserDao;

/**
 * @desc：授权综合管理模块 业务接口实现
 * @author lixin
 * @date: 2014-4-1上午10:14:11
 */
public class AuthServiceImpl implements IAuthService {
	
	private IUserDao userDao;
	private IRoleDao roleDao;
	private IUserGroupDao userGroupDao;
	private IOrgInfoDao orgInfoDao;
	
	
	/**
	 * @desc 根据本地sql查询所有的角色信息
	 * @param hql
	 * @param objects
	 * @return
	 * @throws Exception
	 * @author lixin
	 * @date 2014-4-2下午5:19:26
	 */
	public List<Role> findAllRoleByHql(String hql, Object[] objects) throws Exception {
		return roleDao.findAllByHql(hql, objects);
	}
	
	/**
	 * @desc 加载未授权用户列表，用于初始化
	 * @author lixin
	 * @param hql
	 * @throws Exception 
	 * @date 2014-4-2下午4:35:39
	 */
	@Override
	public Page<User> findUnAuthUserList(String hql, Page<User> userPage, Object[] params) throws Exception{
		return userDao.findByHql(hql, params, userPage.getCurPage(), userPage.getPageSize());
	}
	
	
	
	
	
	public IUserDao getUserDao() {
		return userDao;
	}
	public void setUserDao(IUserDao userDao) {
		this.userDao = userDao;
	}
	public IRoleDao getRoleDao() {
		return roleDao;
	}
	public void setRoleDao(IRoleDao roleDao) {
		this.roleDao = roleDao;
	}
	public IUserGroupDao getUserGroupDao() {
		return userGroupDao;
	}
	public void setUserGroupDao(IUserGroupDao userGroupDao) {
		this.userGroupDao = userGroupDao;
	}
	public IOrgInfoDao getOrgInfoDao() {
		return orgInfoDao;
	}
	public void setOrgInfoDao(IOrgInfoDao orgInfoDao) {
		this.orgInfoDao = orgInfoDao;
	}
	
	
}
