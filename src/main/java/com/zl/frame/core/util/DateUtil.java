package com.zl.frame.core.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class DateUtil {
	
	static Logger logger = LoggerFactory.getLogger(DateUtil.class);

	/**
	 * 日期格式字符串：yyyy-MM-dd HH:mm:ss
	 */
	public final static String YYYYMMDDHHMMSS = "yyyy-MM-dd HH:mm:ss";
	/**
	 * 日期格式字符串：yyyy-MM-dd
	 */
	public final static String YYYYMMDD = "yyyy-MM-dd";
	
	/**
	 * 将日期解析成指定日期格式的字符串
	 * @param date 需要解析的日期
	 * @param formatStr 解析的日期格式
	 * @return 日期字符串
	 */
	public static String parseDate(Date date, String formatStr){
		
		String dateStr = null;
		try {
			formatStr = (formatStr == null || "".equals(formatStr)) ? YYYYMMDDHHMMSS : formatStr;
			SimpleDateFormat sdf = new SimpleDateFormat(formatStr);
			dateStr = sdf.format(date);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("解析日期为指定格式【"+formatStr+"】字符串时出错");
		}
		return dateStr;
	}
	
	/**
	 * 根据指定的日期字符串和日期格式，将日期字符串转换为指定日期格式的日期
	 * @param DateStr 日期字符串
	 * @param formatStr	日期格式
	 * @return
	 */
	public static Date formatDate(String DateStr, String formatStr){
		SimpleDateFormat sdf = new SimpleDateFormat(formatStr);
		Date date = null;
		try {
			date = sdf.parse(DateStr);
		} catch (ParseException e) {
			e.printStackTrace();
			logger.error("格式化日期格式为【"+formatStr+"】时出错");
		}
		return date;
	}
	
	/**
	 * 测试
	 * @param args
	 */
	public static void main(String[] args) {
		
	}
}
