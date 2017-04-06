package com.zl.frame.core.dao.impl;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.metadata.ClassMetadata;
import org.hibernate.transform.AliasToBeanResultTransformer;
import org.hibernate.transform.Transformers;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.SessionFactoryUtils;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.zl.frame.core.dao.IHibernateBaseDao;
import com.zl.frame.core.exception.PersistenceException;
import com.zl.frame.core.pager.Page;
 
/**
 * @desc：Hibernate 持久层底层实现<br>
 * 主要使用Spring提供的HibernateTemplate对象中的api对象数据库进行操作<br>
 * @param <T> 泛型
 * @param <PK> 主键泛型
 * @author lixin
 * @date: 2013-11-7上午12:56:39
 */
public class HibernateBaseDaoImpl<T, PK extends Serializable> extends 
		HibernateDaoSupport implements IHibernateBaseDao<T, PK> {
	
	private Logger logger = LoggerFactory.getLogger(HibernateBaseDaoImpl.class);

	private Class<T> entityClass;
	
	/**
	 * 以注解的方式注入sessionFactory
	 * 
	 * 注意：使用注解为HibernateDaoSupport注入sessionFactory，因为 {@link HibernateDaoSupport#setSessionFactory(SessionFactory sessionFactory)} 方法为final类型的，
	 * 故使用该这种方式来为HibernateDaoSupport注入sessionFactory
	 * @param sessionFactory
	 */
	/*@Autowired
	public void setMySessionFactory(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}*/
	
	/**
	 * 通过范型反射，取得子类中定义的entityClass
	 */
	@SuppressWarnings("unchecked")
	public HibernateBaseDaoImpl() {
		logger.info(">>>>>>>>>>>>>	实例化底层Hibernate接口HibernateBaseDaoImpl，通过反射获取泛型的实际类型");
		this.entityClass = null;
		Class c = getClass();
		//ParameterizedType type = (ParameterizedType) getClass().getGenericSuperclass();
		Type type = c.getGenericSuperclass();
		if (type instanceof ParameterizedType) {
			Type[] parameterizedType = ((ParameterizedType) type).getActualTypeArguments();
			this.entityClass = (Class<T>) parameterizedType[0];
		}
	}
	
	/**
	 * 初始化对象.
	 * 使用load()方法得到的仅是对象Proxy, 在传到View层前需要进行初始化.
	 * 只初始化entity的直接属性,但不会初始化延迟加载的关联集合和属性.
	 * 如需初始化关联属性,可实现新的函数,执行:
	 * Hibernate.initialize(user.getRoles())，初始化User的直接属性和关联集合.
	 * Hibernate.initialize(user.getDescription())，初始化User的直接属性和延迟加载的Description属性.
	 */
	public void initProxyProperty(Object proxyProperty) {
//		getHibernateTemplate().initialize(proxyProperty);
		Hibernate.initialize(proxyProperty);
	}
	
	/**
	 * 为Query添加distinct transformer.
	 */
	public Query distinct(Query query) {
		query.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
		return query;
	}

	/**
	 * 为Criteria添加distinct transformer.
	 */
	public Criteria distinct(Criteria criteria) {
		criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
		return criteria;
	}

	/**
	 * 取得对象的主键名.
	 */
	public String getIdName() {
		ClassMetadata meta = getSessionFactory().getClassMetadata(entityClass);
		return meta.getIdentifierPropertyName();
	}
	
	@Override
	public Serializable save(T entity) {
		logger.info(">>>>>>>>>>>>>	保存对象："+entity.getClass().getName());
		Serializable serializable = getHibernateTemplate().save(entity);
		getHibernateTemplate().flush();//todo 与jdbc进行事务mix时，必须执行刷新
		return serializable;
	}
	
	@Override
	public void persist(T entity) throws Exception {
		getHibernateTemplate().persist(entity);
	}

	@Override
	public void saveOrUpdate(T entity) throws Exception {
		logger.info(">>>>>>>>>>>>>	保存或修改对象："+entity.getClass().getName());
		getHibernateTemplate().saveOrUpdate(entity);
	}
	
	@Override
	public void saveOrUpdateAll(Collection<T> collection) throws Exception {
		getHibernateTemplate().saveOrUpdateAll(collection);
	}

	@Override
	public void delete(Class<T> clazz, PK id) throws Exception {
		logger.info(">>>>>>>>>>>>>	删除id为["+id+"]的对象信息");
		if(id == null){
			throw new PersistenceException("根据主键删除对象，主键不能为null");
		}
		T entity = null;
		if(clazz != null){
			entity = get(clazz, id);
		}else{
			entity = get(entityClass, id);
		}
		if(entity == null){
			throw new PersistenceException("删除主键id为"+id+"的对象不存在");
		}
		getHibernateTemplate().delete(entity);
//		getHibernateTemplate().flush();	//没spring管理实务时加上可提交事物
	}

	@Override
	public void delete(T entity) throws Exception {
		getHibernateTemplate().delete(entity);
//		getHibernateTemplate().flush();
	}
	
	@Override
	public void deleteAll(Collection<T> collection) throws Exception {
		getHibernateTemplate().deleteAll(collection);
	}
	
	@Override
	public int deleteByHql(String hql) throws Exception {
		return deleteByHql(hql, new Object[]{});
	}
	
	@Override
	public int deleteByHql(String hql, Object object) throws Exception {
		return deleteByHql(hql, new Object[]{object});
	}
	
	@Override
	public int deleteByHql(final String hql, final Object...objects) throws Exception {
        Integer count = (Integer) this.getHibernateTemplate().execute(new HibernateCallback<Object>() {
            public Object doInHibernate(Session session) {
            	Query query = session.createQuery(hql);
            	if(objects != null && objects.length > 0){
            		for (int i = 0; i < objects.length; i++) {
						query.setParameter(i, objects[i]);
					}
            	}
                int count = query.executeUpdate();
                return new Integer(count);
            }
        });
        return count.intValue();
    }

	@Override
	public void update(T entity) throws Exception {
		getHibernateTemplate().update(entity);
	}
	
	@Override
	public int updateByHql(final String hql) throws Exception {
        Integer count = (Integer) this.getHibernateTemplate().execute(new HibernateCallback<Object>() {
            public Object doInHibernate(Session session) {
                int count = session.createQuery(hql).executeUpdate();
                return new Integer(count);
            }
        });
        return count.intValue();
    }
 
	@Override
	public int updateByHql(final String hql, final Object value) throws Exception {
        Integer count = (Integer) this.getHibernateTemplate().execute(new HibernateCallback<Object>() {
            public Object doInHibernate(Session session) {
                int count = session.createQuery(hql).setParameter(0, value).executeUpdate();
                return new Integer(count);
            }
        });
        return count.intValue();
    }
    
	@Override
	public int updateByHql(final String hql, final Object[] values) throws Exception {
        Integer count = (Integer) this.getHibernateTemplate().execute(new HibernateCallback<Object>() {
            public Object doInHibernate(Session session) {
                Query query = session.createQuery(hql);
                for (int i = 0; i < values.length; i++) {
                    query.setParameter(i, values[i]);
                }
                int count = query.executeUpdate();
                return new Integer(count);
            }
        });
        return count.intValue();
    }
	
	@Override
	public void merge(T entity) throws Exception {
		getHibernateTemplate().merge(entity);
	}

	@Override
	public T get(Class<T> clazz, Serializable id) throws Exception {
		if(clazz != null){
			return getHibernateTemplate().get(clazz, id);
		}
		return getHibernateTemplate().get(entityClass, id);
	}

	@Override
	public T load(Class<T> clazz, Serializable id) throws Exception {
		if(clazz != null){
			return getHibernateTemplate().load(clazz, id);
		}
		return getHibernateTemplate().load(entityClass, id);
	}
	
	@Override
	public List<T> load(Class<T> clazz) throws Exception {
		if(clazz != null){
			return getHibernateTemplate().loadAll(clazz);
		}
		return getHibernateTemplate().loadAll(entityClass);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<T> find(String hql) throws Exception {
		return getHibernateTemplate().find(hql);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<T> find(String hql, Object object) throws Exception {
		return getHibernateTemplate().find(hql, object);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<T> find(String hql, Object... objects) throws Exception {
		return getHibernateTemplate().find(hql, objects);
	}

	@Override
	public T findByHql(final String hql, final Object... objects) throws Exception {
		return getHibernateTemplate().execute(new HibernateCallback<T>() {
			@Override
			public T doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.createQuery(hql);
		    	if(objects != null && objects.length > 0){
		    		for (int i = 0; i < objects.length; i++) {
						query.setParameter(i, objects[i]);
					}
		    	}
		    	T result = (T) query.uniqueResult();
				return result;
			}
		});
	}

	@Override
	public List<T> findAllByHql(String hql, Object object) throws Exception {
		return findAllByHql(hql, new Object[]{object});
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<T> findAllByHql(final String hql, final Object... objects) throws Exception {
		return (List<T>) getHibernateTemplate().execute(new HibernateCallback<Object>() {
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.createQuery(hql);
		    	if(objects != null && objects.length > 0){
		    		for (int i = 0; i < objects.length; i++) {
						query.setParameter(i, objects[i]);
					}
		    	}
		    	List<T> data = query.list();
				return data;
			}
		});
	}
	
	@Override
	public Integer findCountByHql(final String countHql, final Object[] params) throws Exception {
		return getHibernateTemplate().execute(new HibernateCallback<Integer>() {
			@Override
			public Integer doInHibernate(Session session) throws HibernateException, SQLException {
				return executePageCountQueryByHql(session, countHql, params);
			}
		});
	}
	
	@Override
	public Page<T> findByHql(String hql, String countHql, int curPage, int pageSize) throws Exception {
		return findByHql(hql, countHql, new Object[]{}, curPage, pageSize);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Page<T> findByHql(final String hql, final String countHql, 
			final Object[] params, final int curPage, final int pageSize) throws Exception {
		return (Page<T>) getHibernateTemplate().execute(new HibernateCallback<Object>() {
			@Override
			public Page<T> doInHibernate(Session session) throws HibernateException, SQLException {
				int totalRow = executePageCountQueryByHql(session, countHql, params);
		    	Query query = session.createQuery(hql);
		        if (params != null) {
		            for (int i = 0; i < params.length; i++) {
		                query.setParameter(i, params[i]);
		            }
		        }
		        List<T> data = query.setFirstResult(pageSize * (curPage - 1)).setMaxResults(pageSize).list();
		        return new Page<T>(curPage, pageSize, totalRow, data);
			}
		});
	}

	@Override
	public T findBySql(final Class<T> clazz, final String sql, final Object[] params) throws Exception {
		return getHibernateTemplate().execute(new HibernateCallback<T>() {
			@Override
			public T doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.createSQLQuery(sql);
		    	if (params != null) {
		    		for (int i = 0; i < params.length; i++) {
		    			query.setParameter(i, params[i]);
		    		}
		    	}
		    	//query.setResultTransformer(Transformers.aliasToBean(clazz));
		    	query.setResultTransformer(new AliasToBeanResultTransformer(clazz));
		    	T object = (T) query.uniqueResult();
		    	return object;
			}
		});
	}
	
	@Override
	@SuppressWarnings("unchecked")
	public Map<String, Object> findMapBySql(final String sql, final Object[] params) throws Exception {
		return (Map<String, Object>) getHibernateTemplate().execute(new HibernateCallback<Map<String, Object>>() {
            @Override  
            public Map<String, Object> doInHibernate(Session session) throws HibernateException,
                    SQLException {
                Query query = session.createSQLQuery(sql);
                if (params != null && params.length > 0) {
		    		for (int i = 0; i < params.length; i++) {
		    			query.setParameter(i, params[i]);
		    		}
		    	}
                return (Map<String, Object>) query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP).uniqueResult(); //返回值为map集合 且为唯一值（只能返回一条数据）
            }  
        });
	}
	
	@Override
	public List<T> findAllBySql(Class<T> clazz, String sql, Object params) throws Exception {
		return findAllBySql(clazz, sql, new Object[]{params});
	}
	
	/**
	 * 通过原生sql查询全部信息，用于导出报表查询等
	 * @param clazz 查询结果集Object数组根据转换器转换时指定的转换目标类型
	 * @param sql 原生sql语句
	 * @param params 参数
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<T> findAllBySql(final Class<T> clazz, final String sql, final Object[] params) throws Exception {
		return (List<T>) getHibernateTemplate().execute(new HibernateCallback<Object>() {
			public List<T> doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.createSQLQuery(sql);
		    	if (params != null && params.length > 0) {
		    		for (int i = 0; i < params.length; i++) {
		    			query.setParameter(i, params[i]);
		    		}
		    	}
		    	//通过Transformers将结果集数组映射为指定类型对象
		    	//query.setResultTransformer(Transformers.aliasToBean(clazz));
		    	List<T> data = query.setResultTransformer(new AliasToBeanResultTransformer(clazz)).list();
		        return data;
			}
		});
	}
	
	/**
	 * 将sql中的全部数据查出来，返回值为一个List<Map<String, Object>>
	 * @param clazz 查询结果集Object数组根据转换器转换时指定的转换目标类型
	 * @param sql 原生sql语句
	 * @param params 参数
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> findMapListBySql(final String sql, final Object[] params) throws Exception {
		return (List<Map<String, Object>>) getHibernateTemplate().execute(new HibernateCallback<Object>() {
			public List<Map<String, Object>> doInHibernate(Session session) throws HibernateException, SQLException {
				Query query = session.createSQLQuery(sql);
		    	if (params != null) {
		    		for (int i = 0; i < params.length; i++) {
		    			query.setParameter(i, params[i]);
		    		}
		    	}
		    	//通过Transformers将结果集数组转换为Map
		    	query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
		    	List<Map<String, Object>> data = query.list();
				return data;
			}
		});
	}
	
	@Override
	public Integer findCountBySql(final String countSql, final Object[] params) throws Exception {
        return getHibernateTemplate().execute(new HibernateCallback<Integer>() {
            public Integer doInHibernate(Session session) throws HibernateException, SQLException {
                return executePageCountQueryBySql(session, countSql, params);
            }
        });
    }
	
	/**
	 * 根据原生sql查询返回Obejct数组
	 * @param sql 原生sql
	 * @param params 参数数组对象
	 * @param curPage 当前页
	 * @param pageSize 每页显示数
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Page<T> findBySql(final String sql, final String countSql, final Object[] params, final int curPage, 
			final int pageSize) throws Exception {
        return (Page<T>) getHibernateTemplate().execute(new HibernateCallback<Object>() {
            public Object doInHibernate(Session session) throws HibernateException, SQLException {
            	int totalRow = executePageCountQueryBySql(session, countSql, params);
                Query query = session.createSQLQuery(sql);
                if (params != null) {
                    for (int i = 0; i < params.length; i++) {
                        query.setParameter(i, params[i]);
                    }
                }
                List<T> data = query.setFirstResult(pageSize * (curPage - 1)).setMaxResults(pageSize).list();
                Page<T> page = new Page<T>(curPage, pageSize, totalRow, data);
                return page;
            }
        });
    }
	
	@Override
	public Page<T> findBySql(Class<T> clazz, String sql, String countSql, 
			Object params, int curPage, int pageSize) throws Exception {
		return findBySql(clazz, countSql, sql, new Object[]{params}, curPage, pageSize);
	}
	
    /**
     * 原生sql查询，根据传入类型clazz返回对应类型的结果集集合（使用转换器转换结果集数组）
     * @param clazz 查询结果集Object数组根据转换器转换时指定的类型
     * @param sql 原生sql
     * @param params 参数数组对象
     * @param curPage 当前页
     * @param pageSize 每页显示数
     * @return
     */
    @SuppressWarnings("unchecked")
    @Override
	public Page<T> findBySql(final Class<T> clazz, final String sql, final String countSql, final Object[] params, 
			final int curPage, final int pageSize) throws Exception {
    	return (Page<T>) getHibernateTemplate().execute(new HibernateCallback<Object>() {
    		public Object doInHibernate(Session session) throws HibernateException, SQLException {

    			int totalRow = executePageCountQueryBySql(session, countSql, params);
    	    	Query query = session.createSQLQuery(sql);
    	    	if (params != null) {
    	    		for (int i = 0; i < params.length; i++) {
    	    			query.setParameter(i, params[i]);
    	    		}
    	    	}
    	    	//通过Transformers将结果集数组映射为指定类型对象
    	    	//query.setResultTransformer(Transformers.aliasToBean(clazz));
    	    	query.setResultTransformer(new AliasToBeanResultTransformer(clazz));
    	    	List<T> data = query.setFirstResult(pageSize * (curPage - 1)).setMaxResults(pageSize).list();
    	    	Page<T> page = new Page<T>(curPage, pageSize, totalRow, data);
    	    	return page;
    		}
    	});
    }
    
    @SuppressWarnings("unchecked")
    @Override
	public Page<List<Map<String, Object>>> findMapListBySql(final String sql, final String countSql, final Object[] params, 
			final int curPage, final int pageSize) throws Exception {
    	return (Page<List<Map<String, Object>>>) getHibernateTemplate().execute(new HibernateCallback<Object>() {
    		public Object doInHibernate(Session session) throws HibernateException, SQLException {
    			int totalRow = executePageCountQueryBySql(session, countSql, params);
    	    	
    	    	Query query = session.createSQLQuery(sql);
    	    	if (params != null) {
    	    		for (int i = 0; i < params.length; i++) {
    	    			query.setParameter(i, params[i]);
    	    		}
    	    	}
    	    	//通过Transformers将结果集数组转换为Map
    	    	query.setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
    	    	List<List<Map<String, Object>>> data = query.setFirstResult(pageSize * (curPage - 1)).setMaxResults(pageSize).list();
    	    	Page<List<Map<String, Object>>> page = new Page<List<Map<String, Object>>>(curPage, pageSize, totalRow, data);
    	    	return page;
    		}
    	});
    }
    
    //**********************	 Hibernate QBC查询		*******************
    
    /**
     * 查询全部，通过Criteria
     * @return
     */
    @Override
    public List<T> findAllByCriteria() throws Exception {
		return findByCriteria();
	}
    
    @Override
    public List<T> findByCriteria(final Criterion... criterion) throws Exception {
		@SuppressWarnings("unchecked")
		List<T> list = getHibernateTemplate().executeFind(
				new HibernateCallback<List<T>>() {
					public List<T> doInHibernate(Session session) throws HibernateException, SQLException {
						Criteria criteria = session.createCriteria(entityClass);
						for (Criterion c : criterion) {
							if (c != null) {
								criteria.add(c);
							}
						}
						return criteria.list();
					}
				}
			);
		return list;
	}
    
    /**
	 * 按Criteria查询唯一对象.
	 * 
	 * @param criterions 数量可变的Criterion.
	 */
	@SuppressWarnings("unchecked")
	@Override
	public T findByCriterionUnique(final Criterion... criterions) throws Exception {
		return (T) createCriteria(criterions).uniqueResult();
	}
	
	/**
	 * 按Criteria查询对象列表.
	 * 
	 * @param criterions 数量可变的Criterion.
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<T> findByCriterion(final Criterion... criterions) throws Exception {
		return createCriteria(criterions).list();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Page<T> findPageByCriterion(final Criterion[] criterions, 
			int curPage, int pageSize) throws Exception {
	
		Criteria criteria = createCriteria(criterions);
		// 执行Count查询
		int totalRow = (Integer) criteria.setProjection(Projections.rowCount()).uniqueResult();
		criteria.setProjection(null);
		
        List<T> data = criteria.setFirstResult(pageSize * (curPage - 1)).setMaxResults(pageSize).list();
		return new Page<T>(curPage, pageSize, totalRow, data);
	}
    
    /**
	 * 根据Criterion条件创建Criteria.
	 * 
	 * 本类封装的find()函数全部默认返回对象类型为T,当不为T时使用本函数.
	 * 
	 * @param criterions 数量可变的Criterion.
	 */
	public Criteria createCriteria(final Criterion... criterions) throws Exception {
		Criteria criteria = getSession().createCriteria(entityClass);
		for (Criterion c : criterions) {
			criteria.add(c);
		}
		return criteria;
	}
	
    
    @SuppressWarnings("unchecked")
	@Override
	public T findByCriteria(final DetachedCriteria detachedCriteria) throws Exception {
		return (T) getHibernateTemplate().execute(new HibernateCallback<Object>() {
			@Override
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				return (Object) detachedCriteria.getExecutableCriteria(session).uniqueResult();
			}
		});
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<T> findAllByCriteria(final DetachedCriteria detachedCriteria) throws Exception {
		return (List<T>) getHibernateTemplate().execute(new HibernateCallback<Object>() {
			@Override
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				return detachedCriteria.getExecutableCriteria(session).list();
			}
		});
	}

	@SuppressWarnings("unchecked")
	@Override
	public Page<T> findByCriteria(final DetachedCriteria detachedCriteria, 
			final int curPage, final int pageSize) throws Exception {
		return (Page<T>) getHibernateTemplate().execute(new HibernateCallback<Object>() {
			@Override
			public Object doInHibernate(Session session) throws HibernateException, SQLException {
				
				Criteria criteria = detachedCriteria.getExecutableCriteria(session);
		    	int totalRow = (Integer) criteria.setProjection(Projections.rowCount()).uniqueResult();
		    	criteria.setProjection(null);
		    	
		        List<T> data = criteria.setFirstResult(pageSize * (curPage - 1)).setMaxResults(pageSize).list();
		        Page<T> page = new Page<T>(curPage, pageSize, totalRow, data);
		        return page;
			}
		});
	}
    
    /**
     * hql 分页查询统计
     * @param session
     * @param countHql
     * @param params
     * @return
     * @throws RuntimeException
     */
    private int executePageCountQueryByHql(Session session, String countHql, Object[] params) throws RuntimeException {
    	Query query = session.createQuery(countHql);
        if (params != null) {
            for (int i = 0; i < params.length; i++) {
                query.setParameter(i, params[i]);
            }
        }
        int totalRow =0;
		try {
			totalRow = Integer.valueOf(query.uniqueResult().toString());
		} catch (Exception e) {
			logger.error("分页统计结果类型转换异常", e);
		}
		return totalRow;
    }
    
    /**
     * sql 分页查询统计
     * @param session
     * @param countSql
     * @param params
     * @return
     * @throws RuntimeException
     */
    private int executePageCountQueryBySql(Session session, String countSql, Object[] params) throws RuntimeException {
    	Query query = session.createSQLQuery(countSql);
    	if (params != null) {
    		for (int i = 0; i < params.length; i++) {
    			query.setParameter(i, params[i]);
    		}
    	}
    	int totalRow =0;
    	try {
    		totalRow = Integer.valueOf(query.uniqueResult().toString());
    	} catch (Exception e) {
    		logger.error("分页统计结果类型转换异常", e);
    	}
    	return totalRow;
    }
    
    //**********************	创建Query对象	**************
    
    /**
     * 
     * @param session
     * @param hql
     * @param params 数量可变的参数,按顺序绑定.
     * @return
     */
    protected Query createQuery(Session session, String hql, Object[] params)throws Exception {
    	Query query = session.createQuery(hql);
    	if(params != null && params.length > 0){
    		for (int i = 0; i < params.length; i++) {
				query.setParameter(i, params[i]);
			}
    	}
    	return query;
    }
    
    /**
     * 
     * @param hql
     * @param params 数量可变的参数,按顺序绑定.
     * @return
     */
    protected Query createQuery(final String hql, final Object[] objects)throws Exception {
    	return getHibernateTemplate().execute(new HibernateCallback<Query>() {
    		@Override
    		public Query doInHibernate(Session session) throws HibernateException, SQLException {
    			Query query = session.createSQLQuery(hql);
    			if(objects != null && objects.length > 0){
    				for (int i = 0; i < objects.length; i++) {
    					query.setParameter(i, objects[i]);
    				}
    	    	}
    			return query;
    		}
		});
    }
    
    /**
     * 
     * @param session
     * @param hql
     * @param params 命名参数,按名称绑定.
     * @return
     */
    protected Query createQuery(Session session, String hql, Map<String, Object> params)throws Exception {
    	Query query = session.createQuery(hql);
    	if(params != null && params.size() > 0){
    		query.setProperties(params);
    	}
    	return query;
    }
    
    /**
     * 
     * @param session
     * @param hql
     * @param params 命名参数,按名称绑定.
     * @return
     */
    protected Query createQuery(final String hql, final Map<String, Object> params)throws Exception {
    	return getHibernateTemplate().execute(new HibernateCallback<Query>() {
    		@Override
    		public Query doInHibernate(Session session) throws HibernateException, SQLException {
    			Query query = session.createSQLQuery(hql);
    			if(params != null && params.size() > 0){
    	    		query.setProperties(params);
    	    	}
    			return query;
    		}
		});
    }
    
    /**
     * 创建SQLQuery对象
     * @param session
     * @param hql
     * @param objects 数量可变的参数,按顺序绑定.
     * @return
     */
    protected Query createSQLQuery(Session session, String sql, Object...objects)throws Exception {
    	Query query = session.createSQLQuery(sql);
    	if(objects != null && objects.length > 0){
    		for (int i = 0; i < objects.length; i++) {
				query.setParameter(i, objects[i]);
			}
    	}
    	return query;
    }
    
    /**
     * 创建SQLQuery对象
     * @param hql
     * @param objects 数量可变的参数,按顺序绑定.
     * @return
     */
    protected Query createSQLQuery(final String sql, final Object...objects)throws Exception {
    	return getHibernateTemplate().execute(new HibernateCallback<Query>() {
    		@Override
    		public Query doInHibernate(Session session) throws HibernateException, SQLException {
    			Query query = session.createSQLQuery(sql);
    			if(objects != null && objects.length > 0){
    				for (int i = 0; i < objects.length; i++) {
    					query.setParameter(i, objects[i]);
    				}
    	    	}
    			return query;
    		}
		});
    }
    
    /**
     * 创建SQLQuery对象
     * @param session
     * @param hql
     * @param objects 命名参数,按名称绑定.
     * @return Query
     */
    protected Query createSQLQuery(Session session, String sql, Map<String, Object> objects)throws Exception {
    	
    	Query query = session.createSQLQuery(sql);
    	if(objects != null && objects.size() > 0){
    		query.setProperties(objects);
    	}
    	return query;
    }

    /**
     * 创建SQLQuery对象
     * @param hql
     * @param objects 命名参数,按名称绑定.
     * @return Query
     */
    protected Query createSQLQuery(final String sql, final Map<String, Object> objects)throws Exception {
    	
    	return getHibernateTemplate().execute(new HibernateCallback<Query>() {
    		@Override
    		public Query doInHibernate(Session session) throws HibernateException, SQLException {
    			Query query = session.createSQLQuery(sql);
    			if(objects != null && objects.size() > 0){
    	    		query.setProperties(objects);
    	    	}
    			return query;
    		}
		});
    }
    
    
    //*******************************	通过hql批量操作	**********************//

    @Override
    public int batchByHql(String hql) throws Exception {
    	return getHibernateTemplate().bulkUpdate(hql);
    };
    
    @Override
    public int batchByHql(String hql, Object object) throws Exception {
    	return getHibernateTemplate().bulkUpdate(hql, object);
    }
    
    @Override
	public int batchByHql(String hql, Object... objects) throws Exception {
    	return getHibernateTemplate().bulkUpdate(hql, objects);
	}
    
    /**
     * 采用HQL语句实现批量操作<br>
     * @param hql HQL语句
     * @return 处理的条数
     */
    @Override
    public int execHQL(final String hql) throws Exception {
        return execHQL(hql, new Object[]{});
    }

	/**
     * 采用HQL语句实现批量操作,单参数<br>
     * @param hql HQL语句
     * @return 处理的条数
     */
    @Override
    public int execHQL(final String hql, final Object value) throws Exception {
        return execHQL(hql, new Object[]{value});
    }

    /**
     * 采用HQL语句实现批量操作,多参数<br>
     * @param hql HQL语句
     * @return 处理的条数
     */
    @Override
    public int execHQL(final String hql, final Object[] values) throws Exception {
    	
        Integer count = (Integer) this.getHibernateTemplate().execute(new HibernateCallback<Object>() {
            public Object doInHibernate(Session session) {
                Query query = session.createQuery(hql);
                for (int i = 0; i < values.length; i++) {
                    query.setParameter(i, values[i]);
                }
                int count = query.executeUpdate();
                return new Integer(count);
            }
        });
        return count.intValue();
    }
    
    /**
	 * jdbc 批处理 
	 * @param sql
	 * @param list 参数，list中可以是基本类型或者是包含基本类型的List
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void batchExecute(final String sql, final List<T> list) throws Exception {
		
		getHibernateTemplate().execute(new HibernateCallback<T>() {
			
			@Override
			public T doInHibernate(Session session) throws HibernateException,
					SQLException {
				
				Connection conn = null;
				PreparedStatement ps = null;
				try {
					conn = SessionFactoryUtils.getDataSource(session.getSessionFactory()).getConnection();
					conn.setAutoCommit(false);		//关闭自动提交
					ps = conn.prepareStatement(sql);
					logger.info("批处理开始："+System.currentTimeMillis());
					
					for (int i = 1; i <= list.size(); i++) {
						
						Object objs = list.get(i-1);
						if(objs instanceof List) {
							
							List<Object> values = (List<Object>) objs;
							for(int j = 1; j <= values.size(); j++){
								Object value = values.get(j-1);
								setParameters(ps, j, value);
							}
						} else {
							setParameters(ps, i, objs);
						}
						
						ps.addBatch();
						if(i % 100 == 0){
							ps.executeBatch();	//执行批处理
							conn.commit();		//提交事务
							ps.clearBatch();
						}
					}
					
					ps.executeBatch();	//执行批处理
					conn.commit();		//提交事务
					ps.clearBatch();
					
					logger.info("批处理结束："+System.currentTimeMillis());
				} catch (Exception e) {
					conn.rollback();
					e.printStackTrace();
					throw new RuntimeException();
				} finally {
					if(ps != null && !conn.isClosed()) {
						ps.close();
						conn.close();
					}
				}
				return null;
			}
		});
	}
	
	/**
	 * 参数设置通用方法
	 * @param ps
	 * @param j
	 * @param value
	 * @throws SQLException
	 */
	public void setParameters(PreparedStatement ps, int j, Object value) throws SQLException {
		
		if (value != null) {
            if (value instanceof java.lang.Integer) {
            	
                ps.setInt(j, (Integer) value);
            } else if (value instanceof java.lang.Long) {
            	
                ps.setLong(j, (Long) value);
            } else if (value instanceof java.util.Date) {
            	
                ps.setTimestamp(j, new java.sql.Timestamp(((Date) value).getTime()));
            } else if (value instanceof java.sql.Date) {
            	
                ps.setDate(j, new java.sql.Date(((Date) value).getTime()));
            } else if (value instanceof java.lang.String) {
            	
                ps.setString(j, value.toString());
            } else if (value instanceof java.lang.Double) {
            	
                ps.setDouble(j, (Double) value);
            } else if (value instanceof java.lang.Byte) {
            	
                ps.setByte(j, (Byte) value);
            } else if (value instanceof java.lang.Character) {
            	
                ps.setString(j, value.toString());
            } else if (value instanceof java.lang.Float) {
            	
                ps.setFloat(j, (Float) value);
            } else if (value instanceof java.lang.Boolean) {
            	
                ps.setBoolean(j, (Boolean) value);
            } else if (value instanceof java.lang.Short) {
            	
                ps.setShort(j, (Short) value);
            } else {
                ps.setObject(j, value);
            }
        } else {
            ps.setNull(j, Types.NULL);
        }
	}

}
