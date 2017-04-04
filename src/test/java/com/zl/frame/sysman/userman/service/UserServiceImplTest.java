package com.zl.frame.sysman.userman.service;

import org.junit.Test;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

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

	private IUserDao userDao;
	
	ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext-base.xml");
	
	/**
	 * 分页查询用户信息
	 * @prama String hql, Page<User> page, Object[] params
	 */
	@Test
	public void testFindUserListByPage(){

		try {
			Page<User> page =  new Page<User>();
			String hql = "from User u";
			
			userDao = (IUserDao) applicationContext.getBean("userDao");
			
			page = userDao.findByHql(hql, new Object[]{}, page.getCurPage(), page.getPageSize());
			System.out.println(page);
		} catch (BeansException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public IUserDao getUserDao() {
		return userDao;
	}
	@Autowired
	public void setUserDao(IUserDao userDao) {
		this.userDao = userDao;
	}
	
}
