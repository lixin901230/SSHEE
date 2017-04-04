package com.zl.frame.sysman.usergroupman.dao.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.zl.frame.core.dao.impl.HibernateBaseDaoImpl;
import com.zl.frame.sysman.usergroupman.bean.UserGroup;
import com.zl.frame.sysman.usergroupman.dao.IUserGroupDao;


/**
 * @desc：用户组管理持久层抽象实现
 * @author lixin
 * @date: 2013-11-19下午2:43:15
 */
public class UserGroupDaoImpl extends HibernateBaseDaoImpl<UserGroup, String> implements IUserGroupDao {
	
	Logger logger = LoggerFactory.getLogger(UserGroupDaoImpl.class);
	
}
