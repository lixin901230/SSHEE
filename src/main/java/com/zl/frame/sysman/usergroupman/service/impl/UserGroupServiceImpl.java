package com.zl.frame.sysman.usergroupman.service.impl;

import java.io.Serializable;
import java.util.List;

import com.zl.frame.core.exception.PersistenceException;
import com.zl.frame.core.pager.Page;
import com.zl.frame.sysman.usergroupman.bean.UserGroup;
import com.zl.frame.sysman.usergroupman.dao.IUserGroupDao;
import com.zl.frame.sysman.usergroupman.service.IUserGroupService;

/**
 * @desc：用户管理业务接口实现
 * @author lixin
 * @date: 2013-11-19下午2:44:48
 */
public class UserGroupServiceImpl implements IUserGroupService {

	private IUserGroupDao userGroupDao;
	
	public IUserGroupDao getUserGroupDao() {
		return userGroupDao;
	}

	public void setUserGroupDao(IUserGroupDao userGroupDao) {
		this.userGroupDao = userGroupDao;
	}

	/**
	 * 添加一个新的用户信息，返回保存的用户唯一标示ID
	 * @param userGroup
	 * return Serializable 
	 */
	public Serializable insertUserGroup(UserGroup userGroup) throws Exception {
		return userGroupDao.save(userGroup);
	}
	
	/**
	 * 删除持久化UserGroup对象信息
	 * @param userGroup
	 */
	public void deleteUserGroup(UserGroup userGroup) throws Exception {
		userGroupDao.delete(userGroup);
	}
	
	/**
	 * 根据用户ID删除用户信息
	 * @param userGroupId
	 * @throws PersistenceException 
	 */
	public void deleteUserGroupById(String userGroupId) throws Exception{
		userGroupDao.delete(null, userGroupId);
	}
	
	/**
	 * 保存或者更新用户信息<br>
	 * user为新创建对象时，则执行save；user已存在时，则执行update更新用户信息
	 * @param userGroup
	 */
	public void saveOrUpdateUserGroup(UserGroup userGroup) throws Exception{
		userGroupDao.saveOrUpdate(userGroup);
	}
	
	/**
	 * 修改持久化UserGroup对象信息
	 * @param userGroup
	 */
	public void updateUserGroup(UserGroup userGroup) throws Exception {
		userGroupDao.update(userGroup);
	}
	
	/**
	 * 修改用户信息，通过hql语句修改
	 * @param hql
	 * @param objects
	 */
	public void updateUserGroupByHql(String hql, Object...objects) throws Exception {
		userGroupDao.updateByHql(hql, objects);
	}
	
	
	/**
	 * 根据用户ID查询
	 * @param userGroupId
	 * @return UserGroup
	 */ 
	public UserGroup findUserGroupById(String userGroupId) throws Exception {
		return userGroupDao.get(null, userGroupId);
	}
	
	/**
	 * 根据Hql和条件查询用户信息
	 * @param hql
	 * @return objects 可变参数
	 */ 
	public UserGroup findUserGroupByHql(String hql, Object...objects) throws Exception {
		return userGroupDao.findByHql(hql, objects);
	}
	
	/**
	 * 用户登陆查询
	 * @param hql
	 * @param userName
	 * @param pwd
	 * @return UserGroup
	 */
	public UserGroup findUserGroupByUserGroupNameAndPwd(String hql, String userName, String pwd) throws Exception {
		return userGroupDao.findByHql(hql, userName, pwd);
	}
	
	/**
	 * 根据Hql查询全部用户信息
	 * @param hql
	 * @param objects 可变参数
	 * @return
	 */
	public List<UserGroup> findAllUserGroupList(String hql, Object...objects) throws Exception {
		return userGroupDao.findAllByHql(hql, objects);
	}
	
	/**
	 * 分页查询用户信息
	 * @param hql
	 * @param page
	 * @param params
	 * @return Page<UserGroup>
	 */
	public Page<UserGroup> findUserGroupListByPage(String hql, String countHql, Page<UserGroup> page, Object[] params) throws Exception {
		return userGroupDao.findByHql(hql, countHql, params, page.getCurPage(), page.getPageSize());
	}

	
}
