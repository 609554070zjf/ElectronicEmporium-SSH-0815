/**
 * 
 */
package edu.fjnu.cse.service.impl;

import java.util.List;
import java.util.Set;

import edu.fjnu.cse.dao.GoodsTypeDao;
import edu.fjnu.cse.domain.GoodsType;
import edu.fjnu.cse.domain.PageBean;
import edu.fjnu.cse.service.GoodsTypeService;

/**
 * @author Javon
 *
 */
public class GoodsTypeServiceImpl implements GoodsTypeService{

	private GoodsTypeDao goodsTypeDao;

	public GoodsTypeDao getGoodsTypeDao() {
		return goodsTypeDao;
	}

	public void setGoodsTypeDao(GoodsTypeDao goodsTypeDao) {
		this.goodsTypeDao = goodsTypeDao;
	}

	@Override
	public void saveGoodsType(GoodsType goodsType) {
		goodsTypeDao.save(goodsType);
	}

	@Override
	public void deleteGoodsType(String goodsTypeId) {
		goodsTypeDao.delete(goodsTypeId);
	}

	@Override
	public void updateGoodsType(GoodsType goodsType) {
		goodsTypeDao.update(goodsType);
	}

	@Override
	public List<GoodsType> loadAll() {
		return goodsTypeDao.loadAll();
	}

	@Override
	public PageBean<GoodsType> loadAllByPage(GoodsType goodsType, int pageCode) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public GoodsType getGoodsTypeById(String goodsTypeId) {
		return goodsTypeDao.getGoodsTypeById(goodsTypeId);
	}

	@Override
	public List<GoodsType> loadAllParent() {
		return goodsTypeDao.loadAllParent();
	}

	@Override
	public List<GoodsType> loadSubTypeByParentId(String parentId) {
		return goodsTypeDao.loadSubTypeByParentId(parentId);
	}
	
	
}
