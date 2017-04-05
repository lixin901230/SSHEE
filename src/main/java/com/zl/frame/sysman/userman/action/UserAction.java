package com.zl.frame.sysman.userman.action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.zl.frame.core.pager.Page;
import com.zl.frame.core.util.DataGrid;
import com.zl.frame.core.util.DateUtil;
import com.zl.frame.core.util.Json;
import com.zl.frame.core.util.JsonUtil;
import com.zl.frame.core.web.BaseAction;
import com.zl.frame.sysman.resourceman.bean.Resource;
import com.zl.frame.sysman.resourceman.service.IResourceService;
import com.zl.frame.sysman.roleman.bean.Role;
import com.zl.frame.sysman.roleman.service.IRoleService;
import com.zl.frame.sysman.userman.bean.User;
import com.zl.frame.sysman.userman.service.IUserService;
import com.zl.frame.sysman.userman.vo.UserVo;

/**
 * @desc：用户管理Action
 * @author lixin
 * @date: 2013-11-19下午2:40:58
 */
public class UserAction extends BaseAction {

	private static final long serialVersionUID = 7774600863304983860L;

	private Logger logger = LoggerFactory.getLogger(getClass());
	private Page<User> pager = new Page<User>();	//注意：在使用easyui的datagrid时，这里Page对象的示例名称不能取名为page,datagrid.js实现中占用了page名称，在此处使用page会造成前端使用page映射参数值时错误
	private User user;			//ORM对象
	private UserVo userVo;		//数据数传对象
	private Role role;		
	private List<Role> roles;
	private List<Role> rolesTemp;
	private List<Resource> resources;	//用户对应角色拥有的访问资源（权限）
	private String resorcesJson;		//角色拥有的资源集合json字符串
	
	private String[] id;				//用户id数组，批量删除使用
	private String[] roleIds;			//	
	private String[] resourceIds;		//保存用户授权时选择的资源		
	
	private IUserService userService;
	private IRoleService roleService;
	private IResourceService resourceService;
	
	private String requestPageFlag;		//请求页面标记，分页插件中使用
	
	/** #################	分页插件示例后台代码 begin	###################  */
	
	public String loadUserListPage(){
		return "userlist";
	}
	
