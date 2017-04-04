package com.zl.frame.core.security.entity;

import java.util.List;

/**
 * @desc：扩展spring security，存储鉴权服务不进行拦截的URL信息配置信息
 * @author lixin
 * @date: 2014-1-9上午1:05:55
 */
public class Permition {
	
	/**
	 * @desc 忽略鉴权的URL集合（不进行鉴权的URL）
	 * <li>通过在applicationContext-security.xml中注入该bean进行配置放行的url集合permitions</li>
	 */
	private List<String> permitions;

	public List<String> getPermitions() {
		return this.permitions;
	}

	public void setPermitions(List<String> permitions) {
		this.permitions = permitions;
	}
}