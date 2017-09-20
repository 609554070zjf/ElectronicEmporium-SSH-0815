package edu.fjnu.cse.test;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import edu.fjnu.cse.dao.GoodsTypeDao;
import edu.fjnu.cse.domain.GoodsType;

public class GoodsTypeDaoImplTest {
	
//	private SessionFactory sessionFactory;
//	private Session session;
	
	private GoodsTypeDao goodsTypeDao;

	@Before
	public void setUp() throws Exception {
		ApplicationContext ctx = 
				   new FileSystemXmlApplicationContext("classpath:applicationContext.xml");
		goodsTypeDao = (GoodsTypeDao) ctx.getBean("goodsTypeDao");
//		sessionFactory = (SessionFactory)ctx.getBean("sessionFactory");
//		session = sessionFactory.openSession();
	}

	@After
	public void tearDown() throws Exception {
//		session.close();
//		sessionFactory.close();
	}

	@Test
	public void testSave() {
		GoodsType goodsType = new GoodsType();
		goodsType.setGoodsTypeName("家用电器");
		goodsType.setActive("1");
		goodsType.setParent(null);
		goodsTypeDao.save(goodsType);
	}

}
