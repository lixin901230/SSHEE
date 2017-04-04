package com.zl.frame.sysman.logman.service.impl;

import java.io.Serializable;
import java.util.List;

import com.zl.frame.core.exception.PersistenceException;
import com.zl.frame.core.pager.Page;
import com.zl.frame.sysman.logman.bean.OperationLog;
import com.zl.frame.sysman.logman.dao.IOperationLogDao;
import com.zl.frame.sysman.logman.service.IOperationLogService;

public class OperationLogServiceImpl implements IOperationLogService {

	private IOperationLogDao operationLogDao;

	public IOperationLogDao getOperationLogDao() {
		return operationLogDao;
	}
	public void setOperationLogDao(IOperationLogDao operationLogDao) {
		this.operationLogDao = operationLogDao;
	}
	
	/**
	 * 添加操作日志信息
	 * @param operationLog
	 * @return Serializable 返回插入记录的唯一标示ID
	 */
	public Serializable insertOperationLog(OperationLog operationLog) throws Exception {
		return operationLogDao.save(operationLog);
	}
	
	/**
	 * 根据日志ID删除操作日志信息
	 * @param logId
	 * @throws PersistenceException 
	 */
	public void deleteOperationLogByLogId(int logId) throws Exception {
		operationLogDao.delete(null, logId);
	}
	
	/**
	 * 删除操作日志信息，删除的对象必须为持久化对象
	 * @param operationLog
	 */
	public void deleteOperationLog(OperationLog operationLog) throws Exception {
		operationLogDao.delete(operationLog);
	}
	
	/**
	 * 添加或者更新操作日志信息<br>
	 * 如果operationLog为新创建的对象，则执行保存操作；<br>
	 * 如果operationLog为已存在的持久化对象，则执行更新操作
	 * @param operationLog
	 */
	public void saveOrUpdateOperationLog(OperationLog operationLog) throws Exception {
		operationLogDao.saveOrUpdate(operationLog);
	}
	
	/**
	 * 修改操作日志对象信息，修改对象必须是持久化对象
	 * @param operationLog
	 */
	public void updateOperationLog(OperationLog operationLog) throws Exception {
		operationLogDao.update(operationLog);
	}
	
	/**
	 * 通过Hql语句修改操作日志信息
	 * @param hql
	 * @param objects 可变参数
	 */
	public void updateOperationLogByHql(String hql, Object...objects) throws Exception {
		operationLogDao.updateByHql(hql, objects);
	}
	
	/**
	 * 根据操作日志ID获取操作日志详细信息
	 * @param logId
	 * @return OperationLog
	 */
	public OperationLog findOperationLogById(int logId) throws Exception {
		return operationLogDao.get(null, logId);
	}
	
	/**
	 * 根据Hql查询单个操作日志信息
	 * @param hql
	 * @param objects 可变参数
	 * @return OperationLog
	 */
	public OperationLog findOperationLogByHql(String hql, Object...objects) throws Exception {
		return operationLogDao.findByHql(hql, objects);
	}
	
	/**
	 * 根据Hql查询所有操作日志信息
	 * @param hql
	 * @param objects 可变参数
	 * @return List<OperationLog>
	 */
	public List<OperationLog> findAllOperationLogList(String hql, Object...objects) throws Exception {
		return operationLogDao.findAllByHql(hql, objects);
	}
	
	/**
	 * Hql分页查询操作日志信息列表
	 * @param hql
	 * @param page
	 * @param objects 可变参数
	 * @return Page<OperationLog>
	 */
	public Page<OperationLog> findOperationLogListByPage(String hql, Page<OperationLog> page, Object...objects) throws Exception {
		return operationLogDao.findByHql(hql, objects, page.getCurPage(), page.getPageSize());
	}
}
