/**
 * 
 */
package edu.fjnu.cse.domain;

import java.util.Date;

/**
 * @author Javon
 *
 */
public class OrderQueryHelper {
	private Date qryOrderDate;
	
	private String orderState;
	
	private User user;

	public Date getQryOrderDate() {
		return qryOrderDate;
	}

	public void setQryOrderDate(Date qryOrderDate) {
		this.qryOrderDate = qryOrderDate;
	}

	public String getOrderState() {
		return orderState;
	}

	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "OrderQueryHelper [qryOrderDate=" + qryOrderDate
				+ ", orderState=" + orderState + "]";
	}
	
}
