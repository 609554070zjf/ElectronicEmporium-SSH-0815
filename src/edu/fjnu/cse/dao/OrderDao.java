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
	/**
	 * 保存订单
	 * @param order
	 */
	void save(Order order);
	
	/**
	 * 修改订单
	 * @param order
	 */
	void update(Order order);

	/**
	 * 查询订单记录数（分页+组合查询）
	 * @param helper
	 * @return
	 */
	int cntOrderByHelper(OrderQueryHelper helper);

	/**
	 * 查询订单列表（分页+组合查询）
	 * @param helper
	 * @param startIndex
	 * @param i
	 * @return
	 */
	Collection<Order> loadScopedOrdersByHelper(OrderQueryHelper helper,
			int startIndex, int i);

	/**
	 * 根据订单id查询订单
	 * @param orderId
	 * @return
	 */
	Order loadOrderById(int orderId);
	
}
