package com.zl.frame.sysman.orgman.action;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.zl.frame.core.pager.Page;
import com.zl.frame.core.util.DataGrid;
import com.zl.frame.core.util.Json;
import com.zl.frame.core.util.JsonUtil;
import com.zl.frame.core.web.BaseAction;
import com.zl.frame.sysman.orgman.bean.OrgInfo;
import com.zl.frame.sysman.orgman.service.IOrgInfoService;
import com.zl.frame.sysman.resourceman.bean.Menu;
import com.zl.frame.sysman.userman.bean.User;
import com.zl.frame.sysman.userman.service.IUserService;

/**
 * @desc：机构信息管理Action
 * @author lixin
 * @date: 2013-11-21上午11:52:46
 */
public class OrgInfoAction extends BaseAction {

	private static final long serialVersionUID = -6325388330242738435L;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	private Page<User> pager = new Page<User>();
	private OrgInfo orgInfo;			//ORM对象
	private String[] id;					//组织机构id数组，批量删除使用

	private IOrgInfoService orgInfoService;
	private IUserService userService;

	public IOrgInfoService getOrgInfoService() {
		return orgInfoService;
	}
	public void setOrgInfoService(IOrgInfoService orgInfoService) {
		this.orgInfoService = orgInfoService;
	}

	public IUserService getUserService() {
		return userService;
	}
	public void setUserService(IUserService userService) {
		this.userService = userService;
	}
	/**
	 * 去组织机构列表页面
	 * @return
	 */
	public String toOrgInfoListPage(){
		logger.info("加载组织机构列表页面...");
		return "orgInfoList";
	}
	
	/**
	 * 查询所有组织机构，显示组织机构树
	 */
	public void findOrgInfoTree(){
		
		logger.info("获取组织机构列表数据开始...");
		try {
			StringBuffer hql = new StringBuffer(" from OrgInfo o where 1=1 order by o.createTime asc ");
			
			List<Menu> orgInfos = orgInfoService.findAllOrgInfoList(hql.toString());
			String treeNodes = JsonUtil.obj2json(orgInfos);
			writeJson(treeNodes);
			
			logger.info("获取组织机构列表数据成功");
		} catch (Exception e) {
			logger.debug("获取组织机构列表数据失败，原因："+e.getMessage());
			e.printStackTrace();
		}
	}
	
	/**
	 * 查询所有组织机构，显示组织机构treegrid
	 */
	public void findOrgInfoTreegrid(){
		
		logger.info("获取组织机构列表数据开始...");
		try {
			StringBuffer hql = new StringBuffer(" from OrgInfo o where 1=1 order by o.createTime asc ");
			
			List<Menu> orgInfos = orgInfoService.findAllOrgInfoList(hql.toString());
			String treeNodes = JsonUtil.obj2json(orgInfos);
			writeJson(treeNodes);
			
			logger.info("获取组织机构列表数据成功");
		} catch (Exception e) {
			logger.debug("获取组织机构列表数据失败，原因："+e.getMessage());
			e.printStackTrace();
		}
	}
	
	/**
	 * @desc 获取组织机构详细信息
	 * @return
	 * @author lixin
	 * @date 2014-2-15上午11:06:49
	 */
	public String findOrgInfoDetail(){
		
		try {
			logger.info("开始获取组织机构["+orgInfo.getId()+"]的详细信息...");
			
			orgInfo = orgInfoService.findOrgInfoById(orgInfo.getId());
			
			logger.info("成功获取组织机构["+orgInfo.getId()+"]的详细信息");
		} catch (Exception e) {
			
			logger.debug("获取组织机构的详细信息失败，原因："+e.getMessage());
			e.printStackTrace();
		}
		
		return "orgInfoDetail";
	}
	
	/**
	 * 去添加组织机构页面
	 * @return
	 */
	public String toAddOrgInfoPage(){
		return "orgInfoAdd";
	}
	
	/**
	 * 添加组织机构
	 */
	public void addSaveOrgInfo(){
		
		try {
			logger.info("开始保存组织机构...");
			
			orgInfo.setCreateTime(new Timestamp(new Date().getTime()));
			orgInfoService.saveOrUpdateOrgInfo(orgInfo);
			
			logger.info("成功保存一条组织机构。");
		} catch (Exception e) {
			
			logger.debug("添加组织机构失败；原因："+e.getMessage());
			e.printStackTrace();
		}
	}
	
