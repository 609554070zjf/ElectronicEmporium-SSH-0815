/**
 * 
 */
package edu.fjnu.cse.dao;

import java.util.Collection;

import edu.fjnu.cse.domain.Order;
import edu.fjnu.cse.domain.OrderQueryHelper;

/**
 * @author Javon
 *
 */
public interface OrderDao {
	
	void save(Order order);
	
	void update(Order order);

	int cntOrderByHelper(OrderQueryHelper helper);

	Collection<Order> loadScopedOrdersByHelper(OrderQueryHelper helper,
			int startIndex, int i);

	Order loadOrderById(int orderId);
	
}
