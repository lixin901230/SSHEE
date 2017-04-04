package com.zl.frame.sysman.userman.dao;

import com.zl.frame.core.dao.IHibernateBaseDao;
import com.zl.frame.sysman.userman.bean.User;



/**
 * @desc：用户管理持久层接口
 * @author lixin
 * @date: 2013-11-19下午2:42:03这儿不需要继承IbaseDao了
 */
public interface IUserDao extends IHibernateBaseDao<User, Integer>{

	/**
	 * 根据用户账号查询用户信息
	 * @param name
	 * @return
	 */
	User findByName(String name);
}