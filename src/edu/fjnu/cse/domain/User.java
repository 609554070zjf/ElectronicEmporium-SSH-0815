package edu.fjnu.cse.domain;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * @author Javon
 * 
 *         用户
 */
public class User {
	
	public User() {
		super();
		freezes = "0";
	}

	/** ID **/
	private int userId;
	/** 用户名 **/
	private String userName;
	/** 密码 **/
	private String password;
	/** 身份（0：超级管理员，1：普通管理员，2：注册用户） **/
	private int identify;
	/**用户性别(0：女，1：男)**/
	private String sex;
	/**真实姓名**/
	private String realName;
	/**出生日期**/
	private Date birthday;
	/**邮箱**/
	private String email;
	/**电话号码**/
	private String phone;
	/**地址**/
	private String address;
	/**邮政编码**/
	private String postCode;
	/**是否冻结（1:冻结，0：解冻）**/
	private String freezes;
	/**该用户订单列表**/
	private Set<Order> orderList = new HashSet<Order>();
	
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getIdentify() {
		return identify;
	}

	public void setIdentify(int identify) {
		this.identify = identify;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}
	
	public String getFreezes() {
		return freezes;
	}

	public void setFreezes(String freezes) {
		this.freezes = freezes;
	}

	public Set<Order> getOrderList() {
		return orderList;
	}

	public void setOrderList(Set<Order> orderList) {
		this.orderList = orderList;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", userName=" + userName
				+ ", password=" + password + ", identify=" + identify
				+ ", sex=" + sex + ", realName=" + realName + ", birthday="
				+ birthday + ", email=" + email + ", phone=" + phone
				+ ", address=" + address + ", postCode=" + postCode
				+ ", freezes=" + freezes + "]";
	}

}
