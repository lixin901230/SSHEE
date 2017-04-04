package com.zl.frame.core.security;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.SecurityMetadataSource;
import org.springframework.security.access.intercept.AbstractSecurityInterceptor;
import org.springframework.security.access.intercept.InterceptorStatusToken;
import org.springframework.security.web.FilterInvocation;


/**
 * @desc：1、访问拦截过滤器
 * @author lixin
 * @date: 2014-1-8下午3:19:57
 */
public class MyAuthorizationFilter extends AbstractSecurityInterceptor implements Filter {
	
	Logger logger = LoggerFactory.getLogger(MyAuthorizationFilter.class);
	
	private MySecurityMetadataSource securityMetadataSource;
	
	public MySecurityMetadataSource getSecurityMetadataSource() {
		return securityMetadataSource;
	}
	public void setSecurityMetadataSource(MySecurityMetadataSource securityMetadataSource) {
		this.securityMetadataSource = securityMetadataSource;
		logger.info("成功注入鉴权数据源" + MySecurityMetadataSource.class);
	}
	
	@Override
	public SecurityMetadataSource obtainSecurityMetadataSource() {
		return securityMetadataSource;
	}
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain filterChain) throws IOException, ServletException {
		
		FilterInvocation fi = new FilterInvocation(request, response, filterChain);
        invoke(fi);
	}

	public void invoke(FilterInvocation fi) throws IOException, ServletException {
		
		/*
			核心的InterceptorStatusToken token = super.beforeInvocation(fi);
			会调用我们定义的
			securityMetadataSource:getAttributes(Object object)
			和
			accessDecisionManager:decide(Object object)
		*/
		// ↓↓↓****** super.beforeInvocation(fi) 执行的处理如下    ******↓↓↓
		// 1.获取请求资源的权限    :  MySecurityMetadataSource
		//   Collection<ConfigAttribute> attributes = securityMetadataSource.getAttributes(fi);
		// 2.是否拥有权限         :  MyAccessDecisionManager
		//  1) 获取安全主体，可以强制转换为UserDetails的实例
		//    Authentication authenticated = authenticateIfRequired();
		//    this.accessDecisionManager.decide(authenticated, fi, attributes);
		//  2) 用户拥有的权限GrantedAuthority
		//    Collection<GrantedAuthority> authenticated.getAuthorities()
		// ↑↑↑****** super.beforeInvocation(fi) 执行的处理如上    ******↑↑↑
        InterceptorStatusToken token = super.beforeInvocation(fi);
        try{
        	fi.getChain().doFilter(fi.getRequest(), fi.getResponse());
        } finally{
        	super.afterInvocation(token, null);
        }
    }

	@Override
	public Class<? extends Object> getSecureObjectClass() {
		// 下面的MyAccessDecisionManager的supports方面必须放回true,否则会提醒类型错误
		return FilterInvocation.class;
	}

}