	/**
	 * 分页初始化时加载用户列表子页面 userlist_data.jsp
	 * 分页插件先去加载渲染数据列表子页面，然后再将子页面返回到父页面拼入列表显示区域，这种方式为插件的html请求方式，即：dataType:html,
	 * @return
	 */
	public String loadUserlistChildPage(){
		
		logger.info("欢迎进入分页插件测试示例action");
		
		try {
			StringBuffer hql = new StringBuffer(" from User u where 1=1 ");
			
			//查询条件，考虑封装一个查询条件类处理
			List<Object> params = new ArrayList<Object>();
			if(userVo != null){
				if(StringUtils.isNotBlank(userVo.getUserName())){
					hql.append(" and u.userName like ? ");
					params.add("%"+userVo.getUserName()+"%");
				}
				if(StringUtils.isNotBlank(userVo.getTelphone())){
					hql.append(" and u.telphone like ? ");
					params.add("%"+userVo.getTelphone()+"%");
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
			queryHql.append(hql);
			queryHql.append(" order by u.createTime desc ");

			StringBuffer countHql = new StringBuffer();
			countHql.append("select count(*) ");
			countHql.append(hql);
			
			pager = userService.findUserListByPage(queryHql.toString(), queryHql.toString(), pager, params.toArray());
			String resultJson = JsonUtil.obj2json(pager);
			logger.info("获取用户信息列表数据成功；数据如下：\n"+resultJson);
			
			//此处判断为分页插件jquery.whatyPager-1.2.2.js html模式加载数据跳转页面时使用
			if(StringUtils.isNotEmpty(requestPageFlag)){
				if("userlist_data2".equalsIgnoreCase(requestPageFlag)) {
					return "userlist_data2";
				}
				return "userlist_data";
			}
			
			//返回pager的json串形式为分页插件dataType=json时使用
			//writeJson(resultJson);
			writeJson(pager);//使用jackson讲对象转为json，为了解决jqgrid中日期格式化问题
		} catch (Exception e) {
			logger.debug("获取用户信息列表数据失败，原因："+e.getMessage());
			e.printStackTrace();
		}
		return null;
	}
	
	
	/** #################	 分页插件示例后台代码 end	###################  */
	
	
	
	/**
	 * 去用户列表页面
	 * @return
	 */
	public String toUserListPage(){
		logger.info("加载用户信息列表页面...");
		return "userList";
	}
	
	/**
	 * 分页查询用户信息，显示用户列表
	 */
	public void findUserList(){
		
		logger.info("获取用户信息列表数据开始...");
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
			queryHql.append(hql);
			queryHql.append(" order by u.id desc ");

			StringBuffer countHql = new StringBuffer();
			countHql.append("select count(*) ");
			countHql.append(hql);
			
			pager = userService.findUserListByPage(queryHql.toString(), countHql.toString(), pager, params.toArray());
			DataGrid dataGrid = new DataGrid(Long.valueOf(pager.getTotalRow()), pager.getData());
			writeJson(JsonUtil.obj2json(dataGrid));
//			writeJson(JsonUtil.objToJson(dataGrid, new String[]{"roleList"}, null));
			
			logger.info("获取用户信息列表数据成功");
		} catch (Exception e) {
			logger.debug("获取用户信息列表数据失败，原因："+e.getMessage());
			e.printStackTrace();
		}
	}
	
	/**
	 * 用户授权
	 * @return
	 */
	public String toUserAuthPage(){
		
		logger.info("加载用户授权页面，并加载授权页面的角色信息...");
		
		try {
			String hql = " from Role r where r.state=1 ";
			roles = roleService.findAllRoleList(hql, null);		//在授权页面展示根据角色授权时的角色信息
			
			//下面查询需要改成根据用户id将用户与角色进行连接查询后取到该用户所属的角色
			hql = " from User u where u.id=?";
			user = userService.findUserByHql(hql, user.getId());	//根据用户id查询用户，并级联获取该用户的角色
			rolesTemp = user.getRoleList() != null ? user.getRoleList() : null;
			
			logger.info("用户["+user.getUserName()+"]所属角色["+role.getRoleName()+"]");
		} catch (Exception e) {
			
			logger.info("加载用户授权页面失败，原因："+e.getMessage());
			e.printStackTrace();
		}
		return "userAuth";
	}
	
	/**
	 * 保存用户授权信息
	 */
	public void saveUserAuth(){
		
		logger.info("保存用户授权开始...");
		try {
			List<Resource> resources = new ArrayList<Resource>();
			for (String resourceId : resourceIds) {
				
				Resource resource = new Resource();
				resource.setId(resourceId);
				resources.add(resource);
			}
			
			Integer userId = Integer.valueOf(id[0]);
			user = userService.findUserById(userId);
			
			StringBuffer hql = new StringBuffer("from Role r where r.id in(");
			if(roleIds != null && roleIds[0].split(",").length > 0){
				for (int i = 1; i < roleIds[0].split(",").length+1; i++) {
					if(roleIds[0].split(",").length == i){
						hql.append("?");
					} else {
						hql.append("?,");
					}
				}
			}
			hql.append(")");

			Integer[] roleIdsTemp = new Integer[roleIds[0].split(",").length];
			for (int i = 0; i < roleIds[0].split(",").length; i++) {
				roleIdsTemp[i] = Integer.valueOf(roleIds[0].split(",")[i]);
			}
			
			List<Role> roles = roleService.findAllRoleList(hql.toString(), roleIdsTemp);
			user.setRoleList(roles);
			
//			Role role = new Role();
//			role.setResourceList(resources);
//			user.getRoleList().add(role);
			
			userService.saveOrUpdateUser(user);
			
			writeJson(JsonUtil.obj2json(new Json(true, "授权成功")));
			
			logger.info("用户授权成功");
		} catch (Exception e) {
			
			logger.debug("授权失败，原因："+e.getMessage());
			e.printStackTrace();
		}
		
	}
	
	/**
	 * 根据角色id或者用户id获取该角色或者改用户拥有的访问资源
	 */
	public void loadResourcesJsonByRoleId(){
		
		logger.info("根据角色id获取该角色拥有的访问资源");
		try {
			
			if(user != null){	//在用户列表点击授权时，先获取用户的角色，再获取该角色以拥有的访问资源
				
				String hql = " from User u where u.id=?";
				user = userService.findUserByHql(hql, user.getId());	//根据用户id查询用户，并级联获取该用户的角色
				role = user.getRoleList() != null && user.getRoleList().size() > 0 ? user.getRoleList().get(0) : null;
				if(role != null){
					roleIds = new String[]{role.getId().toString()};
				}
			} else if(role != null && roleIds == null){
				
				roleIds = new String[]{role.getId().toString()};
			}
			
			if(roleIds == null || roleIds.length == 0){
				logger.info("角色id为空");
				return;
			}

			/* 
			 *	注意：此处采用Hibernate的Native SQL查询方式进行查询，底层查询时使用了查询结果集转换器；
			 *		故，1、sql语句的查询字段一定要标明不能使用*，查询的字段名称必须跟转换的对象属性一直；
			 *			2、不一致的需在sql中对查询字段使用别名，不然不能自动转换结果集
			 *
			 *	优化：后期将优化使用hql查询，为了适用跨数据库
			 */
			StringBuffer sql = new StringBuffer("select r.id as id, r.parentId as parentId, r.resourceCode, r.resourceName, r.url, r.isMenu, r.statu, r.iconCls, r.state ");
			sql.append(" from t_sys_resource r ");
			sql.append(" inner join (select * from t_sys_role$resource rs where rs.roleId in(");
			if(roleIds != null && roleIds.length > 0){
				for (int i = 1; i < roleIds.length+1; i++) {
					if(roleIds.length == i){
						sql.append("?");
					} else {
						sql.append("?,");
					}
				}
			}
			sql.append(")) rr on r.id=rr.resourceId ");
			sql.append(" inner join t_sys_role rl on rl.id=rr.roleId ");
//			sql.append(" where 1=1 and r.isMenu=1 and r.parentId!='ROOT_NODE'");
			
			logger.info("获取角色拥有访问的资源，sql为>>>>>>	"+sql);
		
			List<Resource> resources = resourceService.findResourcesBySql(sql.toString(), roleIds);
			
			//去重，使用set集合和resource对象的equals()、hashcode()方法去重
			Set<Resource> resourceSet = new HashSet<Resource>(resources);
			
			resorcesJson = JsonUtil.obj2json(resourceSet);
			writeJson(resorcesJson);
			
			logger.info("获取角色["+roleIds+"]拥有的访问资源列表为>>>>>	"+resorcesJson);
		} catch (Exception e) {
			
			logger.debug("获取角色["+roleIds+"]允许访问的资源列表失败，原因："+e.getMessage());
			e.printStackTrace();
		}
	}
	
	/**
	 * 显示用户详细信息
	 * @return
	 */
	public String showUserDetail(){
		
		return "userDetail";
	}
	
	/**
	 * 去添加用户页面
	 * @return
	 */
	public String toAddUserPage(){
		return "userAdd";
	}
	
	/**
	 * 添加用户信息
	 */
	public void addSaveUser(){
		
		try {
			logger.info("开始保存用户信息...");
			
			user.setCreateTime(new Timestamp(new Date().getTime()));
			user.getRoleList().add(role);
			userService.saveOrUpdateUser(user);
			
			logger.info("成功保存一条用户信息。");
		} catch (Exception e) {
			
			logger.debug("添加用户失败；原因："+e.getMessage());
			e.printStackTrace();
		}
	}
	
	/**
	 * 去修改用户页面
	 * @return
	 */
	public String toEditUserPage(){
		
		try {
			logger.info("开始加载用户修改页面信息，用户ID："+user.getId());

			user = userService.findUserById(user.getId());
			
			logger.info("成功加载用户修改页面信息，用户ID："+user.getId());
		} catch (Exception e) {
			
			logger.debug("加载用户修改页面信息，用户ID："+user.getId()+"；原因："+e.getMessage());
			e.printStackTrace();
		}
		return "userEdit";
	}
	
	/**
	 * 修改保存用户信息
	 */
	public void editSaveUser(){
		
		try {
			logger.info("开始保存修改用户信息，用户ID："+user.getId());
			
			user.setLastUpdateTime(new Timestamp(new Date().getTime()));
			user.getRoleList().add(role);
			userService.saveOrUpdateUser(user);
			
			logger.info("开始保存修改用户信息，用户ID："+user.getId());
		} catch (Exception e) {
			
			logger.debug("保存修改用户信息失败，用户ID："+user.getId()+"；原因："+e.getMessage());
			e.printStackTrace();
		}
	}
	
	/**
	 * 删除用户信息
	 */
	public void deleteUser(){
		
		boolean success = true;
		String msg = "删除用户成功";
		try {
			logger.info("开始删除一条用户信息");
			
			//此处后期采用批量操作接口执行
			for (String userId : id) {
				userService.deleteUserById(Integer.parseInt(userId));
//				User userTemp = userService.findUserById(Integer.valueOf(userId));
//				userService.deleteUser(userTemp);
			}
			
			logger.info("成功删除一条用户信息");
		} catch (Exception e) {
			
			success = false;
			msg = "删除用户失败";
			logger.debug("删除用户失败，原因："+e.getMessage());
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
	 * 导出用户（Excel）
	 */
	public void exportUserToExcel(){
		
	}
	
	/**
	 * 下载导入用户模板（Excel）
	 */
	public void downImportUserExcelTemplate(){
		
	}
	
	/**
	 * 导入用户（Excel）
	 */
	public void importUserByExcel(){
		
	}

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

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	public List<Role> get$roles() {
		return rolesTemp;
	}

	public List<Role> getRolesTemp() {
		return rolesTemp;
	}

	public void setRolesTemp(List<Role> rolesTemp) {
		this.rolesTemp = rolesTemp;
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

	public String getResorcesJson() {
		return resorcesJson;
	}

	public IResourceService getResourceService() {
		return resourceService;
	}

	public void setResourceService(IResourceService resourceService) {
		this.resourceService = resourceService;
	}

	public void setResorcesJson(String resorcesJson) {
		this.resorcesJson = resorcesJson;
	}

	public String[] getId() {
		return id;
	}

	public void setId(String[] id) {
		this.id = id;
	}

	public String[] getRoleIds() {
		return roleIds;
	}

	public String[] getResourceIds() {
		return resourceIds;
	}

	public void setResourceIds(String[] resourceIds) {
		this.resourceIds = resourceIds;
	}

	public void setRoleIds(String[] roleIds) {
		this.roleIds = roleIds;
	}

	public List<Resource> getResources() {
		return resources;
	}

	public void setResources(List<Resource> resources) {
		this.resources = resources;
	}

	public Page<User> getPager() {
		return pager;
	}

	public void setPager(Page<User> pager) {
		this.pager = pager;
	}

	public String getRequestPageFlag() {
		return requestPageFlag;
	}

	public void setRequestPageFlag(String requestPageFlag) {
		this.requestPageFlag = requestPageFlag;
	}
	
}
