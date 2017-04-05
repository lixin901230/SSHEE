package com.zl.frame.sysman.authorizationman.service;

import java.util.List;

import com.zl.frame.core.pager.Page;
import com.zl.frame.sysman.roleman.bean.Role;
import com.zl.frame.sysman.userman.bean.User;


/**
 * @desc：授权综合管理模块 业务接口定义
 * @author lixin
 * @date: 2014-4-1上午10:14:27
 */
public interface IAuthService {
	
	/**
	 * @desc 根据本地sql查询所有的角色信息
	 * @param hql
	 * @param objects
	 * @return
	 * @throws Exception
	 * @author lixin
	 * @date 2014-4-2下午5:19:26
	 */
	public List<Role> findAllRoleByHql(String sql, Object[] objects) throws Exception;

	/**
	 * @desc 加载未授权用户列表，用于初始化
	 * @author lixin
	 * @param hql
	 * @throws Exception 
	 * @date 2014-4-2下午4:35:39
	 */
	public Page<User> findUnAuthUserList(String hql, String countHql, Page<User> userPage, Object[] params) throws Exception;

}
