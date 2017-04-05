package com.zl.frame.core.dao;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;

import com.zl.frame.core.pager.Page;

/**
 * @desc：Hibernate 持久层接口<br>
 * 主要使用Spring提供的HibernateTemplate对象中的api对象数据库进行操作<br>
 * @param <T> 类型泛型
 * @param <PK> 主键泛型
 * @author lixin
 * @date 2013-11-6下午11:49:53
 */
public interface IHibernateBaseDao<T, PK extends Serializable> extends IBaseDao<T, Serializable> {
	
	/**
	 * 创建对象, 返回主键
	 *
	 * @return 返回创建后的主键值(如果是单主键,返回其值;如果是复合主键,则返回主键类对象,当没有额外的主键类时即返回PO对象本身)
	 */
	Serializable save(T entity) throws Exception ;
	
	/**
	 * 持久化对象
	 * @param entity
	 */
	void persist(T entity) throws Exception;

	/**
	 * 保存对象
	 * 1、如果对象为新创建的时，则为保存操作
	 * 2、如果对象信息已经在session或者数据库中已经存在，则为修改操作
	 * @param object
	 */
	void saveOrUpdate(T entity) throws Exception;
	
	/**
	 * @param collection
	 */
	void saveOrUpdateAll(Collection<T> collection) throws Exception;
	
	/**
     * 根据id删除记录
     *
     *@param clazz  可为null，为null则默认使用泛型T的类型
     * @param id    唯一标识
	 * @throws Exception 
     */
	void delete(Class<T> clazz, PK id) throws Exception;
	
	/**
     * 删除PO对应的记录
     *
     * @param T entity
     */
	void delete(T entity) throws Exception;
	
	/**
	 * 删除集合中的所有orm对象
	 * @param collection
	 */
	void deleteAll(Collection<T> collection) throws Exception;
	
	int deleteByHql(String hql) throws Exception;
	
	int deleteByHql(String hql, Object object) throws Exception;
	
	/**
	 * 根据hql删除orm对象，可包含多个参数
	 * @param hql
	 * @param Object...objects 可变参数
	 * @return
	 */
	int deleteByHql(String hql, final Object...objects) throws Exception;
	
	/**
	 * 修改
	 * @param entity
	 */
	void update(T entity) throws Exception;
	
	/**
	 * 通过hql修改
	 * @param hql
	 * @return
	 */
	int updateByHql(final String hql) throws Exception;
	
	/**
	 * 通过hql修改
	 * @param hql
	 * @param value
	 * @return
	 */
	int updateByHql(final String hql, final Object value) throws Exception;
	
	/**
	 * 通过hql修改
	 * @param hql
	 * @param values
	 * @return
	 */
	int updateByHql(final String hql, final Object[] values) throws Exception;
	
	/**
	 * 更新持久化对象
	 * @param entity
	 */
	void merge(T entity) throws Exception;
	
	/**
	 * 查询单个对象，包含get()和load()接口
	 * @param clazz 可为null，为null则默认使用泛型T的类型
	 * @return T
	 */
	T get(Class<T> clazz, Serializable id) throws Exception;
	/**
	 * @param clazz 可为null，为null则默认使用泛型T的类型
	 * @param id
	 * @return
	 */
	T load(Class<T> clazz, Serializable id) throws Exception;
	/**
	 * @param clazz 可为null，为null则默认使用泛型T的类型
	 * @return
	 */
	List<T> load(Class<T> clazz) throws Exception;
	
	
	//**************************	hibernate Hql查询接口定义	************************************
	
	/**
	 * 通过HibernateTmeplate提供的find查询接口根据hql进行查询
	 * @param hql
	 * @return List<T>
	 */
	List<T> find(String hql) throws Exception;
	/**
	 * 通过HibernateTmeplate提供的find查询接口根据hql进行查询
	 * @param hql
	 * @param object
	 * @return List<T>
	 */
	List<T> find(String hql, Object object) throws Exception;
	/**
	 * 通过HibernateTmeplate提供的find查询接口根据hql进行查询
	 * @param hql
	 * @param objects
	 * @return List<T>
	 */
	List<T> find(String hql, Object...objects) throws Exception;
	
