package com.zl.frame.sysman.logman.service;

import java.io.Serializable;
import java.util.List;

import com.zl.frame.core.exception.PersistenceException;
import com.zl.frame.core.pager.Page;
import com.zl.frame.sysman.logman.bean.OperationLog;

/**
 * @desc：操作日志业务接口
 * @author lixin
 * @date: 2013-11-21下午3:06:19
 */
public interface IOperationLogService {

	/**
	 * 添加操作日志信息
	 * @param operationLog
	 * @return Serializable 返回插入记录的唯一标示ID
	 */
	public abstract Serializable insertOperationLog(OperationLog operationLog) throws Exception;

	/**
	 * 根据日志ID删除操作日志信息
	 * @param logId
	 * @throws PersistenceException 
	 */
	public abstract void deleteOperationLogByLogId(int logId) throws Exception;

	/**
	 * 删除操作日志信息，删除的对象必须为持久化对象
	 * @param operationLog
	 */
	public abstract void deleteOperationLog(OperationLog operationLog) throws Exception;

	/**
	 * 添加或者更新操作日志信息<br>
	 * 如果operationLog为新创建的对象，则执行保存操作；<br>
	 * 如果operationLog为已存在的持久化对象，则执行更新操作
	 * @param operationLog
	 */
	public abstract void saveOrUpdateOperationLog(OperationLog operationLog) throws Exception;

	/**
	 * 修改操作日志对象信息，修改对象必须是持久化对象
	 * @param operationLog
	 */
	public abstract void updateOperationLog(OperationLog operationLog) throws Exception;

	/**
	 * 通过Hql语句修改操作日志信息
	 * @param hql
	 * @param objects 可变参数
	 */
	public abstract void updateOperationLogByHql(String hql, Object... objects) throws Exception;

	/**
	 * 根据操作日志ID获取操作日志详细信息
	 * @param logId
	 * @return OperationLog
	 */
	public abstract OperationLog findOperationLogById(int logId) throws Exception;

	/**
	 * 根据Hql查询单个操作日志信息
	 * @param hql
	 * @param objects 可变参数
	 * @return OperationLog
	 */
	public abstract OperationLog findOperationLogByHql(String hql,
			Object... objects) throws Exception;

	/**
	 * 根据Hql查询所有操作日志信息
	 * @param hql
	 * @param objects 可变参数
	 * @return List<OperationLog>
	 */
	public abstract List<OperationLog> findAllOperationLogList(String hql,
			Object... objects) throws Exception;

	/**
	 * Hql分页查询操作日志信息列表
	 * @param hql
	 * @param page
	 * @param objects 可变参数
	 * @return Page<OperationLog>
	 */
	public abstract Page<OperationLog> findOperationLogListByPage(String hql, String countHql,
			Page<OperationLog> page, Object... objects) throws Exception;
}
