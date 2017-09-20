/**
 * 
 */
package edu.fjnu.cse.domain;

import java.util.List;
import java.util.Map;

/**
 * @author Javon
 *
 * 购物车
 */
public class BuyCar {
	public BuyCar() {
		super();
	}

	/**购物车ID**/
	private int id;
	/**所属用户**/
	private int userId;
	/**所买商品**/
	private String goodsId;
	/**商品名称**/
	private String goodsName;
	/**商品描述**/
	private String goodsDesc;
	/**商品数量**/
	private int goodsCnt;
	/**购物车小计**/
	private double money;
	/**购买时的商品单价**/
	private double goodsPrice;
	
	private Order order;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}

	public int getGoodsCnt() {
		return goodsCnt;
	}

	public void setGoodsCnt(int goodsCnt) {
		this.goodsCnt = goodsCnt;
	}

	public double getMoney() {
		return money;
	}

	public void setMoney(double money) {
		this.money = money;
	}
	
	public double getGoodsPrice() {
		return goodsPrice;
	}

	public void setGoodsPrice(double goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	
	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	
	public String getGoodsDesc() {
		return goodsDesc;
	}

	public void setGoodsDesc(String goodsDesc) {
		this.goodsDesc = goodsDesc;
	}
	
	public Order getOrder() {
		return order;
	}

	public void setOrder(Order order) {
		this.order = order;
	}

	@Override
	public String toString() {
		return "BuyCar [id=" + id + ", userId=" + userId + ", goodsId="
				+ goodsId + ", goodsName=" + goodsName + ", goodsCnt="
				+ goodsCnt + ", money=" + money + ", goodsPrice=" + goodsPrice
				+ "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((goodsId == null) ? 0 : goodsId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BuyCar other = (BuyCar) obj;
		if (goodsId == null) {
			if (other.goodsId != null)
				return false;
		} else if (!goodsId.equals(other.goodsId))
			return false;
		return true;
	}

	
}
