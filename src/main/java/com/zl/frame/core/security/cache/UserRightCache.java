package com.zl.frame.core.security.cache;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @desc：用户权限缓存对象
 * <li>权限缓存使用Map进行缓存</li>
 * <li>权限缓存Map中key=userName（用户名）,value=List（权限集合）</li>
 * @author lixin
 * @date: 2014-1-13上午10:53:35
 */
public class UserRightCache {
	
	private static Logger logger = LoggerFactory.getLogger(UserRightCache.class);

	/**
	 * @desc 所有系统用户的权限Map，key=userName(用户名)，value=List(权限集合)
	 */
	private static Map<String, List<String>> userRight = Collections.synchronizedMap(new HashMap<String,List<String>>());
	
	/**
	 * @desc 缓存登录用户拥有的所有权限信息
	 * @param userName 用户名
	 * @param rights 用户的权限集合
	 * @author lixin
	 * @date 2014-1-13上午11:36:14
	 */
	public static void pushUserRight(String userName, List<String> rights){
		
		logger.info("开始缓存当前登录用户["+userName+"]拥有的所有权限信息");
		if(StringUtils.isNotBlank(userName)){

			userRight.put(userName, rights);
			logger.info("以成功将用户["+userName+"]拥有的所有权限信息放入用户缓存对象中");
		} else {
			logger.debug("缓存登录用户的权限失败，原因：缓存用户权限时用户名不能为空！");
		}
	}
	
	/**
	 * @desc 根据用户名从用户权限缓存中获取用户的所有权限信息
	 * @param userName 用户名，can't null
	 * @return List 用户权限集合
	 * @author lixin
	 * @date 2014-1-13上午11:37:43
	 */
	public static List<String> getUserRight(String userName){
		
		logger.info("根据用户名从用户权限缓存中获取用户的所有权限信息开始...");
		
		if(StringUtils.isBlank(userName)){
			logger.debug("根据用户名获取用户的权限信息失败，用户名不能为空");
			return null;
		}
		logger.info("成功获取权限缓存中用户["+userName+"]拥有的所有权限信息");
		return (List<String>) userRight.get(userName);
	}
	
	/**
	 * @desc 获取所有系统用户的权限缓存信息
	 * @return Map（系统所有用户缓存）该map中，key=userName(用户名),value=List(用户的权限集合)
	 * @author lixin
	 * @date 2014-1-13上午11:37:51
	 */
	public static Map<String, List<String>> getAllUserRights(){
		
		logger.info("获取所有系统用户的权限缓存信息");
		return userRight;
	}
}
