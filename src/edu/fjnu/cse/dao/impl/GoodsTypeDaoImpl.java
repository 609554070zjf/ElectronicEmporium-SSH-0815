/**
 * 
 */
package edu.fjnu.cse.dao.impl;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import edu.fjnu.cse.dao.GoodsTypeDao;
import edu.fjnu.cse.domain.GoodsType;

/**
 * @author Javon
 *
 */
public class GoodsTypeDaoImpl implements GoodsTypeDao{
	
	private SessionFactory sessionFactory;
	private Session session;
	
	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

   //获得开启着的Session  
   public Session getSession(){  
       return sessionFactory.openSession(); 
   }  
     
      //关闭Session  
   public void closeSession(Session session){  
       if(session!=null){  
           if(session.isOpen()){  
               session.close();  
           }  
       }  
   }
	
	@Override
	public void save(GoodsType goodsType) {
		session = getSession();
		session.save(goodsType);
		session.flush();
		closeSession(session);
	}

	@Override
	public void update(GoodsType goodsType) {
		session = getSession();
		session.saveOrUpdate(goodsType);
		session.flush();
		closeSession(session);
	}

	@Override
	public void delete(String goodsTypeId) {
		session = getSession();
		GoodsType goodsType = session.get(GoodsType.class, goodsTypeId);
		goodsType.setActive("0");
		if(goodsType.getParent() == null){
			Set<GoodsType> list = goodsType.getSubGoodsType();
			for(GoodsType type : list){
				type.setActive("0");
			}
		}
		session.saveOrUpdate(goodsType);
		session.flush();
		closeSession(session);
		
	}

	@Override
	public List<GoodsType> loadAll() {
		session = getSession();
		String hql = "from GoodsType where active=:active";
		Query query = session.createQuery(hql);
		query.setString("active", "1");
		List<GoodsType> goodsTypeList = (List<GoodsType>)query.list();
		closeSession(session);
		return goodsTypeList;
	}

	@Override
	public Set<GoodsType> loaAllByPage(GoodsType goodsType, int start, int size) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public GoodsType getGoodsTypeById(String goodsTypeId) {
		session = getSession();
		GoodsType goodsType = (GoodsType)session.get(GoodsType.class, goodsTypeId);
		closeSession(session);
		return goodsType;
	}

	@Override
	public int count(GoodsType goodsType) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<GoodsType> loadAllParent() {
		session = getSession();
//		String hql = "select new GoodsType(id,goodsTypeName,active) from GoodsType where parent is null and active=:active";
		String hql = "from GoodsType where parent is null and active=:active";
		Query query = session.createQuery(hql);
		query.setString("active", "1");
		List<GoodsType> goodsTypes = query.list();
		closeSession(session);
		return goodsTypes;
	}

	@Override
	public List<GoodsType> loadSubTypeByParentId(String parentId) {
		session = getSession();
		String hql = "from GoodsType where parent=:parentId and active=:active";
		Query query = session.createQuery(hql);
		query.setString("parentId", parentId);
		query.setString("active", "1");
		List<GoodsType> goodsTypes = query.list();
		closeSession(session);
		return goodsTypes;
	}


}
