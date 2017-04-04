package com.zl.frame.core.dao.impl;

import java.io.Serializable;

import com.zl.frame.core.dao.IMybatisBaseDao;

/**
 * @desc：Mybatis持久层框架集成，持久层公共接口实现
 * @param <T> orm对象泛型
 * @param <PK> orm对象主键泛型
 * @author lixin
 * @date: 2014-1-10下午3:23:58
 */
public class MybatisBaseDaoImpl<T, PK extends Serializable> implements IMybatisBaseDao<T, PK>  {

}
