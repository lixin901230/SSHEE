package com.zl.frame.sysman.roleman.vo;


/**
 * @desc：角色信息数据传输对象，非ORM对象<br>
 * 		仅仅用于在角色信息增、删、改、条件查询  时 进行数据传输（数据载体）
 * @author lixin
 * @date: 2013-11-27下午5:16:54
 */
public class RoleVo {
	
	private Integer id;
    private String roleName;
    private String createTimeStart;
    private String createTimeEnd;
    private Integer state;
    private String remark;
    
    
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public String getCreateTimeStart() {
		return createTimeStart;
	}
	public void setCreateTimeStart(String createTimeStart) {
		this.createTimeStart = createTimeStart;
	}
	public String getCreateTimeEnd() {
		return createTimeEnd;
	}
	public void setCreateTimeEnd(String createTimeEnd) {
		this.createTimeEnd = createTimeEnd;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
    
}
