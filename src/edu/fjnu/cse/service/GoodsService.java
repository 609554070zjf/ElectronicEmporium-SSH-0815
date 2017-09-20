/**
 * 
 */
package edu.fjnu.cse.service;

import java.util.List;

import edu.fjnu.cse.domain.Goods;
import edu.fjnu.cse.domain.GoodsQueryHelper;
import edu.fjnu.cse.domain.PageBean;

/**
 * @author Javon
 *
 */
public interface GoodsService {

	String saveGoods(Goods goods);

	PageBean<Goods> loadAllByPage(GoodsQueryHelper helper, PageBean<Goods> page);
	
	public void deleteGoods(String goodsId);
	
	public void updateGoods(Goods goods);
	
	public List<Goods> loadAll();
	
	public Goods getGoodsById(String goodsId);

	byte[] loadPicById(String id);

	void updateGoodsPicName(String picName,String id);

}
