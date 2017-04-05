package com.zl.frame.sysman.roleman.action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
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
import com.zl.frame.sysman.roleman.vo.RoleVo;

/**
 * @desc：角色管理Action
 * @author lixin
 * @date: 2013-11-19下午2:40:01
 */
public class RoleAction extends BaseAction {

	private static final long serialVersionUID = 4705212617690199764L;

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	private Page<Role> pager = new Page<Role>();
	
	//ORM角色对象
	private Role role;
	private RoleVo roleVo;
	private String[] id;		//角色ID数组，批量操作角色时使用，如删除
	
	private String resourceIds;		//多个以“,”分隔资源ID字符串，
//	private List<Resource> resources;	//角色拥有的访问资源（权限）
	
	private IRoleService roleService;
	private IResourceService resourceService;
	
	/**
	 * 加载角色信息列表页面
	 * @return
	 */
	public String toRoleListPage(){
		return "roleList";
	}
	
	/**
	 * 分页查询角色信息列表
	 * ajax加载
	 */
	public void findRoleList(){
		
		try {
			logger.info("加载角色数据列表开始...");
			
			List<Object> params = new ArrayList<Object>();
			StringBuffer hql = new StringBuffer(" from Role r where 1=1 ");
			if(roleVo != null){
				if(StringUtils.isNotBlank(roleVo.getRoleName())){
					hql.append(" and r.roleName like ? ");
					params.add("%"+roleVo.getRoleName()+"%");
				}
				if(StringUtils.isNotBlank(roleVo.getCreateTimeStart())){
					hql.append(" and r.createTime > ? ");
					params.add(DateUtil.formatDate(roleVo.getCreateTimeStart(), DateUtil.YYYYMMDDHHMMSS));
				}
				if(StringUtils.isNotBlank(roleVo.getCreateTimeEnd())){
					hql.append(" and r.createTime < ? ");
					params.add(DateUtil.formatDate(roleVo.getCreateTimeEnd(), DateUtil.YYYYMMDDHHMMSS));
				}
			}
			
			StringBuffer queryHql = new StringBuffer();
			queryHql.append(hql);
			queryHql.append(" order by r.createTime desc ");

			StringBuffer countHql = new StringBuffer();
			countHql.append("select count(*) ");
			countHql.append(hql);
			
			pager = roleService.findRoleListByPage(queryHql.toString(), countHql.toString(), pager, params.toArray());
			DataGrid dataGrid = new DataGrid(Long.valueOf(pager.getTotalRow()), pager.getData());
			writeText(JsonUtil.obj2json(dataGrid));
//			writeJson(JsonUtil.objToJson(dataGrid, new String[]{"userList","resourceList"}, null));
			
			logger.info("成功获取角色数据列表...");
		} catch (Exception e) {
			
			logger.debug("后去角色数据列表失败，原因："+e.getMessage());
			e.printStackTrace();
		}
	}
	
	public void loadRoles(){
		
		logger.info("加载角色信息begin");
		try {

			List<Role> roles = roleService.findAllRoleList("from Role r", null);
			writeJson(JsonUtil.obj2json(roles));
			
			logger.info("加载角色信息end");
		} catch (Exception e) {
			
			logger.debug("加载角色信息失败...");
			e.printStackTrace();
		}
	}
	
	/**
	 * @desc 加载添加角色页面
	 * @return
	 * @author lixin
	 * @date 2014-1-15下午4:32:05
	 */
	public String toAddRolePage(){
		return "roleAdd";
	}
	
	/**
	 * 添加角色信息
	 */
	public void addSaveRole(){
		
		logger.info("添加保存角色信息开始...");
		try{

			Object[] params = resourceIds.split(",");

			StringBuffer hql = new StringBuffer("from Resource r where r.id in(");
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
			
			List<Resource> resources = resourceService.findAllNodeList(hql.toString(), params);
			role.setResourceList(resources);
			role.setCreateTime(new Timestamp(new Date().getTime()));
			roleService.saveRole(role);
			
		} catch(Exception e){
			
			logger.debug("添加保存角色信息开始失败，原因："+e.getMessage());
			e.printStackTrace();
		}
		logger.info("成功添加角色信息");
	}
	
	/**
	 * 编辑角色信息
	 */
	public String getEditRole(){
		
		logger.info("查询要编辑的角色["+id+"]信息开始...");
		try{
			
			role = roleService.findRoleById(role.getId());
			
		} catch(Exception e){
			
			logger.debug("查询要编辑的角色["+id+"]信息失败，原因："+e.getMessage());
			e.printStackTrace();
		}
		logger.info("成功获取待编辑的角色["+id+"]信息");
		return "roleEdit";
	}
	
	/**
	 * 编辑角色信息
	 */
	public void editSaveRole(){
		
		logger.info("编辑保存角色信息开始..."+resourceIds);
		try{
			
			Object[] params = resourceIds.split(",");
			StringBuffer hql = new StringBuffer("from Resource r where r.id in(");
			for (int i = 1; i <= params.length; i++) {
				if(i < params.length){
					hql.append("?,");
				} else {
					hql.append("?)");
				}
			}
			
			Role roleTemp = roleService.findRoleById(role.getId());
			
			List<Resource> resources = resourceService.findAllNodeList(hql.toString(), params);

			role.setLastUpdateTime(new Timestamp(new Date().getTime()));
			role.setResourceList(resources);
			BeanUtils.copyProperties(roleTemp, role);
			
			roleService.saveOrUpdateRole(roleTemp);
			
			logger.info("成功编辑保存角色信息");
		} catch(Exception e){
			
			logger.debug("编辑保存角色信息开始失败，原因："+e.getMessage());
			e.printStackTrace();
		}
	}
	
	/**
	 * 删除角色信息
	 */
	public void deleteRole(){
		
		boolean success = true;
		String msg = "删除角色成功";
		try {
			logger.info("开始删除一条角色信息");
			
			//此处后期采用批量操作接口执行
			for (String roleId : id) {
				roleService.deleteRoleById(Integer.parseInt(roleId));
//				Role roleTemp = roleService.findRoleById(Integer.valueOf(roleId));
//				roleService.deleteRole(roleTemp);
			}
			
			logger.info("成功删除一条角色信息");
		} catch (Exception e) {
			
			success = false;
			msg = "删除角色失败";
			logger.debug("删除角色失败，原因："+e.getMessage());
			e.printStackTrace();
		}
		try {
			writeJson(JsonUtil.obj2json(new Json(success, msg)));
		} catch (Exception e) {
			logger.debug("返回提示信息失败");
			e.printStackTrace();
		}
	}

	
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	public String[] getId() {
		return id;
	}
	public void setId(String[] id) {
		this.id = id;
	}
//	public List<Resource> getResources() {
//		return resources;
//	}

//	public void setResources(List<Resource> resources) {
//		this.resources = resources;
//	}

	public String getResourceIds() {
		return resourceIds;
	}

	public void setResourceIds(String resourceIds) {
		this.resourceIds = resourceIds;
	}

	public RoleVo getRoleVo() {
		return roleVo;
	}

	public void setRoleVo(RoleVo roleVo) {
		this.roleVo = roleVo;
	}

	public IRoleService getRoleService() {
		return roleService;
	}

	public void setRoleService(IRoleService roleService) {
		this.roleService = roleService;
	}

	public IResourceService getResourceService() {
		return resourceService;
	}

	public void setResourceService(IResourceService resourceService) {
		this.resourceService = resourceService;
	}

//	public Page<Role> getPage() {
//		return page;
//	}
//
//	public void setPage(Page<Role> page) {
//		this.page = page;
//	}

}
