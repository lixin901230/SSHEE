package com.zl.frame.sysman.orgman.bean;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.zl.frame.sysman.userman.bean.User;

/**
 * @desc：机构信息实体
 * @author lixin
 * @date: 2013-11-19下午3:04:17
 */
public class OrgInfo implements Serializable {

	private static final long serialVersionUID = 7255577901088508508L;
	
	private String id;					//机构ID，唯一主键
	private String parentId;			//机构的父节点Id
    private String orgCode;				//机构代码
    private String orgName;				//机构名称
    private Timestamp createTime;		//创建时间
    private Timestamp lastUpdateTime;	//最后修改时间
    private Integer statu;				//1：可以，0：不可用
    private String iconCls;				//节点图标
    private String state;				//节点是否折叠，当节点为父节点时，state=open则打开子节点，state=closed时折叠子节点
    private Integer nodeSort;			//菜单排序；同级节点中，从1开始排序
    private String remark;				//备注
    
    private String parentOrgName;
    
    private List<OrgInfo> childOrgList = null;
    private List<User> userList = new ArrayList<User>();
    
    public String getParentOrgName() {
		return parentOrgName;
	}
	public void setParentOrgName(String parentOrgName) {
		this.parentOrgName = parentOrgName;
	}

    public String getId() {
        return this.id;
    }
    public void setId(String id) {
        this.id = id;
    }
	public String getOrgCode() {
		return orgCode;
	}
	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
    public Timestamp getCreateTime() {
        return this.createTime;
    }
    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }
    public Timestamp getLastUpdateTime() {
		return lastUpdateTime;
	}
	public void setLastUpdateTime(Timestamp lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
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
	public void setStatu(Integer statu) {
        this.statu = statu;
    }
    public String getRemark() {
        return this.remark;
    }
    public void setRemark(String remark) {
        this.remark = remark;
    }
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public List<OrgInfo> getChildOrgList() {
		return childOrgList;
	}
	public void setChildOrgList(List<OrgInfo> childOrgList) {
		this.childOrgList = childOrgList;
	}
	
	public List<User> getUserList() {
		return userList;
	}
	public void setUserList(List<User> userList) {
		this.userList = userList;
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
		if (!(obj instanceof OrgInfo))
			return false;
		OrgInfo other = (OrgInfo) obj;
		if (getId() != null && other.getId() != null && getId().equalsIgnoreCase(other.getId())) {
            return true;
        }
		return true;
	}

	@Override
	public String toString() {
		return "Node [id=" + id + ", orgCode=" + orgCode + ", parentId="
				+ parentId + ", orgName=" + orgName + ", createTime=" + createTime 
				+ ", statu=" + statu + ", remark=" + remark + "]";
	}

}