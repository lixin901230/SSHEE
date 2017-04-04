package com.zl.frame.core.security;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.zl.frame.sysman.resourceman.bean.Resource;
import com.zl.frame.sysman.roleman.bean.Role;
import com.zl.frame.sysman.userman.dao.IUserDao;

/**
 * @desc：认证提供者，给认证管理器提供认证服务
 * @author lixin
 * @date: 2014-1-8下午4:22:05
 * 在UserDetailsService中，如将数据库根据用户名找出的密码放入新创建的UserDetails中，
 * security自动会根据之前登录页面提交的密码和我之后数据库中匹配出的密码进行比较，并返回正确或错误页面;
 * 
 * Spring Security3中loadByUserName(String username)只是根据用户名获取User实体。
 * 具体认证的过程中再验证该账号是否能够认证通过。至于密码判断部分的源码为 
	org.springframework.security.authentication.dao.DaoAuthenticationProvider类
	的additionalAuthenticationChecks方法 
 */
public class MyUserDetailService implements UserDetailsService {

	private Logger logger = LoggerFactory.getLogger(MyUserDetailService.class);
	
	private IUserDao userDao;
	
	public IUserDao getUserDao() {
		return userDao;
	}
	public void setUserDao(IUserDao userDao) {
		logger.info(getClass().getName()+"成功给认证提供者注入用户信息查询接口"+IUserDao.class);
		this.userDao = userDao;
	}

	//登陆验证
	@Override
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {
		
		if(!StringUtils.isNotBlank(username)){
			throw new UsernameNotFoundException("用户名不能为空！");
		}
		
		com.zl.frame.sysman.userman.bean.User ormUser = userDao.findByName(username);
		if(ormUser == null){
			logger.info("认证管理器中根据用户名获取用信息失败，无法为认证提供认证信息！");
			return null;
		}
		
		//取得用户的权限
		Set<GrantedAuthority> dbAuthsSet = new HashSet<GrantedAuthority>();
		dbAuthsSet.addAll(loadUserAuthorities(ormUser));
		
		boolean enabled = true;
		boolean accountNonExpired = true;		//如果账户没有过期设置为true
		boolean credentialsNonExpired = true;	//如果证书没有过期设置为true
		boolean accountNonLocked = true;		//如果不是锁定账户设置为true
		
		// 封装成spring security的user
		User userDetail = new User(username, ormUser.getPassword(), enabled, accountNonExpired, 
				credentialsNonExpired, accountNonLocked, dbAuthsSet);
		return userDetail;
	}
	
	/**
	 * 根据用户名获取用户用的授权信息
	 * @param userName
	 * @return
	 */
	public Set<GrantedAuthority> loadUserAuthorities(com.zl.frame.sysman.userman.bean.User ormUser){
		
		logger.info("加载用户["+ormUser.getUserName()+"]的权限");
		
		Set<GrantedAuthority> authorities = new HashSet<GrantedAuthority>();
		try {
			
			Set<Resource> resources = new HashSet<Resource>();
			List<Role> roles = ormUser.getRoleList();
			for (Role role : roles) {
				
				List<Resource> resourecesTemp = role.getResourceList();
				resources.addAll(resourecesTemp);
			}
			
			for (Resource resource : resources) {
				// TODO: 用户可以访问的资源名称（或者说用户所拥有的权限） 注意：必须"ROLE_"开头
				// 关联代码：applicationContext-security.xml
				// 关联代码：com.lx.system.security.MySecurityMetadataSource#loadResourceDefine
				
//			authSet.add(new SimpleGrantedAuthority("ROLE_" + res.getName()));
				authorities.add(new SimpleGrantedAuthority(resource.getResourceCode()));
			}
			
			logger.info("成功加载用户["+ormUser.getUserName()+"]的权限");
		} catch (Exception e) {
			
			logger.debug("加载用户["+ormUser.getUserName()+"]的权限失败");
			e.printStackTrace();
		}
		return authorities;
	}

}
