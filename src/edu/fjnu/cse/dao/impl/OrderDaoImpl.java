/**
 * 
 */
package edu.fjnu.cse.dao.impl;

import java.util.Collection;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import edu.fjnu.cse.dao.OrderDao;
import edu.fjnu.cse.domain.Goods;
import edu.fjnu.cse.domain.Order;
import edu.fjnu.cse.domain.OrderQueryHelper;
import edu.fjnu.cse.domain.User;
import edu.fjnu.cse.utils.StringUtil;

/**
 * @author Javon
 *
 */
public class OrderDaoImpl implements OrderDao{
	
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
	public void save(Order order) {
		session = getSession();
		session.save(order);
		session.flush();
		closeSession(session);
	}

	@Override
	public void update(Order order) {
		session = getSession();
		session.saveOrUpdate(order);
		closeSession(session);
	}

	@Override
	public int cntOrderByHelper(OrderQueryHelper helper) {
		DetachedCriteria detachedCriteria = this.genCriteriaByHelper(helper);
		detachedCriteria.setProjection(Projections.rowCount());
		Session session = this.getSession();
		int cnt  = Integer.parseInt(detachedCriteria.getExecutableCriteria(session).uniqueResult().toString());
		closeSession(session);
		return cnt;
	}

	@Override
	public Collection<Order> loadScopedOrdersByHelper(OrderQueryHelper helper,
			int startIndex, int fetchSize) {
		DetachedCriteria detachedCriteria = this.genCriteriaByHelper(helper);
		Session session = getSession();
		List<Order> orderList = (List<Order>)detachedCriteria.getExecutableCriteria(session)
						        .setFirstResult(startIndex)
						        .setMaxResults(fetchSize)
						        .list();
		closeSession(session);
		return orderList;
	}
	
	private DetachedCriteria genCriteriaByHelper(OrderQueryHelper helper){
		
	    DetachedCriteria criteria = DetachedCriteria.forClass(Order.class);
	    
		if(StringUtil.isNotEmpty(helper.getOrderState())){
			criteria.add(Restrictions.eq("orderState", helper.getOrderState()));
		}
		
		if(helper.getQryOrderDate()!=null){
			criteria.add(Restrictions.eq("orderDate", helper.getQryOrderDate()));
		}
		if(helper.getUser() != null){
			criteria.createCriteria("user").add(Restrictions.eq("userId", helper.getUser().getUserId()));
		}
		
	    return criteria;
	}

	@Override
	public Order loadOrderById(int orderId) {
		session = getSession();
		Order order =  (Order)session.get(Order.class, orderId);
		closeSession(session);
		return order;
	}

	
}
