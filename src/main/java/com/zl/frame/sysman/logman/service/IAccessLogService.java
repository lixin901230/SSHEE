package com.zl.frame.sysman.logman.service;

import java.io.Serializable;
import java.util.List;

import com.zl.frame.core.exception.PersistenceException;
import com.zl.frame.core.pager.Page;
import com.zl.frame.sysman.logman.bean.AccessLog;

/**
 * @desc：认证日志业务接口
 * @author lixin
 * @date: 2013-11-21上午11:51:24
 */
public interface IAccessLogService {

	/**
	 * 添加认证日志信息
	 * @param accessLog
	 * @return Serializable
	 */
	public abstract Serializable insertAccessLog(AccessLog accessLog) throws Exception;

	/**
	 * 根据日志ID删除认证日志信息
	 * @param logId
	 * @throws PersistenceException
	 */
	public abstract void deleteAccessLogByLogId(int logId) throws Exception;

	/**
	 * 删除认证日志，删除对象必须为持久化对象
	 * @param accessLog
	 */
	public abstract void deleteAccessLog(AccessLog accessLog) throws Exception;

	/**
	 * 添加或者更新认证日志信息<br>
	 * accessLog为新创建的对象时，执行添加操作<br>
	 * accessLog为持久化对象时，执行更新操作
	 * @param accessLog
	 */
	public abstract void saveOrUpdateAcessLog(AccessLog accessLog) throws Exception;

	/**
	 * 修改认证日志信息，修改对象必须为持久化对象
	 * @param accessLog
	 */
	public abstract void updateAccessLog(AccessLog accessLog) throws Exception;

	/**
	 * 通过Hql修改认证日志信息
	 * @param hql
	 * @param objects 可变参数数组
	 */
	public abstract void updateAccessLogByHql(String hql, Object... objects) throws Exception;

	/**
	 * 根据日志ID查询认证日志详细信息
	 * @param logId
	 * @return
	 */
	public abstract AccessLog findAccessLogById(int logId) throws Exception;

	/**
	 * 根据Hql查询单个认证日志信息
	 * @param hql
	 * @param objects
	 * @return
	 */
	public abstract AccessLog findAccessLogByHql(String hql, Object... objects) throws Exception;

	/**
	 * 根据Hql查询所有的认真日志信息
	 * @param hql
	 * @param objects
	 * @return
	 */
	public abstract List<AccessLog> findAllAccessLogByHql(String hql,
			Object... objects) throws Exception;

	/**
	 * Hql分页查询认证日志信息
	 * @param hql
	 * @param page
	 * @param objects
	 * @return
	 */
	public abstract Page<AccessLog> findAccessLogByPage(String hql, String countHql,
			Page<AccessLog> page, Object... objects) throws Exception;
}
