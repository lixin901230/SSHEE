package com.zl.frame.sysman.userman.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.zl.frame.core.dao.impl.HibernateBaseDaoImpl;
import com.zl.frame.sysman.userman.bean.User;
import com.zl.frame.sysman.userman.dao.IUserDao;


/**
 * @desc：用户管理持久层抽象实现
 * @author lixin
 * @date: 2013-11-19下午2:43:15
 */
public class UserDaoImpl extends HibernateBaseDaoImpl<User, Integer> implements IUserDao {
	
	Logger logger = LoggerFactory.getLogger(UserDaoImpl.class);
	
	public User findByName(String userName) {

		User user = null;
		List<User> users = new ArrayList<User>();
		try {
			if(!StringUtils.isNotBlank(userName)){
				logger.info("根据用户名获取用户信息，用户名不能为空");
				return null;
			}
			users = findByCriteria(Restrictions.eq("userName", userName));
			user = (users.size() == 0 ? null : users.get(0));
			
			logger.info(user != null ? "成功获取用户信息，用户名："+ user.getUserName() 
							: "根据用户名["+userName+"]获取用户信息失败，用户为空");
		} catch (Exception e) {
			
			logger.debug("根据用户名获取用户信息失败");
			e.printStackTrace();
		}
		return user;
	}
}
