package com.zl.frame.sysman.usergroupman.action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.zl.frame.core.pager.Page;
import com.zl.frame.core.util.DataGrid;
import com.zl.frame.core.util.Json;
import com.zl.frame.core.util.JsonUtil;
import com.zl.frame.core.util.ToolClass;
import com.zl.frame.core.web.BaseAction;
import com.zl.frame.sysman.usergroupman.bean.UserGroup;
import com.zl.frame.sysman.usergroupman.service.IUserGroupService;
import com.zl.frame.sysman.userman.bean.User;
import com.zl.frame.sysman.userman.service.IUserService;

/**
 * @desc：用户组组管理Action
 * @author lixin
 * @date: 2013-11-19下午2:40:58
 */
public class UserGroupAction extends BaseAction {

	private static final long serialVersionUID = 2531891003585062840L;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	private Page<UserGroup> pager = new Page<UserGroup>();
	private Page<User> usersPage = new Page<User>();
	
	private UserGroup userGroup;			//ORM对象
	private List<User> users;
	private String[] id;					//用户组id数组，批量删除使用
	private String userGroupId;
	private String userIds;
	
	private IUserGroupService userGroupService;
	private IUserService userService;
	
	/**
	 * 去用户组列表页面
	 * @return
	 */
	public String toUserGroupListPage(){
		logger.info("加载用户组信息列表页面...");
		return "userGroupList";
	}
	
	/**
	 * 分页查询用户组信息，显示用户组列表
	 */
	public void findUserGroupList(){
		
		logger.info("获取用户组信息列表数据开始...");
		try {
			StringBuffer hql = new StringBuffer(" from UserGroup u where 1=1 ");
			
			//查询条件，考虑封装一个查询条件类处理
			List<Object> params = new ArrayList<Object>();
			/*if(userVo != null){
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
			}*/
			hql.append(" order by u.id desc ");
			
			pager = userGroupService.findUserGroupListByPage(hql.toString(), pager, params.toArray());
			DataGrid dataGrid = new DataGrid(Long.valueOf(pager.getTotalRow()), pager.getData());
			writeJson(JsonUtil.obj2json(dataGrid));
//			writeJson(JsonUtil.objToJson(dataGrid, new String[]{"roleList"}, null));
			
			logger.info("获取用户组信息列表数据成功");
		} catch (Exception e) {
			logger.debug("获取用户组信息列表数据失败，原因："+e.getMessage());
			e.printStackTrace();
		}
	}
	
	/**
	 * 显示用户组详细信息
	 * @return
	 */
	public String showUserGroupDetail(){
		
		logger.info("开始根据用户组ID加载用户详细信息");
		try {
			String userGroupId = userGroup.getId();
			userGroup = userGroupService.findUserGroupById(userGroupId);
			
			logger.info("成功在用户组["+userGroupId+"]详细信息");
		} catch (Exception e) {
			
			logger.debug("根据用户组ID加载用户组信息失败");
			e.printStackTrace();
		}
		return "userGroupDetail";
	}
	
	/**
	 * 去添加用户组页面
	 * @return
	 */
	public String toAddUserGroupPage(){
		logger.info("加载添加用户组信息页面");
		return "userGroupAdd";
	}
	
	/**
	 * 添加用户组信息
	 */
	public void addSaveUserGroup(){
		
		try {
			logger.info("开始保存用户组信息...");
			
			userGroup.setCreateTime(new Timestamp(new Date().getTime()));
			userGroup.setLastUpdateTime(new Timestamp(new Date().getTime()));
			userGroup.setGroupCode(ToolClass.getUUID());
			userGroupService.saveOrUpdateUserGroup(userGroup);
			
			logger.info("成功保存一条用户组信息。");
		} catch (Exception e) {
			
			logger.debug("添加用户组失败；原因："+e.getMessage());
			e.printStackTrace();
		}
	}
	
	/**
	 * 去修改用户组页面
	 * @return
	 */
	public String toEditUserGroupPage(){
		
		try {
			logger.info("开始加载用户组修改页面信息，用户组ID："+userGroup.getId());

			userGroup = userGroupService.findUserGroupById(userGroup.getId());
			
			logger.info("成功加载用户组修改页面信息，用户组ID："+userGroup.getId());
		} catch (Exception e) {
			
			logger.debug("加载用户组修改页面信息，用户组ID："+userGroup.getId()+"；原因："+e.getMessage());
			e.printStackTrace();
		}
		return "userGroupEdit";
	}
	
	/**
	 * 修改保存用户组信息
	 */
	public void editSaveUserGroup(){
		
		try {
			logger.info("开始保存修改用户组信息，用户组ID："+userGroup.getId());
			
			userGroup.setLastUpdateTime(new Timestamp(new Date().getTime()));
			userGroupService.saveOrUpdateUserGroup(userGroup);
			
			logger.info("开始保存修改用户组信息，用户组ID："+userGroup.getId());
		} catch (Exception e) {
			
			logger.debug("保存修改用户组信息失败，用户组ID："+userGroup.getId()+"；原因："+e.getMessage());
			e.printStackTrace();
		}
	}
	
