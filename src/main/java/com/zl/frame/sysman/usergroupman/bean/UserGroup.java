package com.zl.frame.sysman.usergroupman.bean;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.zl.frame.sysman.userman.bean.User;

/**
 * @desc：用户组信息实体
 * @author lixin
 * @date: 2013-11-19下午2:59:20
 */
public class UserGroup implements java.io.Serializable {

	private static final long serialVersionUID = -8585216367603692250L;
	
	private String id;					//主键字段ID
	private String groupCode;			//用户组编码
    private String groupName;			//用户组名
    private Timestamp createTime;		//创建时间
    private Timestamp lastUpdateTime;	//最后修改时间
    private Integer statu;				//状态，1：可以，0：不可用
    private String remark;				//备注
    
    private List<User> userList = new ArrayList<User>();	//关联关系设置

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getGroupCode() {
		return groupCode;
	}

	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public Timestamp getCreateTime() {
		return createTime;
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

	public Integer getStatu() {
		return statu;
	}

	public void setStatu(Integer statu) {
		this.statu = statu;
	}

	public String getRemark() {
		return remark;
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
    
}