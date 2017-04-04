package com.zl.frame.core.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.zl.frame.core.security.cache.UserRightCache;
import com.zl.frame.sysman.userman.bean.User;
import com.zl.frame.sysman.userman.dao.IUserDao;

/**
 * @desc：认证过滤器
 * @author lixin
 * @date: 2014-1-8下午2:50:32
 */
public class MyAuthenticationFilter extends UsernamePasswordAuthenticationFilter {
	
	Logger logger = LoggerFactory.getLogger(MyAuthenticationFilter.class);
	
	/**
	 * 登陆页面中用户名和密码输入框的name属性值，此处沿用springSecurity默认值，
	 * 如需要更改可通过在springSecurity配置的认证管理bean中注入下面属性进行修改usernameParameter和passwordParameter即可
	 */
	private static final String SPRING_SECURITY_FORM_USERNAME_KEY = "j_username";
	private static final String SPRING_SECURITY_FORM_PASSWORD_KEY = "j_password";
	private static final String DEFAULT_FILTER_PROCESSES_URL = "/j_spring_security_check";
	
	private String usernameParameter = SPRING_SECURITY_FORM_USERNAME_KEY;
    private String passwordParameter = SPRING_SECURITY_FORM_PASSWORD_KEY;
    
    //若需要在认证管理器中修改该属性，则当前认证管理器需继承实现AbstractAuthenticationProcessingFilter
    @SuppressWarnings("unused")
	@Deprecated
    private String filterProcessesUrl = DEFAULT_FILTER_PROCESSES_URL;	
	
	private boolean postOnly = true;	//是否只支持http post请求，默认仅仅只支持post请求

	private IUserDao userDao;
	private UserDetailsService userDetailsService = null;
	
	//认证
	@Override
	public Authentication attemptAuthentication(HttpServletRequest request,
			HttpServletResponse response) throws AuthenticationException {
		
		if (postOnly && !request.getMethod().equals("POST")) {
			logger.info("不支持请求："+request.getMethod()+"；只支持HTTP POST请求方式");
            throw new AuthenticationServiceException("Authentication method not supported: " + request.getMethod());
        }

        String userName = obtainUsername(request);
        String password = obtainPassword(request);
        
        logger.info("认证准备，成功获取到用户名["+userName+"]和用户密码[***********]");

        //认证
        User user = userDao.findByName(userName);
        logger.info("认证开始...");
        if(user == null){
        	
        	logger.info("登陆失败，账号不存在！");
        	
        	BadCredentialsException exception = new BadCredentialsException("登陆失败，账号不存在！");
        	request.setAttribute(WebAttributes.AUTHENTICATION_EXCEPTION, exception);
        	throw exception;
        }
        if(user != null && !user.getPassword().trim().equals(password.trim())){
        	
        	logger.info("登陆失败，登陆密码错误！");
        	
        	BadCredentialsException exception = new BadCredentialsException("登陆失败，登陆密码错误！");
        	request.setAttribute(WebAttributes.AUTHENTICATION_EXCEPTION, exception);
        	throw exception;
        }
        
        logger.info("认证成功！");
        
//        cacheUserRights(userName);//登录成功用户权限缓存操作已移到证提供者MyAuthenticationProvider中
        
        // 实现 Authentication
        UsernamePasswordAuthenticationToken authRequest = new UsernamePasswordAuthenticationToken(userName, password);

        // 允许子类设置详细属性
        setDetails(request, authRequest);
        
        // 运行UserDetailsService的loadUserByUsername 再次封装Authentication
        Authentication authentication = getAuthenticationManager().authenticate(authRequest);
        
        SecurityContextHolder.getContext().setAuthentication(authentication); 
        
        return authentication;
	}
	
	/**
	 * 弃用，该方法已提取到认证提供者MyAuthenticationProvider中实现
	 * 
	 * @desc 缓存用户的权限信息到缓存对象中
	 * <li>1、获取SpringSecurity的用户对象UserDetails</li>
	 * <li>2、从SpringSecurity提供的用户对象UserDetails中获取当前用户拥有的权限集合Collection</li>
	 * <li>3、将当前用户拥有的权限集合Collection放入缓存对象UserRightCache中的用户权限Map中</li>
	 * @param userName 用户名
	 * @author lixin
	 * @date 2014-1-13上午11:41:57
	 */
	@Deprecated
	public void cacheUserRights(String userName){
		
		logger.info("获取springsecurity权限用户对象org.springframework.security.core.userdetails.UserDetails，并从该对象中取出该用户拥有的权限集合存入缓存对象中");
        UserDetails userDetials = null;
		try {
			userDetials = userDetailsService.loadUserByUsername(userName);
		} catch (Exception e) {
			logger.debug("获取springSecurity权限用户对象org.springframework.security.core.userdetails.UserDetails失败");
			e.printStackTrace();
		}
        Collection<? extends GrantedAuthority> authorities = userDetials.getAuthorities();
        
        List<String> rights = new ArrayList<String>();
        if(authorities != null && authorities.size() > 0){
        	for (GrantedAuthority auth : authorities) {
        		rights.add(auth.getAuthority());
        	}
        }
        //缓存当前登录用户拥有的所有权限信息
        UserRightCache.pushUserRight(userName, rights);
	}
	
	@Override
	protected String obtainUsername(HttpServletRequest request) {
		String userName = request.getParameter(usernameParameter);
		return userName == null ? "" : userName.trim();
	}
	
	@Override
	protected String obtainPassword(HttpServletRequest request) {
		String password = request.getParameter(passwordParameter);
		return password == null ? "" : password;
	}
	
	@Override
	protected void setDetails(HttpServletRequest request,
			UsernamePasswordAuthenticationToken authRequest) {
		super.setDetails(request, authRequest);
	}
	
	/**
	 * 是否只能允许POST请求方式
     * Defines whether only HTTP POST requests will be allowed by this filter.
     * If set to true, and an authentication request is received which is not a POST request, an exception will
     * be raised immediately and authentication will not be attempted. The <tt>unsuccessfulAuthentication()</tt> method
     * will be called as if handling a failed authentication.
     * <p>
     * Defaults to <tt>true</tt> but may be overridden by subclasses.
     */
    public void setPostOnly(boolean postOnly) {
        this.postOnly = postOnly;
    }
    
    
    //=====getter,setter=====================================
    
	public void setUserDao(IUserDao userDao) {
		this.userDao = userDao;
	}
	public void setUsernameParameter(String usernameParameter) {
		this.usernameParameter = usernameParameter;
	}
	public void setPasswordParameter(String passwordParameter) {
		this.passwordParameter = passwordParameter;
	}
	public void setFilterProcessesUrl(String filterProcessesUrl) {
		this.filterProcessesUrl = filterProcessesUrl;
	}
	public void setUserDetailsService(UserDetailsService userDetailsService) {
		this.userDetailsService = userDetailsService;
	}
	
}
