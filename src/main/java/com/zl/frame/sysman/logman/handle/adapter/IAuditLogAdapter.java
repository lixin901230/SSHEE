package com.zl.frame.sysman.logman.handle.adapter;

import java.text.ParseException;

import com.zl.frame.sysman.logman.handle.log.Log;

/**
 * @desc：审计日志内容处理Adapter
 * @author lixin
 * @date: 2014-3-6下午4:53:40
 */
public interface IAuditLogAdapter {
	
	/**
	 * @desc 将日志内容转换成日志对象
	 * @return Log
	 * @throws ParseException
	 * @author lixin
	 * @date 2014-3-6下午4:52:19
	 */
	public Log convert2Log() throws ParseException;
}
