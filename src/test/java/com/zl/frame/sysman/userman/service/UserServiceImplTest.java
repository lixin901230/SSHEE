package com.zl.frame.sysman.userman.service;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.zl.frame.core.dao.impl.HibernateBaseDaoImpl;
import com.zl.frame.core.pager.Page;
import com.zl.frame.sysman.userman.bean.User;
import com.zl.frame.sysman.userman.dao.IUserDao;

/**
 * @desc：用户信息管理持久层接口单元测试
 * @author lixin
 * @date: 2013-11-21上午12:38:26
 */  
//@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration(locations={"classpath:spring/applicationContext-base.xml"})
public class UserServiceImplTest {
	
	@Autowired
	private IUserDao userDao;
	
	ApplicationContext applicationContext = new ClassPathXmlApplicationContext("spring/applicationContext-base.xml");
	
	/**
	 * 分页查询用户信息
	 * @prama String hql, Page<User> page, Object[] params
	 */
	@Test
	public void testFindUserListByPage(){

		try {
			userDao = (IUserDao) applicationContext.getBean("userDao");

			Page<User> page =  new Page<User>();
			String hql = "from User u";
			
			
			StringBuffer countHql = new StringBuffer();
			countHql.append("select count(*) ");
			countHql.append(hql);
			
			page = userDao.findByHql(hql, countHql.toString(), new Object[]{}, page.getCurPage(), page.getPageSize());
			
			System.out.println(page);
		} catch (BeansException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testMap() {
		HibernateBaseDaoImpl hibernateBaseDao = (HibernateBaseDaoImpl) applicationContext.getBean("hibernateBaseDao");
		try {
			String sql = "select id, userName, email from t_sys_user where id=?";
			Map<String, Object> map = hibernateBaseDao.findMapBySql(sql, new Object[]{"1"});
			System.out.println(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testMapPage() {
		HibernateBaseDaoImpl hibernateBaseDao = (HibernateBaseDaoImpl) applicationContext.getBean("hibernateBaseDao");
		try {
			String sql = "select id, userName, email from t_sys_user";
			String countSql = "select count(*) from t_sys_user";
			Page<List<Map<String, Object>>> page = hibernateBaseDao.findMapListBySql(sql, countSql, null, 1, 10);
			
			System.out.println(page);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testMapList() {
		HibernateBaseDaoImpl hibernateBaseDao = (HibernateBaseDaoImpl) applicationContext.getBean("hibernateBaseDao");
		try {
			String sql = "select id, userName, email from t_sys_user";
			List<Map<String, Object>> list = hibernateBaseDao.findMapListBySql(sql, null);
			
			System.out.println(list);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public IUserDao getUserDao() {
		return userDao;
	}
	public void setUserDao(IUserDao userDao) {
		this.userDao = userDao;
	}
	
}
