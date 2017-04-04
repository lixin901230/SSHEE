package com.zl.frame.sysman.userman.vo;


/**
 * @desc：用户信息数据传输对象，非ORM对象<br>
 * 		仅仅用于在用户信息增、删、改、条件查询  时 进行数据传输（数据载体）
 * @author lixin
 * @date: 2013-11-27下午5:16:54
 */
public class UserVo {

	private Integer id;					//主键字段ID
    private String userName;			//用户名
    private String password;			//密码
    private String sex;					//性别
    private String telphone;			//手机
    private String email;				//邮箱
    private Integer statu;				//状态，0：未激活，不可用；1：已激活，可用；3：被禁用
    private String remark;				//备注
	
	//查询条件数据传输
    private String createTimeStart;
    private String createTimeEnd;
    private String lastUpdateTimeStart;
    private String lastUpdateTimeEnd;
    
    
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getTelphone() {
		return telphone;
	}
	public void setTelphone(String telphone) {
		this.telphone = telphone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public String getLastUpdateTimeStart() {
		return lastUpdateTimeStart;
	}
	public void setLastUpdateTimeStart(String lastUpdateTimeStart) {
		this.lastUpdateTimeStart = lastUpdateTimeStart;
	}
	public String getLastUpdateTimeEnd() {
		return lastUpdateTimeEnd;
	}
	public void setLastUpdateTimeEnd(String lastUpdateTimeEnd) {
		this.lastUpdateTimeEnd = lastUpdateTimeEnd;
	}
    
}
