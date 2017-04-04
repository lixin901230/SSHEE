package com.zl.frame.sysman.roleman.bean;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.zl.frame.sysman.resourceman.bean.Resource;
import com.zl.frame.sysman.userman.bean.User;

/**
 * @desc：角色信息实体，ORM对象
 * @author lixin
 * @date: 2013-11-19下午3:02:45
 */
@JsonIgnoreProperties(value={"userList","resourceList"})//使用jackson转换该对象为json时，忽略此属性，由于hibernate中使用了对象双向关联，避免死循环
public class Role implements java.io.Serializable {

	private static final long serialVersionUID = -7403440787480333093L;
	
	private Integer id;				//角色ID
    private String roleName;		//角色名称
    private String roleType;		//角色类型；1：超级管理员，2：系统管理员，3：普通用户
    private Timestamp createTime;	//创建时间
    private Timestamp lastUpdateTime;	//最近修改时间
    private Integer state;			//角色状态；0：禁用；1：启用；
    private String remark;			//备注
    
    private List<User> userList = new ArrayList<User>();
	private List<Resource> resourceList = new ArrayList<Resource>();
	
	

    public Role() {
	}

	public Role(Integer id, String roleName) {
		this.id = id;
		this.roleName = roleName;
	}

	public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public String getRoleName() {
        return this.roleName;
    }
    
    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getRoleType() {
		return roleType;
	}

	public void setRoleType(String roleType) {
		this.roleType = roleType;
	}
//	@JsonSerialize(using=JsonDateSerializer.class)//转换json时，格式化日期
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

	public Integer getState() {
        return this.state;
    }
    
    public void setState(Integer state) {
        this.state = state;
    }

    public String getRemark() {
        return this.remark;
    }
    
    public void setRemark(String remark) {
        this.remark = remark;
    }
    
	public List<User> getUserList() {
		return userList;
	}

	public void setUserList(List<User> userList) {
		this.userList = userList;
	}

	public List<Resource> getResourceList() {
		return resourceList;
	}

	public void setResourceList(List<Resource> resourceList) {
		this.resourceList = resourceList;
	}

	@Override
	public String toString() {
		return "Role [id=" + id + ", roleName=" + roleName + ", createTime="
				+ createTime + ", state=" + state + ", remark=" + remark
				+ ", userList=" + userList + ", resourceList=" + resourceList + "]";
	}
   
}