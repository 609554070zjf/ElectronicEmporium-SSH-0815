/**
 * 
 */
package edu.fjnu.cse.domain;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * @author Javon
 * 
 *         商品类别
 */
public class GoodsType {

	/**
	 * 
	 */
	public GoodsType() {
	}
	
	
	public GoodsType(String id, String goodsTypeName,
			String active) {
		super();
		this.id = id;
		this.goodsTypeName = goodsTypeName;
		this.active = active;
	}

	/** 商品类别id **/
	private String id;
	/** 商品类别名称 **/
	private String goodsTypeName;
	/** 父类别 **/
	private GoodsType parent;
	/** 子类别列表 **/
	private Set<GoodsType> subGoodsType;
	/** 是否有效 **/
	private String active;
	/**子类别商品列表**/
	private Set<Goods> goodsList = new HashSet<Goods>();
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getGoodsTypeName() {
		return goodsTypeName;
	}

	public void setGoodsTypeName(String goodsTypeName) {
		this.goodsTypeName = goodsTypeName;
	}

	public GoodsType getParent() {
		return parent;
	}

	public void setParent(GoodsType parent) {
		this.parent = parent;
	}


	public Set<GoodsType> getSubGoodsType() {
		return subGoodsType;
	}

	public void setSubGoodsType(Set<GoodsType> subGoodsType) {
		this.subGoodsType = subGoodsType;
	}

	public String getActive() {
		return active;
	}

	public void setActive(String active) {
		this.active = active;
	}

	public Set<Goods> getGoodsList() {
		return goodsList;
	}

	public void setGoodsList(Set<Goods> goodsList) {
		this.goodsList = goodsList;
	}

	@Override
	public String toString() {
		return "GoodsType [id=" + id + ", goodsTypeName=" + goodsTypeName
				+ ", active=" + active +"]";
	}
	
}
