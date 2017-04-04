package com.zl.frame.core.util;

/**
 * @desc：json消息封装
 * @author lixin
 * @date: 2013-12-26下午11:43:12
 */
public class Json {

	private boolean success = false;

	private String msg = "";

	private Object obj = null;
	
	public Json() {
	}

	public Json(boolean success, String msg) {
		this.success = success;
		this.msg = msg;
	}

	public Json(boolean success, String msg, Object obj) {
		this.success = success;
		this.msg = msg;
		this.obj = obj;
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Object getObj() {
		return obj;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}

}
