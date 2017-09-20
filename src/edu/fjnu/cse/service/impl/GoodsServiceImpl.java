/**
 * 
 */
package edu.fjnu.cse.service.impl;

import java.util.List;

import edu.fjnu.cse.dao.GoodsDao;
import edu.fjnu.cse.domain.Goods;
import edu.fjnu.cse.domain.GoodsQueryHelper;
import edu.fjnu.cse.domain.GoodsType;
import edu.fjnu.cse.domain.PageBean;
import edu.fjnu.cse.service.GoodsService;

/**
 * @author Javon
 *
 */
public class GoodsServiceImpl implements GoodsService{
	
	private GoodsDao goodsDao;

	public GoodsDao getGoodsDao() {
		return goodsDao;
	}

	public void setGoodsDao(GoodsDao goodsDao) {
		this.goodsDao = goodsDao;
	}

	@Override
	public String saveGoods(Goods goods) {
		return goodsDao.save(goods);
	}

	@Override
	public void deleteGoods(String goodsId) {
		goodsDao.delete(goodsId);
	}

	@Override
	public void updateGoods(Goods goods) {
		goodsDao.update(goods);
	}

	@Override
	public List<Goods> loadAll() {
		return null;
	}

	@Override
	public Goods getGoodsById(String goodsId) {
		return goodsDao.getGoodsById(goodsId);
	}

	@Override
	public byte[] loadPicById(String id) {
		return goodsDao.loadPicById(id);
	}

	@Override
	public PageBean<Goods> loadAllByPage(GoodsQueryHelper helper,
			PageBean<Goods> page) {
		page.setTotalRecord(goodsDao.cntGoodsByHelper(helper));
		page.setDatas(goodsDao.loadScopedGoodssByHelper(helper, page.getStartIndex(), page.getEndIndex()-page.getStartIndex()));
		return page;
	}

	@Override
	public void updateGoodsPicName(String picName,String id) {
		goodsDao.updateGoodsPicName(picName,id);
	}

	
}
