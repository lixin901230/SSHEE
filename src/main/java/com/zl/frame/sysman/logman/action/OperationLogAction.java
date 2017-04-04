package com.zl.frame.sysman.logman.action;

import com.zl.frame.core.web.BaseAction;
import com.zl.frame.sysman.logman.service.IOperationLogService;

/**
 * @desc：操作日志Action
 * @author lixin
 * @date: 2013-11-21上午11:53:38
 */
public class OperationLogAction extends BaseAction {

	private static final long serialVersionUID = 4186067031131154434L;

	private IOperationLogService operationLogService;

	public IOperationLogService getOperationLogService() {
		return operationLogService;
	}

	public void setOperationLogService(IOperationLogService operationLogService) {
		this.operationLogService = operationLogService;
	}

	
}