	/**
	 * 删除用户组信息
	 */
	public void deleteUserGroup(){
		
		boolean success = true;
		String msg = "删除用户组成功";
		try {
			logger.info("开始删除一条用户组信息");
			
			//此处后期采用批量操作接口执行
			for (String userGroupId : id) {
				userGroupService.deleteUserGroupById(userGroupId);
//				UserGroup userGroupTemp = userService.findUserGroupById(userGroupId);
//				userService.deleteUserGroup(userGroupTemp);
			}
			
			logger.info("成功删除一条用户组信息");
		} catch (Exception e) {
			
			success = false;
			msg = "删除用户组失败";
			logger.debug("删除用户组失败，原因："+e.getMessage());
			e.printStackTrace();
		}
		try {
			writeJson(JsonUtil.obj2json(new Json(success, msg)));
		} catch (Exception e) {
			logger.debug("返回提示信息失败");
			e.printStackTrace();
		}
	}
	
	/**
	 * 导出用户组（Excel）
	 */
	public void exportUserGroupToExcel(){
		
	}
	
	/**
	 * 下载导入用户组模板（Excel）
	 */
	public void downImportUserGroupExcelTemplate(){
		
	}
	
	/**
	 * 导入用户组（Excel）
	 */
	public void importUserGroupByExcel(){
		
	}
	
	//======================	操作用户组中的用户	===================
	
	/**
	 * @desc 根据用户组ID获取该用户组下的用户列表
	 * @return
	 * @author lixin
	 * @date 2014-2-18下午5:04:06
	 */
	public void findUserListByUserGroupId(){
		
		logger.info("开始根据用户组ID获取该用户组下的用户列表");
		
		try {
			StringBuffer sql = new StringBuffer("select u.id,u.userName,u.sex,u.telphone,u.email,u.statu,");
			sql.append("u.createTime,u.lastUpdateTime,u.remark from t_sys_user u ");
			sql.append("inner join t_sys_user$user_group uug on u.id=uug.userId ");
			sql.append("inner join t_sys_user_group ug on ug.id=uug.userGroupId where ug.id=?");
			
			usersPage = userService.findUserListPageBySql(sql.toString(), usersPage, new String[]{userGroup.getId()});
			DataGrid dataGrid = new DataGrid(Long.valueOf(usersPage.getTotalRow()), usersPage.getData());
			writeJson(JsonUtil.obj2json(dataGrid));
			
			logger.info("成功获取用户组["+userGroup.getId()+"]拥有的用户列表");
		} catch (Exception e) {
			
			logger.debug("获取用户组下的用户信息失败");
			e.printStackTrace();
		}
	}
	
	/**
	 * @desc 去加入用户到用户组页面
	 * @return
	 * @author lixin
	 * @date 2014-2-18下午4:44:47
	 */
	public String toAddUserToUserGroupPage(){
		
		logger.info("加载添加用户到用户组表单页面");
		return "addUserToUserGroup";
	}
	
	/**
	 * @desc 保存加入用户组的用户信息
	 * @author lixin
	 * @date 2014-2-18下午4:47:18
	 */
	public void addUserToUserGroup(){
		
		logger.info("开始加入用户["+userIds+"]到用户组....");
		try {
			Object[] params = new Object[userIds.split(",").length];
			String[] userIdArr = userIds.split(",");
			for (int i = 0; i < userIdArr.length; i++) {
				params[i] = Integer.parseInt(userIdArr[i]);
			}
			
			StringBuffer hql = new StringBuffer("from User u where u.id in(");
			if(params != null && params.length > 0){
				for (int i = 1; i <= params.length; i++) {
					if(i == params.length){
						hql.append("?");
					} else {
						hql.append("?,");
					}
				}
			}
			hql.append(")");
			
			List<User> users = userService.findAllUserList(hql.toString(), params);
			userGroup = userGroupService.findUserGroupById(userGroupId);
			userGroup.setUserList(users);
			userGroupService.saveOrUpdateUserGroup(userGroup);
			
			logger.info("成功加入用户["+userIds+"]到用户组");
		} catch (Exception e) {
			
			logger.debug("加入用户["+userIds+"]到用户组失败，原因："+e.getMessage());
			e.printStackTrace();
		}
	}
	
	/**
	 * @desc 从用户组中移除用户信息 
	 * @author lixin
	 * @date 2014-2-18下午4:52:34
	 */
	public void removeUserByUserGrou(){
		
	}
	
	/**
	 * @desc 导出用户组中的用户信息 
	 * @author lixin
	 * @date 2014-2-18下午4:53:16
	 */
	public void exportUserGroupUsers(){
		
	}

	public UserGroup getUserGroup() {
		return userGroup;
	}

	public void setUserGroup(UserGroup userGroup) {
		this.userGroup = userGroup;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public String[] getId() {
		return id;
	}

	public void setId(String[] id) {
		this.id = id;
	}

	public IUserGroupService getUserGroupService() {
		return userGroupService;
	}

	public void setUserGroupService(IUserGroupService userGroupService) {
		this.userGroupService = userGroupService;
	}

	public IUserService getUserService() {
		return userService;
	}

	public void setUserService(IUserService userService) {
		this.userService = userService;
	}

	public String getUserGroupId() {
		return userGroupId;
	}

	public void setUserGroupId(String userGroupId) {
		this.userGroupId = userGroupId;
	}

	public String getUserIds() {
		return userIds;
	}

	public void setUserIds(String userIds) {
		this.userIds = userIds;
	}

//	public Page<UserGroup> getPage() {
//		return page;
//	}
//
//	public void setPage(Page<UserGroup> page) {
//		this.page = page;
//	}
//
//	public Page<User> getUsersPage() {
//		return usersPage;
//	}
//
//	public void setUsersPage(Page<User> usersPage) {
//		this.usersPage = usersPage;
//	}

}
