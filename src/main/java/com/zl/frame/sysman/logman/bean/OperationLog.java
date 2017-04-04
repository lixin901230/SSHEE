package com.zl.frame.sysman.logman.bean;

import java.io.Serializable;
import java.sql.Timestamp;

import com.zl.frame.sysman.logman.handle.log.AbstactLog;

/**
 * @desc：操作日志信息实体，记录用户的操作
 * @author lixin
 * @date: 2013-12-8上午10:55:27
 */
public class OperationLog extends AbstactLog implements Serializable {

	private static final long serialVersionUID = -3557288372687695455L;
	
	private Integer id;					//操作日志ID，唯一主键
    private Integer userId;				//用户ID
    private String userName;			//用户名
    private Timestamp operationTime;	//操作时间
    private Integer operationType;		//操作类型	0：查询；1：添加；2：修改；3：删除；4：导入；5：导出；
    private String operationUrl;		//操作的资源的URL
    private String operationContent;	//操作内容
    private String remark;				//备注

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

    public Timestamp getOperationTime() {
        return this.operationTime;
    }
    
    public void setOperationTime(Timestamp operationTime) {
        this.operationTime = operationTime;
    }

    public Integer getOperationType() {
        return this.operationType;
    }
    
    public void setOperationType(Integer operationType) {
        this.operationType = operationType;
    }

    public String getOperationUrl() {
        return this.operationUrl;
    }
    
    public void setOperationUrl(String operationUrl) {
        this.operationUrl = operationUrl;
    }

    public String getOperationContent() {
        return this.operationContent;
    }
    
    public void setOperationContent(String operationContent) {
        this.operationContent = operationContent;
    }

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Override
	public String toString() {
		return "OperationLog [id=" + id + ", userId=" + userId + ", userName="
				+ userName + ", operationTime=" + operationTime
				+ ", operationType=" + operationType + ", operationUrl="
				+ operationUrl + ", operationContent=" + operationContent + "]";
	}
   
}