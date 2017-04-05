package com.zl.frame.sysman.authorizationman.action;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.zl.frame.core.pager.Page;
import com.zl.frame.core.util.DataGrid;
import com.zl.frame.core.util.DateUtil;
import com.zl.frame.core.util.JsonUtil;
import com.zl.frame.core.web.BaseAction;
import com.zl.frame.sysman.authorizationman.service.IAuthService;
import com.zl.frame.sysman.orgman.service.IOrgInfoService;
import com.zl.frame.sysman.roleman.bean.Role;
import com.zl.frame.sysman.roleman.service.IRoleService;
import com.zl.frame.sysman.userman.bean.User;
import com.zl.frame.sysman.userman.service.IUserService;
import com.zl.frame.sysman.userman.vo.UserVo;

/**
 * @desc：授权综合管理模块Action
 * @author lixin
 * @date: 2014-3-7下午2:25:02
 */
public class AuthAction extends BaseAction {

	private static final long serialVersionUID = -803643771284507409L;
	
	private Page<User> userPage = new Page<User>();
	
	private User user;			//ORM对象
	private UserVo userVo;		//数据数传对象

	private IAuthService authService;
	private IUserService userService;
	private IRoleService roleService;
	private IOrgInfoService orgInfoService;
	
	
	//**************************	用户授权 		************************************
	
	/**
	 * 加载已授权用户列表页面
	 * @return
	 */
	public String toAuthUserListPage(){
		
		logger.info("加载已授权用户列表页面...");
		return "authUserList";
	}
	
	/**
	 * @desc 获取已授权用户列表
	 * @return
	 * @author lixin
	 * @date 2014-3-7下午4:40:33
	 */
	public void findAuthUsers(){
		
		logger.info("获取已授权用户信息列表数据开始...");
		try {
			StringBuffer hql = new StringBuffer(" from User u where 1=1 ");
			
			//查询条件，考虑封装一个查询条件类处理
			List<Object> params = new ArrayList<Object>();
			if(userVo != null){
				if(StringUtils.isNotBlank(userVo.getUserName())){
					hql.append(" and u.userName like ? ");
					params.add("%"+userVo.getUserName()+"%");
				}
				if(StringUtils.isNotBlank(userVo.getCreateTimeStart())){
					hql.append(" and u.createTime > ? ");
					params.add(DateUtil.formatDate(userVo.getCreateTimeStart(), DateUtil.YYYYMMDDHHMMSS));
				}
				if(StringUtils.isNotBlank(userVo.getCreateTimeEnd())){
					hql.append(" and u.createTime < ? ");
					params.add(DateUtil.formatDate(userVo.getCreateTimeEnd(), DateUtil.YYYYMMDDHHMMSS));
				}
				if(StringUtils.isNotBlank(userVo.getLastUpdateTimeStart())){
					hql.append(" and u.lastUpdateTime > ? ");
					params.add(DateUtil.formatDate(userVo.getLastUpdateTimeStart(), DateUtil.YYYYMMDDHHMMSS));
				}
				if(StringUtils.isNotBlank(userVo.getLastUpdateTimeEnd())){
					hql.append(" and u.lastUpdateTime < ? ");
					params.add(DateUtil.formatDate(userVo.getLastUpdateTimeEnd(), DateUtil.YYYYMMDDHHMMSS));
				}
			}
			
			StringBuffer queryHql = new StringBuffer();
			queryHql.append(" order by u.id desc ");
			
			StringBuffer countHql = new StringBuffer();
			countHql.append("select count(*) ");
			countHql.append(hql);
			
			userPage = userService.findUserListByPage(queryHql.toString(), countHql.toString(), userPage, params.toArray());
			DataGrid dataGrid = new DataGrid(Long.valueOf(userPage.getTotalRow()), userPage.getData());
			writeJson(JsonUtil.obj2json(dataGrid));
//			writeJson(JsonUtil.objToJson(dataGrid, new String[]{"roleList"}, null));
			
			logger.info("获取已授权用户信息列表数据成功");
		} catch (Exception e) {
			logger.debug("获取已授权用户信息列表数据失败，原因："+e.getMessage().toString());
			e.printStackTrace();
		}
	}
	
