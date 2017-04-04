package com.zl.frame.core.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.access.SecurityConfig;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.intercept.FilterInvocationSecurityMetadataSource;

import com.zl.frame.core.security.entity.Permition;
import com.zl.frame.core.security.util.AntUrlPathMatcher;
import com.zl.frame.core.security.util.UrlMatcher;
import com.zl.frame.sysman.resourceman.bean.Resource;
import com.zl.frame.sysman.resourceman.dao.IResourceDao;

/**
 * @desc：加载资源与权限的对应关系
 * @author lixin
 * @date: 2014-1-8下午3:28:52
 */
public class MySecurityMetadataSource implements FilterInvocationSecurityMetadataSource {

	private Logger logger = LoggerFactory.getLogger(MySecurityMetadataSource.class);
	
	private IResourceDao resourceDao;
	
	private Map<String, Collection<ConfigAttribute>> resourceMap;
	private List<String> permit;
	
	/**
	 * 初始化MySecurityMetadataSource时加载系统的所有资源权限信息到内存中
	 * spring注入MySecurityMetadataSource初始化时调用
	 * @param resourceDao
	 */
	public MySecurityMetadataSource(IResourceDao resourceDao) {
		
		logger.info(getClass().getName()+"鉴权数据源过滤器注入资源查询接口"+IResourceDao.class);
		this.resourceDao = resourceDao;
		loadResourceDefine();
	}


	//返回所请求资源所需要的权限
	@Override
	public Collection<ConfigAttribute> getAttributes(Object object)
			throws IllegalArgumentException {
		
		UrlMatcher urlMatcher = new AntUrlPathMatcher();
		
		logger.info("查询当前请求的资源所需要的权限...");
		
		Collection<ConfigAttribute> configAttributes = new ArrayList<ConfigAttribute>();
		
		if ((object == null) || (!supports(object.getClass()))) {
		      throw new AccessDeniedException("Object must be a FilterInvocation");
	    }
		
		String requestUrl = ((FilterInvocation) object).getRequestUrl();
		logger.info("当前请求的RUL：" + requestUrl);
		
//		boolean ignoredUrl = (requestUrl.contains(".css")) || (requestUrl.contains(".js")) || 
//				(requestUrl.contains(".png")) || (requestUrl.contains(".jpeg")) || 
//				(requestUrl.contains(".jpg")) || (requestUrl.contains(".swf")) || 
//				(requestUrl.contains(".gif")) || (requestUrl.contains(".bmp"));
//	    if (!ignoredUrl) {
//	    	if (StringUtils.isEmpty(requestUrl)) {
//	        	throw new AccessDeniedException("访问方式错误，未获取到相关的url地址");
//	    	}
//	    }
//		if (!ignoredUrl) {
//			logger.info("查询完成，访问所需要的权限信息为: " + configAttributes);
//	    }
		
	    if (permit != null) {
	    	for (String resURL : permit) {	
	    		
	    		//判断该URL是否为非鉴权拦截的URL（当前请求的URL循环匹配security配置中不进行鉴权拦截的URL）
	    		if (urlMatcher.pathMatchesUrl(resURL.trim(), requestUrl)) {
	    			
	    			//设置该URL忽略鉴权，在访问决策管理器中根据该字符串PERMIT区分不需要鉴权拦截的URL并放行
	    			configAttributes.add(new SecurityConfig("PERMIT"));	
	    			break;
	    		}
	    	}
	    }
	    if (configAttributes.size() > 0) {
	    	return configAttributes;	//返回忽略鉴权的URL集合
	    }
		
		if (resourceMap == null) {
			loadResourceDefine();
		}
		configAttributes = resourceMap.get(requestUrl);
		
		/**
		 * 以下部分为自己所加：
		 * 问题：如果上一行代码通过用户请求的url（requestUrl）从resourceMap（系统所有权限缓存map）中匹配该请求所需要的权限时，
		 * 		如果根据该url不能从全局权限map（resourceMap）中找到对应的权限，则configAttributes=null，此时，
		 * 		将不会进入MyAccessDecisionManager中的decide方法对该用户请求的当前资源进行资源权限鉴别
		 * 
		 *		解决以上问题，关键在于让用户发送的url，必须能够从全局权限map中（resourceMap）中找到的该资源访
		 * 		问所需要的对应的权限，获取到该资源访问所需要的权限后，再到MyAccessDecisionManager中的decide方
		 * 		法中根据访问该资源（即发送的url） 所需要的权限与当前用户所拥有的权限进行匹配，如果该用户原本拥
		 * 		有访问该资源的权限，则能够成功匹配并继续访问该资源，否则该用户没有访问该资源权限，则禁止访问!
		 * 			
		 * 		所以，必须让每个用户发送的请求（url）都必须能从resourceMap中找到对应的访问权限。才能进行下一步
		 * 		资源访问需要的权限与用户权限比较对用户的访问进行拦截或放行！
		 * 
		 * 例：	用户访问的url可能是动态的，没法做匹配，像删除、修改时，需要在url后面传id，那么类似这些url就是动态的了，
		 * 		没法在资源表中的url列设置值，也就没法匹配；如：/notice!getNoticeDetail.action?Id=4，等等...
		 * 
		 * 解决方案 ：在匹配时使用【正则匹配】或者【截取匹配】；只匹配?号前面的url部分，?后面的参数部分不匹配或者用*号匹配参数部分
		 * 			resourceMap = {/notice!addNotice.action=[ROLE_addNotice],/notice!delNotice.action*=[ROLE_delNotice],
		 * 							/notice!getNoticeDetail.action?notice.noticeId=4=[ROLE_getNoticeDetail]}
		 */
		if(configAttributes == null && requestUrl.contains("?")){	//匹配带?的有参数的URL，参数部分用*匹配或者去掉参数部分再匹配
			
			String requestUrlPart = requestUrl.substring(0, requestUrl.indexOf("?"))+"*";
			configAttributes = resourceMap.get(requestUrlPart);
			
			if(configAttributes == null){	//如果用*匹配url后面带?的参数部分仍未获取到，则直接去掉带?好的参数部分再匹配
				configAttributes = resourceMap.get(requestUrl.substring(0, requestUrl.indexOf("?")));
			}
		}
		
	    if (configAttributes == null) {
	    	configAttributes = new ArrayList<ConfigAttribute>();
	    }
		return configAttributes;
	}
	
