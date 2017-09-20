/**
 * 
 */
package edu.fjnu.cse.domain;

import java.io.Serializable;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

/**
 * @author Javon
 * 
 *         商品类
 */
public class Goods implements Serializable{
	public Goods() {
		super();
	}
	
	public Goods(String id, String goodsName, double goodsPrice, String enough,
			int leftCnt, GoodsType parentType, GoodsType subType) {
		super();
		this.id = id;
		this.goodsName = goodsName;
		this.goodsPrice = goodsPrice;
		this.enough = enough;
		this.leftCnt = leftCnt;
		this.parentType = parentType;
		this.subType = subType;
	}



	/** 商品id **/
	private String id;
	/** 商品名称 **/
	private String goodsName;
	/** 商品单价 **/
	private double goodsPrice;
	/** 是否有货（1：有货，2：无货) **/
	private String enough;
	/**存货数量**/
	private int leftCnt;
	/** 商品描述 **/
	private String desc;
	/** 商品图片 **/
	private byte[] pic;
	/**所属商品大类**/
	private GoodsType parentType;
//	private String parentType;
	/**所属商品小类**/
	private GoodsType subType;
	/**图片名称**/
	private String goodsPicName;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getGoodsName() {
		return goodsName;
	}

	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}

	public double getGoodsPrice() {
		return goodsPrice;
	}

	public void setGoodsPrice(double goodsPrice) {
		this.goodsPrice = goodsPrice;
	}

	public String getEnough() {
		return enough;
	}

	public void setEnough(String enough) {
		this.enough = enough;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public byte[] getPic() {
		return pic;
	}

	public void setPic(byte[] pic) {
		this.pic = pic;
	}

	public int getLeftCnt() {
		return leftCnt;
	}

	public void setLeftCnt(int leftCnt) {
		this.leftCnt = leftCnt;
	}
	
	public GoodsType getParentType() {
		return parentType;
	}

	public void setParentType(GoodsType parentType) {
		this.parentType = parentType;
	}

	
	public GoodsType getSubType() {
		return subType;
	}
	
//	public String getParentType() {
//		return parentType;
//	}
//
//	public void setParentType(String parentType) {
//		this.parentType = parentType;
//	}

	public String getGoodsPicName() {
		return goodsPicName;
	}

	public void setGoodsPicName(String goodsPicName) {
		this.goodsPicName = goodsPicName;
	}

	public void setSubType(GoodsType subType) {
		this.subType = subType;
	}

	@Override
	public String toString() {
		return "Goods [id=" + id + ", goodsName=" + goodsName + ", goodsPrice="
				+ goodsPrice + ", enough=" + enough + ", leftCnt=" + leftCnt
				+ ", desc=" + desc + ",goodsPicName=" + goodsPicName + "]";
	}

}