	/**
     * 根据hql查询返回单个对象
     * @param hql 查询语句
     * @return T
     */
	T findByHql(String hql, Object...objects) throws Exception;
	/**
	 * 根据hql查询返回List<T>集合
	 * @param hql
	 * @param object 单个参数对象
	 * @return List<T>
	 */
	List<T> findAllByHql(String hql, Object object) throws Exception;
	/**
	 * 根据hql查询返回List<T>集合
	 * @param hql 
	 * @param objects 参数列表数组
	 * @return List<T>
	 */
	List<T> findAllByHql(String hql, Object...objects) throws Exception;
	
	/**
	 * 分页查询统计
	 * @param countHql
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Integer findCountByHql(final String countHql, final Object[] params) throws Exception;
	
    /**
     * 分页查询，根据hql进行分页查询
     *
     * @param hql   	分页列表查询语句
     * @param countHql  分页统计查询语句
     * @param obj     命名参数
     * @param curPage 当前页
     * @param pageSize 每页的数量
     *
     * @return Page<T> 分页对象
     */
	Page<T> findByHql(String hql, String countHql, int curPage, int pageSize) throws Exception;
    /**
     * 分页查询，根据hql进行分页查询
     * @param hql
     * @param params
     * @param curPage
     * @param pageSize
     * @return
     */
    Page<T> findByHql(String hql, String countHql, Object[] params, int curPage, int pageSize) throws Exception;
    
    
    //**************************	Hibernate 原生Sql查询接口定义	************************************
    
    /**
     * 根据原生sql查询单个对象信息
     * @param clazz
     * @param sql
     * @param objects
     * @return
     */
    T findBySql(Class<T> clazz, String sql, Object[] params) throws Exception;
    
    /**
     * 将查询出来的数据转换为Map集合,但前提是只能为一条数据 ,它的key为其查询的字段
     * @param sql
     * @param params
     * @return
     * @throws Exception
     */
	Map<String, Object> findMapBySql(final String sql, final Object[] params) throws Exception;
    
    /**
	 * 通过原生sql查询全部信息，用于导出报表查询等
	 * @param clazz 查询结果集Object数组根据转换器转换时指定的转换目标类型
	 * @param sql 原生sql语句
	 * @param params 参数
	 * @return
	 */
	List<T> findAllBySql(Class<T> clazz, String sql, Object params) throws Exception;
    
    /**
	 * 通过原生sql查询全部信息，用于导出报表查询等
	 * @param clazz 查询结果集Object数组根据转换器转换时指定的转换目标类型
	 * @param sql 原生sql语句
	 * @param params[] 参数
	 * @return
	 */
	List<T> findAllBySql(Class<T> clazz, String sql, Object[] params) throws Exception;
	
	/**
	 * sql查询，返回以sql查询字段名（或 别名）为key的map的，字段值为value的map 结果集
	 * @param clazz 查询结果集Object数组根据转换器转换时指定的转换目标类型
	 * @param sql 原生sql语句
	 * @param params 参数
	 * @return List<Map<String, Object>>
	 */
	List<Map<String, Object>> findMapListBySql(final String sql, final Object[] params) throws Exception;
	
	/**
	 * 分页查询统计
	 * @param countSql
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Integer findCountBySql(final String countSql, final Object[] params) throws Exception;
	
	/**
	 * 根据原生sql查询返回Obejct数组
	 * @param sql 原生sql
	 * @param params 参数数组对象
	 * @param curPage 当前页
	 * @param pageSize 每页显示数
	 * @return
	 */
	Page<T> findBySql(final String sql, final String countSql, final Object[] params, final int curPage, final int pageSize) throws Exception;
	
    /**
	 * 根据原生sql查询返回Obejct数组
	 * @param sql 原生sql
	 * @param params 参数对象
	 * @param curPage 当前页
	 * @param pageSize 每页显示数
	 * @return
	 */
	Page<T> findBySql(Class<T> clazz, String sql, String countHql, Object params, int curPage, int pageSize) throws Exception;
	
