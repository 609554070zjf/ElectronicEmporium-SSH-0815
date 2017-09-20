/**
 * 
 */
package edu.fjnu.cse.dao.impl;

import java.util.Collection;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;

import edu.fjnu.cse.dao.UserDao;
import edu.fjnu.cse.domain.Goods;
import edu.fjnu.cse.domain.GoodsQueryHelper;
import edu.fjnu.cse.domain.User;
import edu.fjnu.cse.domain.UserQueryHelper;
import edu.fjnu.cse.utils.StringUtil;

/**
 * @author Javon
 *
 */
public class UserDaoImpl implements UserDao{
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
	public void save(User user) {
		session = getSession();
		session.save(user);
		session.flush();
		closeSession(session);
	}

	@Override
	public void delete(int userId) {
		session = getSession();
		User user = session.load(User.class, userId);
		session.delete(user);
		session.flush();
		closeSession(session);
	}

	@Override
	public void update(User user) {
		session = getSession();
		session.saveOrUpdate(user);
		session.flush();
		closeSession(session);		
	}

	@Override
	public int cntAdminByHelper(UserQueryHelper helper) {
		session = getSession();
		DetachedCriteria detachedCriteria = this.getCriteriaByHelper(helper,"admin");
		detachedCriteria.setProjection(Projections.rowCount());
		int cnt  = Integer.parseInt(detachedCriteria.getExecutableCriteria(session).uniqueResult().toString());
		closeSession(session);
		return cnt;
	}

	@Override
	public List<User> loadScopedAdminByHelper(UserQueryHelper helper,
			Integer startIndex, int fetchSize) {
		session = getSession();
		DetachedCriteria detachedCriteria = this.getCriteriaByHelper(helper,"admin");
		detachedCriteria.addOrder(Order.asc("userId"));
		Session session = getSession();
		List<User> userList = detachedCriteria.getExecutableCriteria(session)
						        .setFirstResult(startIndex)
						        .setMaxResults(fetchSize)
						        .list();
		session.flush();
		closeSession(session);
		return userList;
	}

	@Override
	public User getUserById(int userId) {
		session = getSession();
		User user = session.get(User.class, userId);
		session.flush();
		closeSession(session);
		return user;
	}
	
	private DetachedCriteria getCriteriaByHelper(UserQueryHelper helper,String identify){
		
	    DetachedCriteria criteria = DetachedCriteria.forClass(User.class);
		
		if(StringUtil.isNotEmpty(helper.getQryUserName())){
			criteria.add(Restrictions.like("userName", "%"+helper.getQryUserName()+"%"));
		}
		
		if(StringUtil.isNotEmpty(helper.getQryUserSex())){
			criteria.add(Restrictions.eq("sex", helper.getQryUserSex()));
		}
		if(identify.equals("admin")){
			criteria.add(Restrictions.in("identify",new Integer[]{1,0}));
		}
		else if(identify.equals("user")){
			criteria.add(Restrictions.eq("identify", 2));
		}
		
	    return criteria;
	}

	@Override
	public User findUserByUserNameAndPWD(User user) {
		String hql = "from User where userName=:userName and password=:password and identify=:identify";
		session = getSession();
		Query query = session.createQuery(hql);
		query.setString("userName", user.getUserName());
		query.setString("password", user.getPassword());
		query.setInteger("identify", user.getIdentify());
		user = (User) query.uniqueResult();
		closeSession(session);
		return user;
	}

	@Override
	public void updatePassword(User user) {
		String sql = "update t_user set password=:password where user_id=:id";
		session = getSession();
		Query query = session.createSQLQuery(sql);
		query.setString("password", user.getPassword());
		query.setInteger("id", user.getUserId());
		query.executeUpdate();
		session.flush();
		closeSession(session);
	}

	@Override
	public int cntUserByHelper(UserQueryHelper helper) {
		session = getSession();
		DetachedCriteria detachedCriteria = this.getCriteriaByHelper(helper,"user");
		detachedCriteria.setProjection(Projections.rowCount());
		int cnt  = Integer.parseInt(detachedCriteria.getExecutableCriteria(session).uniqueResult().toString());
		closeSession(session);
		return cnt;
	}

	@Override
	public Collection<User> loadScopedUserByHelper(UserQueryHelper helper,
			int startIndex, int fetchSize) {
		session = getSession();
		DetachedCriteria detachedCriteria = this.getCriteriaByHelper(helper,"user");
		detachedCriteria.addOrder(Order.asc("userId"));
		Session session = getSession();
		List<User> userList = detachedCriteria.getExecutableCriteria(session)
						        .setFirstResult(startIndex)
						        .setMaxResults(fetchSize)
						        .list();
		session.flush();
		closeSession(session);
		return userList;
	}


}
