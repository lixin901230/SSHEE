package com.zl.frame.core.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.dao.AbstractUserDetailsAuthenticationProvider;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;

import com.zl.frame.core.security.cache.UserRightCache;

/**
 * @desc：认证管理器的提供者，给认证管理器提供认证服务
 * <li>扩展认证提供者使扩展性更好
 * @author lixin
 * @date: 2014-1-13下午3:57:40
 */
public class MyAuthenticationProvider extends AbstractUserDetailsAuthenticationProvider {
	
	private Logger logger = LoggerFactory.getLogger(MyAuthenticationProvider.class);
	
	private UserDetailsService userDetailsService;
	
	/**
	 * @desc 缓存用户的权限信息到缓存对象中
	 * <li>1、获取SpringSecurity的用户对象UserDetails</li>
	 * <li>2、从SpringSecurity提供的用户对象UserDetails中获取当前用户拥有的权限集合Collection</li>
	 * <li>3、将当前用户拥有的权限集合Collection放入缓存对象UserRightCache中的用户权限Map中</li>
	 * @param UserDetails 用户对象
	 * @author lixin
	 * @date 2014-1-13上午11:41:57
	 */
	public void cacheUserRights(UserDetails userDetials){
		
		
        Collection<? extends GrantedAuthority> authorities = userDetials.getAuthorities();
        
        List<String> rights = new ArrayList<String>();
        if(authorities != null && authorities.size() > 0){
        	for (GrantedAuthority auth : authorities) {
        		rights.add(auth.getAuthority());
        	}
        }
        //缓存当前登录用户拥有的所有权限信息
        UserRightCache.pushUserRight(userDetials.getUsername(), rights);
	}

	@Override
	protected UserDetails retrieveUser(String username,
			UsernamePasswordAuthenticationToken authentication)
			throws AuthenticationException {
		
		logger.info("认证提供者获取springsecurity权限用户对象org.springframework.security.core.userdetails.UserDetails，并从该对象中取出该用户拥有的权限集合存入缓存对象中");

		UserDetails userDetails = null;
		try {
			userDetails = userDetailsService.loadUserByUsername(username);
		} catch (Exception e) {
			
			logger.debug("获取springSecurity权限用户对象org.springframework.security.core.userdetails.UserDetails失败");
			e.printStackTrace();
		}
		
		if(userDetails != null){
			cacheUserRights(userDetails);
		}
		
		return userDetails;
	}
	
	/*
	 * 密码判断部分
	 * Spring Security3中loadByUserName(String username)只是根据用户名获取User实体。
 * 		具体认证的过程中再验证该账号是否能够认证通过。至于密码判断部分的源码为 
		org.springframework.security.authentication.dao.DaoAuthenticationProvider类
		的additionalAuthenticationChecks方法 
	 * (non-Javadoc)
	 * @see org.springframework.security.authentication.dao.AbstractUserDetailsAuthenticationProvider#additionalAuthenticationChecks(org.springframework.security.core.userdetails.UserDetails, org.springframework.security.authentication.UsernamePasswordAuthenticationToken)
	 */
	@Override
	protected void additionalAuthenticationChecks(UserDetails userDetails,
			UsernamePasswordAuthenticationToken authentication)
			throws AuthenticationException {
		
//		UserDetails currentUser = (UserDetails) authentication.getPrincipal();
//		if(!userDetails.getPassword().trim().equals(currentUser.getPassword())){
//			
//		}
	}

	public void setUserDetailsService(UserDetailsService userDetailsService) {
		this.userDetailsService = userDetailsService;
	}
	
}
