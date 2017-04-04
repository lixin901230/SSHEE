package com.zl.frame.sysman.logman.bean;

import java.io.Serializable;
import java.sql.Timestamp;

import com.zl.frame.sysman.logman.handle.log.AbstactLog;

/**
 * @desc：登陆认证日志信息实体
 * @author lixin
 * @date: 2013-12-8上午10:55:16
 */
public class AccessLog extends AbstactLog implements Serializable {

	private static final long serialVersionUID = 5772989140827376214L;
	
	private Integer id;				//唯一主键ID
    private Integer userId;			//用户ID
    private String userName;		//用户名
    private Timestamp loginTime;	//登陆认证时间
    private Timestamp logoutTime;	//退出时间
    private Integer logoutType;		//退出类型；0：正常退出；1：非正常退出
    private String loginIp;			//登陆认证终端的IP
    private String sessionId;		//sessionID
    private String remark;			//备注

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return this.userId;
    }
    
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return this.userName;
    }
    
    public void setUserName(String userName) {
        this.userName = userName;
    }

    public Timestamp getLoginTime() {
        return this.loginTime;
    }
    
    public void setLoginTime(Timestamp loginTime) {
        this.loginTime = loginTime;
    }

    public Timestamp getLogoutTime() {
        return this.logoutTime;
    }
    
    public void setLogoutTime(Timestamp logoutTime) {
        this.logoutTime = logoutTime;
    }

    public Integer getLogoutType() {
        return this.logoutType;
    }
    
    public void setLogoutType(Integer logoutType) {
        this.logoutType = logoutType;
    }

    public String getLoginIp() {
        return this.loginIp;
    }
    
    public void setLoginIp(String loginIp) {
        this.loginIp = loginIp;
    }

    public String getSessionId() {
        return this.sessionId;
    }
    
    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Override
	public String toString() {
		return "AccessLog [id=" + id + ", userId=" + userId + ", userName="
				+ userName + ", loginTime=" + loginTime + ", logoutTime="
				+ logoutTime + ", logoutType=" + logoutType + ", loginIp="
				+ loginIp + ", sessionId=" + sessionId + "]";
	}
}