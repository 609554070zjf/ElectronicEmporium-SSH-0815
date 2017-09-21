/**
 * 
 */
package edu.fjnu.cse.action;

import java.util.HashSet;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import edu.fjnu.cse.domain.BuyCar;
import edu.fjnu.cse.domain.Goods;
import edu.fjnu.cse.domain.Order;
import edu.fjnu.cse.domain.OrderQueryHelper;
import edu.fjnu.cse.domain.PageBean;
import edu.fjnu.cse.domain.User;
import edu.fjnu.cse.service.OrderService;
import edu.fjnu.cse.service.impl.UserServiceImpl;

/**
 * @author Javon
 * 
 */
public class OrderAction extends ActionSupport implements ModelDriven<Order>,
		SessionAware {

	private Order order = new Order();
	private OrderService orderService;
	private Map<String, Object> session = null;
	private OrderQueryHelper helper = new OrderQueryHelper();
	private PageBean<Order> pb = new PageBean<Order>();
	private int pageCode = 1;

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	public OrderService getOrderService() {
		return orderService;
	}

	public void setOrderService(OrderService orderService) {
		this.orderService = orderService;
	}
	
	public OrderQueryHelper getHelper() {
		return helper;
	}

	public void setHelper(OrderQueryHelper helper) {
		this.helper = helper;
	}

	public int getPageCode() {
		return pageCode;
	}

	public void setPageCode(int pageCode) {
		this.pageCode = pageCode;
	}
	
	public PageBean<Order> getPb() {
		return pb;
	}

	public void setPb(PageBean<Order> pb) {
		this.pb = pb;
	}

	@Override
	public Order getModel() {
		return order;
	}

	/**
	 * 根据用户Id获取订单列表-个人订单中心
	 * @return
	 * @throws Exception
	 */
	public String loadOrderByUserId() throws Exception{
		User user = (User) session.get("user");
		helper.setUser(user);
		pb = orderService.loadAllByPage(helper, pb);
		return "load_order_page_all_user";
	}
	
	/**
	 * 根据订单Id获取订单信息-订单详情-用户
	 * @return
	 * @throws Exception
	 */
	public String getOrderByOrderId() throws Exception{
		User user = (User) session.get("user");
		helper.setUser(user);
		order  = orderService.loadOrderById(order.getOrderId());
		return "load_order_page_user";
	}
	
	/**
	 * 根据订单Id获取订单信息-订单详情-管理员
	 * @return
	 * @throws Exception
	 */
	public String getOrderByOrderIdAdmin() throws Exception{
		User user = (User) session.get("user");
		helper.setUser(user);
		order  = orderService.loadOrderById(order.getOrderId());
		return "load_order_page_user_admin";
	}

	/**
	 * 查询所有订单-订单管理-管理员
	 * @return
	 * @throws Exception
	 */
	public String loadAll() throws Exception {
		helper.setUser(null);
		pb = orderService.loadAllByPage(helper, pb);
		return "load_order_page_all";
	}

	/**
	 * 创建订单 
	 * @return
	 * @throws Exception
	 */
	public String createOrder() throws Exception {
		System.out.println(order);
		User user = (User) session.get("user");
		order.setUser(user);
		HashSet<BuyCar> buyCarSet = (HashSet<BuyCar>) session.get("buycar");
		order.getBuycarList().addAll(buyCarSet);
		for (BuyCar buycar : buyCarSet) {
			buycar.setOrder(order);
		}
		orderService.saveOrder(order);
		session.remove("buycar");
		return "order_success";
	}

}
