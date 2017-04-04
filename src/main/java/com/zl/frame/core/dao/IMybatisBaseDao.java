package com.zl.frame.core.dao;

import java.io.Serializable;

/**
 * @desc：Mybatis持久层框架集成，持久层公共接口定义
 * @param <T>
 * @param <PK>
 * @author lixin
 * @date: 2014-1-23下午3:31:55
 */
public interface IMybatisBaseDao<T, PK extends Serializable> extends IBaseDao<T, Serializable> {

}
