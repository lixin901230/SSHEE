package com.zl.frame.sysman.logman.service.impl;

import java.io.Serializable;
import java.util.List;

import com.zl.frame.core.exception.PersistenceException;
import com.zl.frame.core.pager.Page;
import com.zl.frame.sysman.logman.bean.AccessLog;
import com.zl.frame.sysman.logman.dao.IAccessLogDao;
import com.zl.frame.sysman.logman.service.IAccessLogService;

/**
 * @desc：认证日志业务接口实现
 * @author lixin
 * @date: 2013-11-21上午11:51:45
 */
public class AccessLogServiceImpl implements IAccessLogService {

	private IAccessLogDao accessLogDao;
	public IAccessLogDao getAccessLogDao() {
		return accessLogDao;
	}
	public void setAccessLogDao(IAccessLogDao accessLogDao) {
		this.accessLogDao = accessLogDao;
	}

	/**
	 * 添加认证日志信息
	 * @param accessLog
	 * @return Serializable
	 */
	public Serializable insertAccessLog(AccessLog accessLog) throws Exception {
		return accessLogDao.save(accessLog);
	}
	
	/**
	 * 根据日志ID删除认证日志信息
	 * @param logId
	 * @throws PersistenceException
	 */
	public void deleteAccessLogByLogId(int logId) throws Exception {
		accessLogDao.delete(null, logId);
	}
	
	/**
	 * 删除认证日志，删除对象必须为持久化对象
	 * @param accessLog
	 */
	public void deleteAccessLog(AccessLog accessLog) throws Exception {
		accessLogDao.delete(accessLog);
	}
	
	/**
	 * 添加或者更新认证日志信息<br>
	 * accessLog为新创建的对象时，执行添加操作<br>
	 * accessLog为持久化对象时，执行更新操作
	 * @param accessLog
	 */
	public void saveOrUpdateAcessLog(AccessLog accessLog) throws Exception {
		accessLogDao.saveOrUpdate(accessLog);
	}
	
	/**
	 * 修改认证日志信息，修改对象必须为持久化对象
	 * @param accessLog
	 */
	public void updateAccessLog(AccessLog accessLog) throws Exception {
		accessLogDao.update(accessLog);
	}
	
	/**
	 * 通过Hql修改认证日志信息
	 * @param hql
	 * @param objects 可变参数数组
	 */
	public void updateAccessLogByHql(String hql, Object...objects) throws Exception {
		accessLogDao.updateByHql(hql, objects);
	}
	
	/**
	 * 根据日志ID查询认证日志详细信息
	 * @param logId
	 * @return
	 */
	public AccessLog findAccessLogById(int logId) throws Exception {
		return accessLogDao.get(null, logId);
	}
	
	/**
	 * 根据Hql查询单个认证日志信息
	 * @param hql
	 * @param objects
	 * @return
	 */
	public AccessLog findAccessLogByHql(String hql, Object...objects) throws Exception {
		return accessLogDao.findByHql(hql, objects);
	}
	
	/**
	 * 根据Hql查询所有的认真日志信息
	 * @param hql
	 * @param objects
	 * @return
	 */
	public List<AccessLog> findAllAccessLogByHql(String hql, Object...objects) throws Exception {
		return accessLogDao.findAllByHql(hql, objects);
	}
	
	/**
	 * Hql分页查询认证日志信息
	 * @param hql
	 * @param page
	 * @param objects
	 * @return
	 */
	public Page<AccessLog> findAccessLogByPage(String hql, Page<AccessLog> page, Object...objects) throws Exception {
		return accessLogDao.findByHql(hql, objects, page.getCurPage(), page.getPageSize());
	}
}
