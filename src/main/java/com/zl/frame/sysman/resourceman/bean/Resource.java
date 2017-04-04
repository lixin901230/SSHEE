package com.zl.frame.sysman.resourceman.bean;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.zl.frame.sysman.roleman.bean.Role;

/**
 * @desc：资源信息实体
 * @author lixin
 * @date: 2013-11-19下午3:04:17
 */
public class Resource implements java.io.Serializable {

	private static final long serialVersionUID = -9098431383952561835L;
	private String id;				//资源ID，唯一主键
	private String parentId;		//资源的父节点Id
    private String resourceCode;	//资源代码
    private String resourceName;	//资源名称
    private String url;				//资源访问URL
    private Timestamp createTime;	//创建时间
    private Integer statu;			//1：可以，0：不可用
    private Integer isMenu;			//是否是菜单；0：块模，1：菜单，2：功能点
    private String iconCls;			//节点图标
    private String state;			//节点是否折叠，当节点为父节点时，state=open则打开子节点，state=closed时折叠子节点
    private Integer nodeSort;		//菜单排序；同级菜单中，从1开始编序
    private String remark;			//备注
    
    private String parentResourceName;
    
    public String getParentResourceName() {
		return parentResourceName;
	}
	public void setParentResourceName(String parentResourceName) {
		this.parentResourceName = parentResourceName;
	}

	//    private Resource resource;
    private List<Resource> childResourceList = null;
    private List<Role> roleList = new ArrayList<Role>();

    public String getId() {
        return this.id;
    }
    
    public void setId(String id) {
        this.id = id;
    }

    public String getResourceCode() {
		return resourceCode;
	}
	public void setResourceCode(String resourceCode) {
		this.resourceCode = resourceCode;
	}
	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

    public String getResourceName() {
		return resourceName;
	}
    
	public void setResourceName(String resourceName) {
		this.resourceName = resourceName;
	}
	
	public String getUrl() {
        return this.url;
    }
    
    public void setUrl(String url) {
        this.url = url;
    }

    public Timestamp getCreateTime() {
        return this.createTime;
    }
    
    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public Integer getNodeSort() {
		return nodeSort;
	}

	public void setNodeSort(Integer nodeSort) {
		this.nodeSort = nodeSort;
	}

	public Integer getStatu() {
        return this.statu;
    }
    
	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	public Integer getIsMenu() {
		return isMenu;
	}

	public void setIsMenu(Integer isMenu) {
		this.isMenu = isMenu;
	}

	public void setStatu(Integer statu) {
        this.statu = statu;
    }

    public String getRemark() {
        return this.remark;
    }
    
    public void setRemark(String remark) {
        this.remark = remark;
    }

//	public Resource getResource() {
//		return resource;
//	}
//
//	public void setResource(Resource resource) {
//		this.resource = resource;
//	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public List<Resource> getChildResourceList() {
		return childResourceList;
	}

	public void setChildResourceList(List<Resource> childResourceList) {
		this.childResourceList = childResourceList;
	}

	public List<Role> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<Role> roleList) {
		this.roleList = roleList;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof Resource))
			return false;
		Resource other = (Resource) obj;
		if (getId() != null && other.getId() != null && getId().equalsIgnoreCase(other.getId())) {
            return true;
        }
		return true;
	}

	@Override
	public String toString() {
		return "Node [id=" + id + ", resourceCode=" + resourceCode + ", parentId="
				+ parentId + ", resourceName=" + resourceName + ", url=" + url
				+ ", createTime=" + createTime + ", statu=" + statu
				+ ", remark=" + remark + "]";
	}

}