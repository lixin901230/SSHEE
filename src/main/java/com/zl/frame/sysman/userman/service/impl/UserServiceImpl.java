package com.zl.frame.sysman.userman.service.impl;

import java.io.Serializable;
import java.util.List;

import com.zl.frame.core.exception.PersistenceException;
import com.zl.frame.core.pager.Page;
import com.zl.frame.sysman.userman.bean.User;
import com.zl.frame.sysman.userman.dao.IUserDao;
import com.zl.frame.sysman.userman.service.IUserService;

/**
 * @desc：用户管理业务接口实现
 * @author lixin
 * @date: 2013-11-19下午2:44:48
 */
public class UserServiceImpl implements IUserService {

	private IUserDao userDao;
	
	public IUserDao getUserDao() {
		return userDao;
	}
	public void setUserDao(IUserDao userDao) {
		this.userDao = userDao;
	}

	/**
	 * 添加一个新的用户信息，返回保存的用户唯一标示ID
	 * @param user
	 * return Serializable 
	 */
	public Serializable insertUser(User user) throws Exception {
		return userDao.save(user);
	}
	
	/**
	 * 删除持久化User对象信息
	 * @param user
	 */
	public void deleteUser(User user) throws Exception {
		userDao.delete(user);
	}
	
	/**
	 * 根据用户ID删除用户信息
	 * @param userId
	 * @throws PersistenceException 
	 */
	public void deleteUserById(int userId) throws Exception{
		userDao.delete(null, userId);
	}
	
	/**
	 * 保存或者更新用户信息<br>
	 * user为新创建对象时，则执行save；user已存在时，则执行update更新用户信息
	 * @param user
	 */
	public void saveOrUpdateUser(User user) throws Exception {
		userDao.saveOrUpdate(user);
	}
	
	/**
	 * 修改持久化User对象信息
	 * @param user
	 */
	public void updateUser(User user) throws Exception {
		userDao.update(user);
	}
	
	/**
	 * 修改用户信息，通过hql语句修改
	 * @param hql
	 * @param objects
	 */
	public void updateUserByHql(String hql, Object...objects) throws Exception {
		userDao.updateByHql(hql, objects);
	}
	
	
	/**
	 * 根据用户ID查询
	 * @param userId
	 * @return User
	 */ 
	public User findUserById(int userId) throws Exception {
		return userDao.get(null, userId);
	}
	
	/**
	 * 根据Hql和条件查询用户信息
	 * @param hql
	 * @return objects 可变参数
	 */ 
	public User findUserByHql(String hql, Object...objects) throws Exception {
		return userDao.findByHql(hql, objects);
	}
	
	/**
	 * 用户登陆查询
	 * @param hql
	 * @param userName
	 * @param pwd
	 * @return User
	 */
	public User findUserByUserNameAndPwd(String hql, String userName, String pwd) throws Exception {
		return userDao.findByHql(hql, userName, pwd);
	}
	
	/**
	 * 根据Hql查询全部用户信息
	 * @param hql
	 * @param objects 可变参数
	 * @return
	 */
	public List<User> findAllUserList(String hql, Object...objects) throws Exception {
		return userDao.findAllByHql(hql, objects);
	}
	
	/**
	 * 分页查询用户信息
	 * @param hql
	 * @param page
	 * @param params
	 * @return Page<User>
	 */
	public Page<User> findUserListByPage(String hql, String countHql, Page<User> page, Object[] params) throws Exception {
		return userDao.findByHql(hql, countHql, params, page.getCurPage(), page.getPageSize());
	}

	/**
	 * 分页查询用户信息(根据原生sql查询)
	 * @param sql
	 * @param page
	 * @param params
	 * @return Page<User>
	 */
	public Page<User> findUserListPageBySql(String sql, String countSql, Page<User> page, Object[] params) throws Exception {
		return userDao.findBySql(User.class, sql, countSql, params, page.getCurPage(), page.getPageSize());
	}
}
