package com.zl.frame.sysman.resourceman.bean;



/**
 * @desc：树节点实体
 * @author lixin
 * @date: 2013-12-10下午9:07:56
 */
public class Menu {
	
	private String id;				//资源ID，唯一主键
	private String parentId;		//资源的父节点Id
	private String parentName;		//资源的父节点Id
    private String resourceCode;		//资源节点代码
    private String resourceName;		//资源节点名称
    private String url;				//资源访问URL
    private Integer nodeSort;		//菜单排序；同级菜单中，从1开始编序
    private Integer isMenu;			//是否是菜单；0：块模，1：菜单，2：功能点
    private Integer statu;			//资源状态；1：可以，0：不可用
    
    private String iconCls;			//节点图标样式
    private String text;			//text: 显示的节点文本
    private String state;			//state: 节点状态, 'open' 或者 'closed', 默认是 'open'. 当设置为 'closed', 节点所有的子节点将从远程服务器站点加载 
    
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getParentName() {
		return parentName;
	}
	public void setParentName(String parentName) {
		this.parentName = parentName;
	}
	public String getResourceCode() {
		return resourceCode;
	}
	public void setResourceCode(String resourceCode) {
		this.resourceCode = resourceCode;
	}
	public String getResourceName() {
		return resourceName;
	}
	public void setResourceName(String resourceName) {
		this.text = resourceName;
		this.resourceName = resourceName;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Integer getIsMenu() {
		return isMenu;
	}
	public void setIsMenu(Integer isMenu) {
		this.isMenu = isMenu;
	}
	public Integer getNodeSort() {
		return nodeSort;
	}
	public void setNodeSort(Integer nodeSort) {
		this.nodeSort = nodeSort;
	}
	public String getIconCls() {
		return iconCls;
	}
	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}
	public Integer getStatu() {
		return statu;
	}
	public void setStatu(Integer statu) {
		this.statu = statu;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
    
}
