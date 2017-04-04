package com.zl.frame.sysman.userman.bean;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import com.zl.frame.sysman.roleman.bean.Role;

/**
 * @desc：用户信息实体
 * @author lixin
 * @date: 2013-11-19下午2:59:20
 */
@JsonIgnoreProperties(value={"roleList"})//使用jackson转换该对象为json时，忽略此属性，由于hibernate中使用了对象双向关联，避免死循环
public class User implements java.io.Serializable {

	private static final long serialVersionUID = 2792552820431725673L;
	
	private Integer id;					//主键字段ID
    private String userName;			//用户名
    private String password;			//密码
    private String sex;					//性别
    private String telphone;			//手机
    private String email;				//邮箱
    private Timestamp createTime;		//创建时间
    private Timestamp lastUpdateTime;	//最后修改时间
    private Integer statu;				//状态，0：未激活，不可用；1：已激活，可用；2：挂起；3：禁用；4：过期
    private String remark;				//备注
    
    private List<Role> roleList = new ArrayList<Role>();	//关联关系设置

    
    public User() {
	}
    
	public User(Integer id, String userName, Integer statu) {
		
		this.id = id;
		this.userName = userName;
		this.statu = statu;
	}
	
	public Integer getId() {
        return this.id;
    }
    public void setId(Integer id) {
        this.id = id;
    }

    public String getUserName() {
        return this.userName;
    }
    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return this.password;
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
        return this.email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
//    @JsonSerialize(using=JsonDateSerializer.class)//转换json时，格式化日期
    public Timestamp getCreateTime() {
        return this.createTime;
    }
    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }
//    @JsonSerialize(using=JsonDateSerializer.class)//转换json时，格式化日期
    public Timestamp getLastUpdateTime() {
		return lastUpdateTime;
	}
	public void setLastUpdateTime(Timestamp lastUpdateTime) {
		this.lastUpdateTime = lastUpdateTime;
	}
	
	public Integer getStatu() {
        return this.statu;
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

	public List<Role> getRoleList() {
		return roleList;
	}
	public void setRoleList(List<Role> roleList) {
		this.roleList = roleList;
	}
	
	//User实现UserDetails，发现同一个账号可以同时登陆，也就是说concurrency-control没有起到作用，
	//参考了一下资料后，重写一下User的hashcode，equals方法就行了
	@Override
	public int hashCode() {
		return userName.hashCode();
	}
	
	@Override
	public boolean equals(Object obj) {
		User user = (User)obj;
		return this.userName.equals(user.getUserName());
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", userName=" + userName + ", password="
				+ password + ", email=" + email + ", createTime=" + createTime
				+ ", statu=" + statu + ", remark=" + remark + ", roleList="
				+ roleList + "]";
	}
    
}