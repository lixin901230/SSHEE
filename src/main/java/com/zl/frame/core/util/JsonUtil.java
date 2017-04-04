package com.zl.frame.core.util;

import java.util.Date;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @desc：json工具类
 * @author lixin
 * @date: 2013-11-22下午5:16:37
 */
public class JsonUtil {
	
	private static Logger logger = LoggerFactory.getLogger(JsonUtil.class);
	
	private static ObjectMapper objMap = new ObjectMapper();
	
	/**
	 * 使用jackson将任意对象转为Json字符串
	 * @param obj Obejct对象
	 * @return String json字符串
	 * @throws Exception
	 */
	public static String obj2json(Object obj) throws Exception {
		return objMap.writeValueAsString(obj);
	}
	
	/**
	 * 将任意对象转换为json字符串
	 * @param obj 要转换的对象
	 * @param clazz 可为null, 转换成json对象时，解决死循环时要去除的的关联对象的类型
	 * @param propertyArr 可为null, 转换成json对象时，解决死循环时，去除造成死循环的关联对象时要保留的中的属性
	 * @return String json字符串
	 */
	public static String objToJson(Object obj, String[] propertyArr, Class<?> clazz){
		
		JSONObject json = null;
		try {
			
			logger.info("对象转换json字符串开始...");
			JsonConfig jsonConfig = new JsonConfig();
			jsonConfig.registerJsonValueProcessor(Date.class, new DateJsonValueProcessor());
			
			if(clazz != null && propertyArr != null){
				
				jsonConfig.registerJsonValueProcessor(clazz, new ObjectJsonValueProcessor(propertyArr, clazz));
			} else if(propertyArr != null){
				
				jsonConfig.setIgnoreDefaultExcludes(false);	//设置默认忽略
				jsonConfig.setExcludes(propertyArr);		
			}
			json = JSONObject.fromObject(obj, jsonConfig);
			logger.info("成功将对象转换为json字符串>>>>>>>>"+json.toString());
		} catch (Exception e) {
			
			logger.debug("对象转换json字符串异常；原因："+e.getMessage());
			e.printStackTrace();
		}
		return json.toString();
	}
}
