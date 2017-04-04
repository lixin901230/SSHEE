package com.zl.frame.core.web;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @desc：view视图文件放到WEB-INF目录下后，所有页面的直接访问都通过该Action转发访问<br>
 * @eg：登录成功后，欢迎页跳转；layout主页布局中页面加载等
 * @author lixin
 * @date: 2013-11-22上午10:38:54
 */
public class JumpWelComeAction extends ActionSupport {

	private static final long serialVersionUID = 8281575597094850581L;

	/**
	 * 跳转到欢迎页面
	 * @return
	 */
	public String welcome(){
		return "welcome";
	}
	
	/**
	 * 主页Botton部分，关于我们
	 * @return
	 */
	public String aboutWe(){
		return "aboutWe";
	}
}
