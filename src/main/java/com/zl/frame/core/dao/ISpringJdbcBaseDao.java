package com.zl.frame.core.dao;

import java.io.Serializable;


/**
 * @desc：Spring-JdbcTemplate 持久层框架集成， 持久层公共接口定义
 * @param <T> orm对象类型泛型
 * @param <PK> orm对象主键类型泛型
 * @author lixin 
 * @date: 2013-11-6下午11:49:53
 */
public interface ISpringJdbcBaseDao<T, PK extends Serializable> extends IBaseDao<T, Serializable> {
	
	
	
}