	/**
	 * @desc 加载新增授权页面
	 * @return
	 * @author lixin
	 * @date 2014-4-1下午5:45:50
	 */
	public String toAuthAddPage(){
		logger.info("加载新增授权页面");
		return "authAdd";
	}
	
	/**
	 * @desc 加载新增授权页面角色下拉选项的值
	 * @author lixin
	 * @date 2014-4-2下午4:08:04
	 */
	public void loadRole(){
		
		logger.info("加载初始化角色下拉选项数据...");
		
		try {
			String hql = "from Role";
			List<Role> roles = authService.findAllRoleByHql(hql, null);
			writeJson(roles);
			
			logger.info("成功加载初始化角色下拉选项数据！");
		} catch (Exception e) {
			logger.debug("加载初始化角色下拉选项数据失败，原因："+e.getMessage().toString());
			e.printStackTrace();
		}
	}
	
	/**
	 * @desc 保存新增授权信息
	 * @author lixin
	 * @date 2014-4-1下午5:50:11
	 */
	public void addSaveAuth(){
		
	}
	
	/**
	 * @desc 加载未授权的用户信息
	 * @author lixin
	 * @date 2014-4-1下午5:47:06
	 */
	public void findUnAuthUserList(){
		
		try {
			logger.info("开始加载未授权的用户信息");
			
			String hql = "from User";
			String countHql = "select count(*) from User";
			List<Object> params = new ArrayList<Object>();
			
			userPage = authService.findUnAuthUserList(hql, countHql, userPage, params.toArray());
			userPage = userService.findUserListByPage(hql, countHql, userPage, params.toArray());
			DataGrid dataGrid = new DataGrid(Long.valueOf(userPage.getTotalRow()), userPage.getData());
			writeJson(JsonUtil.obj2json(dataGrid));
			
			logger.info("成功加载未授权的用户信息");
		} catch (Exception e) {
			
			logger.debug("加载未授权的用户信息失败，原因："+e.getMessage().toString());
			e.printStackTrace();
		}
	}
	
	/**
	 * @desc 加载已授权用户列表
	 * @author lixin
	 * @date 2014-4-1下午5:48:55
	 */
	public void loadAuthUserList(){
		
	}
	
	/**
	 * @desc 加载编辑授权页面
	 * @author lixin
	 * @date 2014-4-1下午5:49:07
	 */
	public void toEditAuthPage(){
		
	}
	
	/**
	 * @desc 保存编辑授权信息
	 * @author lixin
	 * @date 2014-4-1下午5:50:30
	 */
	public void editSaveAuth(){
		
	}
	
	/**
	 * @desc 移除授权信息 
	 * @author lixin
	 * @date 2014-4-1下午5:50:57
	 */
	public void removeAuth(){
		
	}
	
	
	//参数、bean注入
//	public Page<User> getPage() {
//		return page;
//	}
//	public void setPage(Page<User> page) {
//		this.page = page;
//	}
	//bean注入的getter,setter方法
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public UserVo getUserVo() {
		return userVo;
	}
	public void setUserVo(UserVo userVo) {
		this.userVo = userVo;
	}
	public IAuthService getAuthService() {
		return authService;
	}
	public void setAuthService(IAuthService authService) {
		this.authService = authService;
	}
	public IUserService getUserService() {
		return userService;
	}
	public void setUserService(IUserService userService) {
		this.userService = userService;
	}
	public IRoleService getRoleService() {
		return roleService;
	}
	public void setRoleService(IRoleService roleService) {
		this.roleService = roleService;
	}
	public IOrgInfoService getOrgInfoService() {
		return orgInfoService;
	}
	public void setOrgInfoService(IOrgInfoService orgInfoService) {
		this.orgInfoService = orgInfoService;
	}
}
