/**
 * 
 */
package edu.fjnu.cse.dao.impl;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import edu.fjnu.cse.dao.GoodsDao;
import edu.fjnu.cse.domain.Goods;
import edu.fjnu.cse.domain.GoodsQueryHelper;
import edu.fjnu.cse.utils.StringUtil;

/**
 * @author Javon
 * 
 */
public class GoodsDaoImpl implements GoodsDao {

	private SessionFactory sessionFactory;
	private Session session;

	public SessionFactory getSessionFactory() {
		return sessionFactory;
	}

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	// 获得开启着的Session
	public Session getSession() {
		return sessionFactory.openSession();
	}

	// 关闭Session
	public void closeSession(Session session) {
		if (session != null) {
			if (session.isOpen()) {
				session.close();
			}
		}
	}

	@Override
	public String save(Goods goods) {
		session = getSession();
		Serializable pKey  = session.save(goods);
		session.flush();
		closeSession(session);
		return pKey.toString();
	}

	@Override
	public void update(Goods goods) {
		session = getSession();
		session.saveOrUpdate(goods);
		session.flush();
		closeSession(session);
	}

	@Override
	public void delete(String goodsId) {
		session = getSession();
		Goods goods = session.load(Goods.class, goodsId);
		session.delete(goods);
		session.flush();
		closeSession(session);
	}

	@Override
	public List<Goods> loaAllByPage(Goods goods, int start, int size) {
		
		return null;
	}

	@Override
	public Goods getGoodsById(String goodsId) {
//		String hql = "from Goods where id=:id";
//		session = getSession();
//		Query query = session.createQuery(hql);
//		query.setString("id", goodsId);
//		Goods goods = (Goods)query.uniqueResult();
//		closeSession(session);
//		return goods;
		session = getSession();
		Goods goods =  (Goods)session.get(Goods.class, goodsId);
		closeSession(session);
		return goods;
	}

	@Override
	public int count(Goods goods) {
		String hql = "select count(*) from Goods";
		session = getSession();
		Query query = session.createQuery(hql);
		int cnt = (int) query.uniqueResult();
		closeSession(session);
		return cnt;
	}

	@Override
	public byte[] loadPicById(String id) {
		session = getSession();
		String hql = "select pic from Goods where id=:id";
		Query query = session.createQuery(hql);
		query.setString("id",id);
		byte[] pic = (byte[]) query.uniqueResult();
		session.flush();
//		closeSession(session);
		return pic;
//		return getGoodsById(id).getPic();
	}

	@Override
	public int cntGoodsByHelper(GoodsQueryHelper helper) {
		DetachedCriteria detachedCriteria = this.genCriteriaByHelper(helper);
		detachedCriteria.setProjection(Projections.rowCount());
		Session session = this.getSession();
		int cnt  = Integer.parseInt(detachedCriteria.getExecutableCriteria(session).uniqueResult().toString());
		closeSession(session);
		return cnt;
	}

	@Override
	public List<Goods> loadScopedGoodssByHelper(GoodsQueryHelper helper,
			Integer startIndex, int fetchSize) {
		DetachedCriteria detachedCriteria = this.genCriteriaByHelper(helper);
		detachedCriteria.addOrder(Order.asc("goodsName"));
		Session session = getSession();
		List<Goods> goodsList = (List<Goods>)detachedCriteria.getExecutableCriteria(session)
						        .setFirstResult(startIndex)
						        .setMaxResults(fetchSize)
						        .list();
		closeSession(session);
		return goodsList;
	}
	
	private DetachedCriteria genCriteriaByHelper(GoodsQueryHelper helper){
		
	    DetachedCriteria criteria = DetachedCriteria.forClass(Goods.class);
	    
//	    ProjectionList pList = Projections.projectionList();  
//	    pList.add(Projections.property("id")); 
//	    pList.add(Projections.property("goodsName")); 
//	    pList.add(Projections.property("goodsPrice")); 
//	    pList.add(Projections.property("leftCnt")); 
//	    pList.add(Projections.property("parentType")); 
//	    pList.add(Projections.property("subType")); 
//	    pList.add(Projections.property("enough")); 
//	    criteria.setProjection(pList);
	    
		if(StringUtil.isNotEmpty(helper.getQryParentId())){
			criteria.createCriteria("parentType").add(Restrictions.eq("id", helper.getQryParentId()));
		}
		
		if(StringUtil.isNotEmpty(helper.getQrySubId())){
			criteria.createCriteria("subType").add(Restrictions.eq("id", helper.getQrySubId()));
		}
		
		if(StringUtil.isNotEmpty(helper.getQryGoodsName())){
			criteria.add(Restrictions.like("goodsName", "%"+helper.getQryGoodsName()+"%"));
		}
		
		if(helper.getMinPrice()!=0.0){
			criteria.add(Restrictions.ge("goodsPrice", helper.getMinPrice()));
		}
		if(helper.getMaxPrice()!=0.0){
			criteria.add(Restrictions.le("goodsPrice", helper.getMaxPrice()));
	    }
		
		if(StringUtil.isNotEmpty(helper.getOrderField())){
			criteria.addOrder(Order.asc(helper.getOrderField()));
		}
	    return criteria;
	}

	@Override
	public void updateGoodsPicName(String picName,String id) {
		session = getSession();
		String sql = "update t_goods set goods_pic_name=:picName where goods_id=:id";
		Query query = session.createSQLQuery(sql);
		query.setString("picName", picName);
		query.setString("id", id);
		query.executeUpdate();
		session.flush();
		closeSession(session);
	}
	
}
