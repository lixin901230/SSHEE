package com.zl.frame.core.util;

import java.util.UUID;

/**
 * @desc：工具类
 * @author lixin
 * @date: 2014-2-16下午6:08:59
 */
public class ToolClass {

	public static String getUUID(){
		
		UUID uuid = UUID.randomUUID();
		return uuid.toString().substring(0, 32);
	}
}
