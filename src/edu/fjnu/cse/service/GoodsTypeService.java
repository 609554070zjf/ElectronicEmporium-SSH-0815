/**
 * 
 */
package edu.fjnu.cse.service;

import java.util.List;
import java.util.Set;

import edu.fjnu.cse.domain.GoodsType;
import edu.fjnu.cse.domain.PageBean;

/**
 * @author Javon
 *
 */
public interface GoodsTypeService {
	
	public void saveGoodsType(GoodsType goodsType); 
	
	public void deleteGoodsType(String goodsTypeId);
	
	public void updateGoodsType(GoodsType goodsType);
	
	public List<GoodsType> loadAll();
	
	public PageBean<GoodsType> loadAllByPage(GoodsType goodsType,int pageCode);
	
	public GoodsType getGoodsTypeById(String goodsTypeId);
	
	public List<GoodsType> loadAllParent();
	
	public List<GoodsType> loadSubTypeByParentId(String parentId);

	
}
