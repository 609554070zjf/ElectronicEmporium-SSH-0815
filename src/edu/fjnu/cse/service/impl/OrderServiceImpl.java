/**
 * 
 */
package edu.fjnu.cse.service.impl;

import edu.fjnu.cse.dao.OrderDao;
import edu.fjnu.cse.domain.Order;
import edu.fjnu.cse.domain.OrderQueryHelper;
import edu.fjnu.cse.domain.PageBean;
import edu.fjnu.cse.service.OrderService;

/**
 * @author Javon
 *
 */
public class OrderServiceImpl implements OrderService{
	
	private OrderDao orderDao;

	public OrderDao getOrderDao() {
		return orderDao;
	}

	public void setOrderDao(OrderDao orderDao) {
		this.orderDao = orderDao;
	}

	@Override
	public void saveOrder(Order order) {
		orderDao.save(order);
	}

	@Override
	public PageBean<Order> loadAllByPage(OrderQueryHelper helper,
			PageBean<Order> page) {
		page.setTotalRecord(orderDao.cntOrderByHelper(helper));
		page.setDatas(orderDao.loadScopedOrdersByHelper(helper, page.getStartIndex(), page.getEndIndex()-page.getStartIndex()));
		return page;
	}

	@Override
	public Order loadOrderById(int orderId) {
		return orderDao.loadOrderById(orderId);
	}
	
	
}
