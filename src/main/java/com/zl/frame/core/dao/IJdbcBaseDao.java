package com.zl.frame.core.dao;

import java.io.Serializable;


/**
 * @desc：JDBC持久层接口定义
 * @param <T> 实体类型泛型
 * @param <PK> 实体主键类型泛型
 * @author lixin
 * @date: 2013-11-6下午11:49:53
 */
public interface IJdbcBaseDao<T, PK extends Serializable> extends IBaseDao<T, Serializable> {
	
	
	
}
