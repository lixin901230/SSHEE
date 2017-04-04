package com.zl.frame.core.security.util;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;

/**
 * @desc：Spring Security 工具类
 * @author lixin
 * @date: 2014-1-12下午9:02:04
 */
public class SecurityUtial {
	
	private static Logger logger = LoggerFactory.getLogger(SecurityUtial.class);

	/**
	 * 获取当前登录的用户对象
	 * @return 当前登录用户对象org.springframework.security.core.userdetails.User
	 */
	public static User getCurrentUser(){
		
		User currentUser = null;
		SecurityContext context = SecurityContextHolder.getContext();
		if(context != null){
			Authentication auth = context.getAuthentication();
			if((auth != null) && (auth.getPrincipal() instanceof User)) {
				currentUser = (User) auth.getPrincipal();
			}
		}
		return currentUser;
	}
	
	/**
	 * 获取当前登录的用户名
	 * @return currentUserName 用户名
	 */
	public static String getCurrentUserName(){
		
		logger.info("获取当前登录的用户名开始...");
		
		User currentUser = getCurrentUser();
		if(currentUser != null && StringUtils.isNotBlank(currentUser.getUsername())){
			logger.info("成功获取当前用户名：" + currentUser.getUsername());
			return currentUser.getUsername();
		}
		logger.debug("获取的当前用户名为空！");
		return null;
	}
}
