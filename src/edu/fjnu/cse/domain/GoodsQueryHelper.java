/**
 * 
 */
package edu.fjnu.cse.domain;

/**
 * @author Javon
 * 
 */
public class GoodsQueryHelper {
	private String qryParentId;
	private String qrySubId;
	private String qryGoodsName;
	private double minPrice;
	private double maxPrice;
	private String orderField;

	public String getQryParentId() {
		return qryParentId;
	}

	public void setQryParentId(String qryParentId) {
		this.qryParentId = qryParentId;
	}

	public String getQrySubId() {
		return qrySubId;
	}

	public void setQrySubId(String qrySubId) {
		this.qrySubId = qrySubId;
	}

	public String getQryGoodsName() {
		return qryGoodsName;
	}

	public void setQryGoodsName(String qryGoodsName) {
		this.qryGoodsName = qryGoodsName;
	}

	public double getMinPrice() {
		return minPrice;
	}

	public void setMinPrice(double minPrice) {
		this.minPrice = minPrice;
	}

	public double getMaxPrice() {
		return maxPrice;
	}

	public void setMaxPrice(double maxPrice) {
		this.maxPrice = maxPrice;
	}

	public String getOrderField() {
		return orderField;
	}

	public void setOrderField(String orderField) {
		this.orderField = orderField;
	}

	@Override
	public String toString() {
		return "GoodsQueryHelper [qryParentId=" + qryParentId + ", qrySubId="
				+ qrySubId + ", qryGoodsName=" + qryGoodsName + ", minPrice="
				+ minPrice + ", maxPrice=" + maxPrice + "]";
	}
	
	
	
}