	/**
	 * 去修改组织机构页面
	 * @return
	 */
	public String toEditOrgInfoPage(){
		
		try {
			logger.info("开始加载组织机构修改页面信息，组织机构ID："+orgInfo.getId());

			orgInfo = orgInfoService.findOrgInfoById(orgInfo.getId());
			
			logger.info("成功加载组织机构修改页面信息，组织机构ID："+orgInfo.getId());
		} catch (Exception e) {
			
			logger.debug("加载组织机构修改页面信息，组织机构ID："+orgInfo.getId()+"；原因："+e.getMessage());
			e.printStackTrace();
		}
		return "orgInfoEdit";
	}
	
	/**
	 * 修改保存组织机构
	 */
	public void editSaveOrgInfo(){
		
		try {
			logger.info("开始保存修改组织机构，组织机构ID："+orgInfo.getId());
			
			orgInfo.setLastUpdateTime(new Timestamp(new Date().getTime()));
			orgInfoService.saveOrUpdateOrgInfo(orgInfo);
			
			logger.info("开始保存修改组织机构，组织机构ID："+orgInfo.getId());
		} catch (Exception e) {
			
			logger.debug("保存修改组织机构失败，组织机构ID："+orgInfo.getId()+"；原因："+e.getMessage());
			e.printStackTrace();
		}
	}
	
	/**
	 * 删除组织机构
	 */
	public void deleteOrgInfo(){
		
		boolean success = true;
		String msg = "删除组织机构成功";
		try {
			logger.info("开始删除一条组织机构");
			
			//此处后期采用批量操作接口执行
			for (String userGroupId : id) {
				orgInfoService.deleteOrgInfoById(userGroupId);
//				OrgInfo userGroupTemp = userService.findOrgInfoById(userGroupId);
//				userService.deleteOrgInfo(userGroupTemp);
			}
			
			logger.info("成功删除一条组织机构");
		} catch (Exception e) {
			
			success = false;
			msg = "删除组织机构失败";
			logger.debug("删除组织机构失败，原因："+e.getMessage());
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
	 * 导出组织机构（Excel）
	 */
	public void exportOrgInfoToExcel(){
		
	}
	
	/**
	 * 下载导入组织机构模板（Excel）
	 */
	public void downImportOrgInfoExcelTemplate(){
		
	}
	
	/**
	 * 导入组织机构（Excel）
	 */
	public void importOrgInfoByExcel(){
		
	}
	
	/**
	 * @desc 获取机构下的用户列表 
	 * @author lixin
	 * @date 2014-2-21下午5:07:40
	 */
	public void findOrgUsers(){

		try {
			logger.info("获取组织机构["+orgInfo.getId()+"]中的的详细信息");
			
			orgInfo = orgInfoService.findOrgInfoById(orgInfo.getId());
			
			logger.info("开始获取组织机构["+orgInfo.getId()+"]中的用户信息....");
			
			StringBuffer hql = new StringBuffer("select u.id,u.userName,u.sex,u.telphone,u.email,");
			hql.append("u.statu,u.createTime,u.lastUpdateTime,u.remark from t_sys_user u ");
			hql.append("inner join t_sys_user$organization uo on u.id=uo.userId ");
			hql.append("inner join t_sys_organization o on uo.orgId=o.id where o.id=? order by u.createTime desc");
			
			pager = userService.findUserListPageBySql(hql.toString(), pager, new String[]{orgInfo.getId()});
			DataGrid datagrid = new DataGrid(Long.valueOf(pager.getTotalRow()), pager.getData());
			writeJson(JsonUtil.obj2json(datagrid));
			
			logger.info("成功获取组织机构["+orgInfo.getId()+"]中的用户信息");
		} catch (Exception e) {
			
			logger.debug("获取组织机构["+orgInfo.getId()+"]中的用户信息失败");
			e.printStackTrace();
		}
		
	}
	
	public OrgInfo getOrgInfo() {
		return orgInfo;
	}
	public void setOrgInfo(OrgInfo orgInfo) {
		this.orgInfo = orgInfo;
	}
	
	public String[] getId() {
		return id;
	}
	public void setId(String[] id) {
		this.id = id;
	}
}
