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
	public void save(GoodsType goodsType);
	
	public void update(GoodsType goodsType);
	
	public void delete(String goodsTypeId);
	
	public List<GoodsType> loadAll();
	
	public Set<GoodsType> loaAllByPage(GoodsType goodsType,int start,int size);
	
	public GoodsType getGoodsTypeById(String goodsTypeId);
	
	public int count(GoodsType goodsType);

	public List<GoodsType> loadAllParent();

	public List<GoodsType> loadSubTypeByParentId(String parentId);
}
