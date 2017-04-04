package com.zl.frame.sysman.resourceman.action;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.zl.frame.core.util.Json;
import com.zl.frame.core.util.JsonUtil;
import com.zl.frame.core.web.BaseAction;
import com.zl.frame.sysman.resourceman.bean.Menu;
import com.zl.frame.sysman.resourceman.bean.Resource;
import com.zl.frame.sysman.resourceman.service.IResourceService;

/**
 * @desc：菜单节点Action
 * @author lixin
 * @date: 2013-11-19下午2:31:56
 */
public class ResourceAction extends BaseAction {

	private static final long serialVersionUID = -4748987901502437823L;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	private IResourceService resourceService;
	
	private String[] id;	//资源ID数组
	
	
	private Resource resource;

	
	/**
	 * 去资源列表页面
	 * @return
	 */
	public String toResourceListPage(){
		return "resourceList";
	}
	
	/**
	 * 加载jsontree
	 */
	public void loadIndexMenu(){
		
		try {
			
			logger.info("加载资源json数据树开始...");
			
			String jsonTree = resourceService.loadIndexMenu();
			writeJson(jsonTree);
			
			logger.info("成功加载资源json数据树");
		} catch (Exception e) {
			
			logger.debug("加载资源json数据树失败，原因："+e.getStackTrace());
			e.printStackTrace();
		}
	}
	
	/**
	 * 获取所有的树节点
	 */
	public void getAllTeeNode(){
		
		logger.info("获取树节点集合开始...");
		try {
			String hql = " from Resource res order by res.nodeSort";
			List<Menu> menus = resourceService.getAllTreeNode(hql);
			String treeNodes = JsonUtil.obj2json(menus);
			writeJson(treeNodes);
			
			logger.info("成功加载树节点数据>>>>>	"+treeNodes);
		}  catch (Exception e) {
			
			logger.info("获取树节点集合失败，原因："+e.getMessage());
			e.printStackTrace();
		}
	}
	
	/**
	 * @desc 查看资源详细信息
	 * @return
	 * @author lixin
	 * @date 2014-1-18下午5:01:29
	 */
	public String showResourceDetail(){
		return "resourceDetail";
	}
	
	/**
	 * @desc 加载资源添加页面
	 * @return
	 * @author lixin
	 * @date 2014-1-15下午5:16:12
	 */
	public String toAddResourcePage(){
		return "resourceAdd";
	}
	
	/**
	 * @desc 保存添加的资源信息
	 * @author lixin
	 * @date 2014-1-15下午5:16:12
	 */
	public void addSaveResource(){
		
		try {
			logger.info("开始保存资源信息...");
			
			resource.setCreateTime(new Timestamp(new Date().getTime()));
			resourceService.saveOrUpdateNode(resource);
			
			logger.info("成功保存一条资源信息。");
		} catch (Exception e) {
			
			logger.debug("添加资源失败；原因："+e.getMessage());
			e.printStackTrace();
		}
	}
	
	/**
	 * @desc 加载资源编辑页面信息
	 * @return
	 * @author lixin
	 * @date 2014-1-15下午5:16:12
	 */
	public String toEditResourcePage(){
		
		logger.info("开始加载资源编辑页面信息，资源ID："+resource.getId());
		
		try {
			resource = resourceService.findNodeById(resource.getId());
		} catch (Exception e) {
			
			logger.debug("资源编辑页面信息加载失败，原因："+e.getMessage());
			e.printStackTrace();
		}
		
		logger.info("成功加载资源"+resource.getId()+"编辑页面信息！");
		
		return "resourceEdit";
	}
	
	/**
	 * @desc 保存编辑后的资源信息
	 * @author lixin
	 * @date 2014-1-15下午5:16:12
	 */
	public void editSaveResource(){
		
		try {
			logger.info("开始保存修改资源信息，资源ID："+resource.getId());
			
//			resource.setLastUpdateTime(new Timestamp(new Date().getTime()));
			resourceService.saveOrUpdateNode(resource);
			
			logger.info("开始保存修改用户信息，资源ID："+resource.getId());
		} catch (Exception e) {
			
			logger.debug("保存修改资源信息失败，资源ID："+resource.getId()+"；原因："+e.getMessage());
			e.printStackTrace();
		}
	}
	
	/**
	 * @desc 删除/批量删除 资源信息 
	 * @author lixin
	 * @throws Exception 
	 * @date 2014-1-18下午5:00:40
	 */
	public void deleteResource() throws Exception{
		
		boolean success = true;
		String msg = "删除资源成功";
		try {
			logger.info("开始删除一条资源信息");
			
			//此处后期采用批量操作接口执行
			for (String resourceId : id) {
				resourceService.deleteNodeById(resourceId);
//				Resource resourceTemp = resourceService.findNodeById(userId);
//				resourceService.deleteResource(resourceTemp);
			}
			
			logger.info("成功删除资源信息");
		} catch (Exception e) {
			
			success = false;
			msg = "删除资源失败";
			logger.debug("删除资源失败，原因："+e.getMessage());
			e.printStackTrace();
		}
		writeJson(JsonUtil.obj2json(new Json(success, msg)));
	}
	
	public IResourceService getResourceService() {
		return resourceService;
	}

	public void setResourceService(IResourceService resourceService) {
		this.resourceService = resourceService;
	}

	public Resource getResource() {
		return resource;
	}
	public void setResource(Resource resource) {
		this.resource = resource;
	}

	public String[] getId() {
		return id;
	}

	public void setId(String[] id) {
		this.id = id;
	}
	
}
