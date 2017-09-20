/**
 * 
 */
package edu.fjnu.cse.service;

import edu.fjnu.cse.domain.Order;
import edu.fjnu.cse.domain.OrderQueryHelper;
import edu.fjnu.cse.domain.PageBean;

/**
 * @author Javon
 *
 */
public interface OrderService {

	void saveOrder(Order order);
	
	PageBean<Order> loadAllByPage(OrderQueryHelper helper, PageBean<Order> page);

	Order loadOrderById(int orderId);

}
