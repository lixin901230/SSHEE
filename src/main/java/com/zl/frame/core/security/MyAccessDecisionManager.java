package com.zl.frame.core.security;

import java.util.Collection;
import java.util.Iterator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;


/**
 * @desc：访问决策管理器，决定某个用户具有的角色，是否有足够的权限去访问某个资源
 * @author lixin
 * @date: 2014-1-8下午4:22:40
 */
public class MyAccessDecisionManager implements AccessDecisionManager {

	Logger logger = LoggerFactory.getLogger(MyAccessDecisionManager.class);
	
	//访问权限匹配
	@Override
	public void decide(Authentication authentication, Object object,
			Collection<ConfigAttribute> configAttributes) 
					throws AccessDeniedException, InsufficientAuthenticationException {
		
		logger.info("开始验证用户是否有访问权限");
		
		String userInfo = "";
		if ((authentication != null) && ((authentication.getPrincipal() instanceof User))){
			
	     	userInfo = ((User)authentication.getPrincipal()).getUsername();
	     	logger.info("当前用户名为：" + userInfo);
	     	if ("initAdmin".equalsIgnoreCase(userInfo)) {	//系统初始化用户，拥有至高无上的权限^_^
	     		return;
	     	}
	    }
		
		if(configAttributes == null || configAttributes.size() == 0){
			throw new AccessDeniedException("没有访问权限！");
		}
		
//		String needRole = "";
//		Iterator ite = configAttributes.iterator();
//	    Iterator it;
//	    for (; ite.hasNext(); it.hasNext()){
//	    	SecurityConfig ca = (SecurityConfig)ite.next();
//
//	    	needRole = ca.getAttribute();
//	    	logger.info("当前操作需要的权限为：" + needRole);
//	    	it = authentication.getAuthorities().iterator();
//	    	if ("PERMIT".equalsIgnoreCase(needRole)) {
//	        	return;
//	    	}
//	        GrantedAuthority ga = (GrantedAuthority)it.next();
//
//	        if (needRole.equals(ga.getAuthority())) {
//	        	return;
//	        }
//	       /* if (cacheList.contains(ga.getAuthority())) {
//	          	return;
//	        }*/
//    	}
		
		Iterator<ConfigAttribute> iterator = configAttributes.iterator();
		while(iterator.hasNext()){
			
			SecurityConfig securityConfig = (SecurityConfig) iterator.next();
			String needPermission = securityConfig.getAttribute();
			logger.info("当前操作需要的权限：" + needPermission);
			
			//不需要鉴权的URL
			if("PERMIT".equalsIgnoreCase(needPermission)) {
				logger.info("该URL不需要鉴权，URL：" + needPermission);
				return;
			}
			
	        //用户所拥有的权限authentication
	        for (GrantedAuthority grantedAuthority : authentication.getAuthorities()) {
	        	System.out.println(needPermission + " <><> " + grantedAuthority.getAuthority());
				if(needPermission.equals(grantedAuthority.getAuthority())){
					return;
				}
			}
	        
	        /*List cacheList = new ArrayList();
	        if(cacheList.contains(ga.getAuthority())) {
	        	return;
	    	}*/
		}
		logger.info("用户访问[" + configAttributes + "]的权限被否定");
		throw new AccessDeniedException("没有权限访问！");
	}
	
	@Override
	public boolean supports(ConfigAttribute attribute) {
		return true;
	}

	//必须返回true
	//否则报错：java.lang.IllegalArgumentException: AccessDecisionManager does not support secure object class: class org.springframework.security.web.FilterInvocation
	@Override
	public boolean supports(Class<?> clazz) {
		return true;
	}

}