	/**
	 * 加载所有资源与权限的关系
	 */
	public void loadResourceDefine(){
		
		logger.info("加载所有资源与权限的关系");
		
		try {
			resourceMap = new HashMap<String, Collection<ConfigAttribute>>();
			List<Resource> resources = resourceDao.findAllByCriteria();
			for (Resource resource : resources) {
				Collection<ConfigAttribute> configAttributes = new ArrayList<ConfigAttribute>();
				
				logger.info("资源编码为>>>>>>	"+resource.getResourceCode());
				ConfigAttribute configAttribute = new SecurityConfig(resource.getResourceCode());
				configAttributes.add(configAttribute);
				resourceMap.put(resource.getUrl(), configAttributes);
			}
			logger.info("成功加载所有资源与权限的关系");
		} catch (Exception e) {
			logger.debug("加载所有资源与权限的关系失败");
			e.printStackTrace();
		}
	}
	
	@Override
	public Collection<ConfigAttribute> getAllConfigAttributes() {
		return null;
	}
	
	//必须返回true
	//否则报错：java.lang.IllegalArgumentException: SecurityMetadataSource does not support secure object class: class org.springframework.security.web.FilterInvocation
	@Override
	public boolean supports(Class<?> clazz) {
		return true;
	}

	public Map<String, Collection<ConfigAttribute>> getResourceMap() {
		return resourceMap;
	}
	public void setResourceMap(Map<String, Collection<ConfigAttribute>> resourceMap) {
		this.resourceMap = resourceMap;
	}

	public void setPermit(Permition permit) {
		this.permit = permit.getPermitions();
	}
	
	public IResourceDao getResourceDao() {
		return resourceDao;
	}
	public void setResourceDao(IResourceDao resourceDao) {
		logger.info(getClass().getName()+"鉴权数据源过滤器成功注入资源查询接口"+IResourceDao.class);
		this.resourceDao = resourceDao;
	}
}
