/**
 * 
 */
package edu.fjnu.cse.dao;

import java.util.List;
import java.util.Set;

import edu.fjnu.cse.domain.GoodsType;


/**
 * @author Javon
 *
 */
public interface GoodsTypeDao {
	/**
	 * 保存商品类别
	 * @param goodsType
	 */
	public void save(GoodsType goodsType);
	
	/**
	 * 修改商品类别
	 * @param goodsType
	 */
	public void update(GoodsType goodsType);
	
	/**
	 * 删除商品类别
	 * @param goodsTypeId
	 */
	public void delete(String goodsTypeId);
	
	/**
	 * 查询所有商品类别
	 * @return
	 */
	public List<GoodsType> loadAll();
	
	/**
	 * 查询商品类别列表（分页+组合查询）（未实现）
	 * @param goodsType
	 * @param start
	 * @param size
	 * @return
	 */
	public Set<GoodsType> loaAllByPage(GoodsType goodsType,int start,int size);
	
	/**
	 * 通过Id获取商品类别
	 * @param goodsTypeId
	 * @return
	 */
	public GoodsType getGoodsTypeById(String goodsTypeId);
	
	/**
	 * 查询商品类别记录数（未实现）
	 * @param goodsType
	 * @return
	 */
	public int count(GoodsType goodsType);

	/**
	 * 查询所有的一级类别
	 * @return
	 */
	public List<GoodsType> loadAllParent();
	
	/**
	 * 根据父类别查询子类别
	 * @param parentId
	 * @return
	 */
	public List<GoodsType> loadSubTypeByParentId(String parentId);
}
