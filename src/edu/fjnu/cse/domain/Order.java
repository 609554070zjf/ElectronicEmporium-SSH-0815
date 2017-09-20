/**
 * 
 */
package edu.fjnu.cse.domain;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * @author Javon
 * 
 *         订单
 */
public class Order {

	public Order() {
		super();
		orderDate = new Date();
		checkState = "1";
		orderState = "0";
	}

	/** 订单编号 **/
	private int orderId;
	/** 用户编号 **/
	private User user;
	/**收货人姓名**/
	private String receiverName;
	/** 下单时间 **/
	private Date orderDate;
	/** 付款方式 （0：支付宝，1：微信,2:银联）**/
	private String payType;
	/** 发贷方式 （1：自提，0：送货上门）**/
	private String postType;
	/** 商品种类数 **/
	private int goodsTypeCnt;
	/** 商品总个数 **/
	private int goodsCnt;
	/** 订单总金额 **/
	private double totalMoney;
	/** 审核状态 (0:未审核，1：已审核)**/
	private String checkState;
	/** 订单状态(0:未完成，1：已完成) **/
	private String orderState;
	/**收货人电话**/
	private String phone;
	/**收货人地址**/
	private String address;
	/**收货人邮箱**/
	private String email;
	/**收货人邮编**/
	private String postCode;
	
	private Set<BuyCar> buycarList = new HashSet<BuyCar>();

	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public String getPostType() {
		return postType;
	}

	public void setPostType(String postType) {
		this.postType = postType;
	}

	public int getGoodsTypeCnt() {
		return goodsTypeCnt;
	}

	public void setGoodsTypeCnt(int goodsTypeCnt) {
		this.goodsTypeCnt = goodsTypeCnt;
	}

	public int getGoodsCnt() {
		return goodsCnt;
	}

	public void setGoodsCnt(int goodsCnt) {
		this.goodsCnt = goodsCnt;
	}

	public double getTotalMoney() {
		return totalMoney;
	}

	public void setTotalMoney(double totalMoney) {
		this.totalMoney = totalMoney;
	}

	public String getCheckState() {
		return checkState;
	}

	public void setCheckState(String checkState) {
		this.checkState = checkState;
	}

	public String getOrderState() {
		return orderState;
	}

	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}

	public String getReceiverName() {
		return receiverName;
	}

	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public Set<BuyCar> getBuycarList() {
		return buycarList;
	}

	public void setBuycarList(Set<BuyCar> buycarList) {
		this.buycarList = buycarList;
	}

	@Override
	public String toString() {
		return "Order [orderId=" + orderId 
				+ ", receiverName=" + receiverName + ", orderDate=" + orderDate
				+ ", payType=" + payType + ", postType=" + postType
				+ ", goodsTypeCnt=" + goodsTypeCnt + ", goodsCnt=" + goodsCnt
				+ ", totalMoney=" + totalMoney + ", checkState=" + checkState
				+ ", orderState=" + orderState + ", phone=" + phone
				+ ", address=" + address + ", email=" + email + ", postCode="
				+ postCode + "]";
	}

	
}
