package com.zl.frame.core.web;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;

import com.zl.frame.sysman.resourceman.bean.Menu;
import com.zl.frame.sysman.resourceman.service.IResourceService;

/**
 * @desc：动态生成导航菜单
 * @author lixin
 * @date: 2013-12-14下午10:49:04
 */
public class MenuAction extends BaseAction {

	private static final long serialVersionUID = 6960394459742093759L;
	
	private Logger logger = LoggerFactory.getLogger(MenuAction.class);
	private IResourceService resourceService;
	
	private String menuStr;
	
	/**
	 * 动态生成导航菜单
	 */
	public String dynamicMenu(){
		
		logger.info(">>>>>	开始生成导航菜单...");
		try {
			
//			String hql = " from Resource r where r.statu=1 and r.isMenu in (0,1) order by nodeSort asc";
//			List<Menu> menus = resourceService.getAllTreeNode(hql);
			
			StringBuffer sql = new StringBuffer();
			sql.append("select * from  t_sys_resource res where res.id in ");
			sql.append("	(select rr.resourceId from t_sys_user u ");
			sql.append("		left join t_sys_user$role ur on u.id=ur.userId ");
			sql.append("		left join t_sys_role r on ur.roleId=r.id ");
			sql.append("		left join t_sys_role$resource rr on r.id=rr.roleId ");
			sql.append("		left join t_sys_resource res on rr.roleId=res.id ");
			sql.append("	where u.userName=?) ");
			sql.append(" and res.statu=1 and res.isMenu in (0,1) order by res.nodeSort asc");
			
//			Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			org.springframework.security.core.userdetails.User userDetail = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			
			List<Menu> menus = resourceService.findMenuBySql(sql.toString(), new Object[]{userDetail.getUsername()});
			menuStr = dealResourceMenu(menus);
			
			logger.info(">>>>>	成功生成导航菜单");
		} catch (Exception e) {
			
			logger.debug(">>>>>	动态生成导航菜单失败，原因："+e.getMessage());
			e.printStackTrace();
		}
//		writeHtml(menuStr);
		return "west";
	}
	
	/**
	 * 处理资源生成菜单
	 */
	public String dealResourceMenu(List<Menu> menus) {
		
		StringBuffer accordionTree = new StringBuffer();
		try {
			
			for (Menu menu : menus) {
				if(menu != null && menu.getIsMenu() == 0){	//匹配模块节点（即isMenu=0），拼接accordion构造模块菜单
					
					logger.info("开始生成模块【"+menu.getResourceName()+"】下的子菜单树...");

					//此处菜单图片需在数据库中增加字段进行动态设置data-options=\"iconCls:'"+_menu.getIconCls()+"'\">
					accordionTree.append("<div title="+menu.getResourceName()+" data-options=\"iconCls:'icon-search',iconCls:'"+menu.getIconCls()+"'\" style=\"padding:10px;\">");

					accordionTree.append("<ul class=\"easyui-tree\" id='mainMenuTree'>");
					String treeStr = buildTree(menu, menus);
					accordionTree.append(treeStr);
					accordionTree.append("</ul>");
					
					accordionTree.append("</div>");
					
					logger.info("模块【"+menu.getResourceName()+"】下的子菜单树生成完毕："+accordionTree.toString());
				}
			}
//			writeText(menuStr);
			
			logger.info("成功遍历资源集合生成整个菜单>>>>	"+accordionTree.toString());
		} catch (Exception e) {
			
			logger.debug("遍历资源集合生成菜单失败，原因："+e.getMessage());
			e.printStackTrace();
		}
		return accordionTree.toString();
	}
	
	/**
	 * 根据父节点，找出该父节点下的子节点，生成模块下的菜单树
	 * @param secondMenu
	 * @param menus
	 * @return
	 */
	public String buildTree(Menu secondMenu, List<Menu> menus){
		
		StringBuffer tree = new StringBuffer();
		
		for (Menu _menu : menus) {
			
			//判断该节点secondMenu是否有子菜单
			if(secondMenu.getId().equals(_menu.getParentId()) && _menu.getIsMenu() == 1 ){
				
				tree.append("<li data-options=\"iconCls:'"+_menu.getIconCls()+"'\">");
				if(_menu.getUrl() == null || "".equals(_menu.getUrl())){	//判断该菜单节点是否为父节点
				
					tree.append("<span>"+_menu.getResourceName()+"</span>");
					
					/*for (Menu menuTemp : menus) {
						if(_menu.getId().equals(menuTemp.getParentId())){		//该节点有子节点，即是父节点
							tree.append("<span>"+_menu.getNodeName()+"</span>");	
						} else {
							tree.append("<a href=\"#\" onclick=\"accessMenuLink('"+_menu.getUrl()+"','layout_center_tabs', 'tabs_id_noticeList', '"+_menu.getNodeName()+"', '"+_menu.getIconCls()+"');\" style=\"text-decoration: none;color: black;\">"+_menu.getNodeName()+"</a>");
							tree.append(_menu.getNodeName());					//该节点没子节点，即是叶节点
						}
					}*/
					
					String children = buildTree(_menu, menus);
					if(StringUtils.isNotBlank(children)){
						
						tree.append("<ul>");	
						tree.append(children);	//父节点下的子节点
						tree.append("</ul>");
					}
					tree.append("</li>");
					
				} else if(StringUtils.isNotBlank(_menu.getUrl())){
					
					tree.append("<a href=\"#\" onclick=\"accessMenuLink('"+_menu.getUrl()+"','layout_center_tabs', 'tabs_id_noticeList', '"+_menu.getResourceName()+"', '"+_menu.getIconCls()+"');\" style=\"text-decoration: none;color: black;\">"+_menu.getResourceName()+"</a>");
					tree.append("</li>");
				}
			}
		}
		return  tree.toString();
	}
	
	public String getMenuStr() {
		return menuStr;
	}
	public void setMenuStr(String menuStr) {
		this.menuStr = menuStr;
	}
	public IResourceService getResourceService() {
		return resourceService;
	}
	public void setResourceService(IResourceService resourceService) {
		this.resourceService = resourceService;
	}
}