	/**
	 * 根据原生sql查询返回Obejct数组
	 * @param sql 原生sql
	 * @param obj[] 参数数组对象
	 * @param curPage 当前页
	 * @param pageSize 每页显示数
	 * @return
	 */
	Page<T> findBySql(Class<T> clazz, String sql, String countHql, Object[] params, int curPage, int pageSize) throws Exception;
	
	
	/**
	 * sql分页查询，返回值为一个List<Map<String, Object>>
	 * @param sql
	 * @param countSql
	 * @param params
	 * @param curPage
	 * @param pageSize
	 * @return
	 * @throws Exception
	 */
	Page<T> findMapListBySql(final String sql, final String countSql, final Object[] params, 
			final int curPage, final int pageSize) throws Exception;
	
	
	//***********************	hibernate QBC 纯对象化查询	**********************
	
	/**
	 * 查询全部，通过Criteria
	 * @return
	 */
	List<T> findAllByCriteria() throws Exception;
	
	/**
	 * 根据可变参数条件查询全部，通过Criteria
	 * @param criterion
	 * @return
	 */
	List<T> findByCriteria(final Criterion... criterion) throws Exception;
	
	/**
	 * 按Criteria查询唯一对象.
	 * 
	 * @param criterions 数量可变的Criterion.
	 */
	T findByCriterionUnique(final Criterion... criterions) throws Exception;
	
	/**
	 * 按Criteria查询对象列表.
	 * 
	 * @param criterions 数量可变的Criterion.
	 */
	List<T> findByCriterion(final Criterion... criterions) throws Exception;
	
	/**
	 * 按Criteria查询分页，返回分页对象Page<T>
	 * @param criterions
	 * @param curPage
	 * @param pageSize
	 * @return Page<T>
	 */
	Page<T> findPageByCriterion(final Criterion[] criterions, int curPage, int pageSize) throws Exception;
	
	/**
	 * QBC查询返回单个对象
	 * @param detachedCriteria
	 * @return T
	 */
	T findByCriteria(DetachedCriteria detachedCriteria) throws Exception;
	/**
	 * QBC查询全部，返回List<T>集合
	 * @param detachedCriteria
	 * @return List<T>
	 */
	List<T> findAllByCriteria(DetachedCriteria detachedCriteria) throws Exception;
	/** 
	 * QBC查询分页，返回Page<T>
	 * @param detachedCriteria
	 * @param curPage
	 * @param pageSize
	 * @return
	 */
	Page<T> findByCriteria(DetachedCriteria detachedCriteria, int curPage, int pageSize) throws Exception;
    
	
    //***********************	Hql批量处理	*************************
    
    /**
     * 根据Hql批量修改、删除
     * @param hql
     * @return
     */
    int batchByHql(String hql) throws Exception;
    /**
     * 根据Hql批量修改、删除，单个参数 
     * @param hql
     * @param object
     * @return
     */
    int batchByHql(String hql, Object object) throws Exception;
    /**
     * 根据Hql批量修改、删除，多个参数
     * @param hql
     * @param objects
     * @return
     */
    int batchByHql(String hql, Object...objects) throws Exception;
    
    /**
     * 采用HQL语句实现批量操作<br>
     * @param hql HQL语句
     * @return 处理的条数
     */
    int execHQL(final String hql) throws Exception;
    
    /**
     * 采用HQL语句实现批量操作,单参数<br>
     * @param hql HQL语句
     * @return 处理的条数
     */
    int execHQL(final String hql, final Object value) throws Exception;

    /**
     * 采用HQL语句实现批量操作,多参数<br>
     * @param hql
     * @param values
     * @return
     */
    int execHQL(final String hql, final Object[] values) throws Exception;

    /**
     * JDBC 批处理
     * @param sql
     * @param list
     * @throws Exception
     */
    void batchExecute(final String sql, final List<T> list) throws Exception;
}
