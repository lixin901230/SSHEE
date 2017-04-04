package com.zl.frame.sysman.logman.action;

import com.zl.frame.core.web.BaseAction;
import com.zl.frame.sysman.logman.service.IAccessLogService;

/**
 * @desc：认证日志Action
 * @author lixin
 * @date: 2013-11-21上午11:52:46
 */
public class AccessLogAction extends BaseAction {

	private static final long serialVersionUID = 8463962453865090677L;

	private IAccessLogService accessLogService;

	public IAccessLogService getAccessLogService() {
		return accessLogService;
	}

	public void setAccessLogService(IAccessLogService accessLogService) {
		this.accessLogService = accessLogService;
	}

	
	
}
