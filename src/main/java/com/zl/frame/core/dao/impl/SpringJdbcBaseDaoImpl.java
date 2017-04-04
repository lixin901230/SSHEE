package com.zl.frame.core.dao.impl;

import java.io.Serializable;

import com.zl.frame.core.dao.ISpringJdbcBaseDao;

/**
 * @desc：Spring-JdbcTemplate持久层框架集成，持久层公共接口实现
 * @param <T> orm对象类型泛型
 * @param <PK> orm对象主键类型泛型
 * @author lixin
 * @date: 2014-1-10下午3:27:46
 */
public class SpringJdbcBaseDaoImpl<T, PK extends Serializable> implements ISpringJdbcBaseDao<T, PK> {

}
