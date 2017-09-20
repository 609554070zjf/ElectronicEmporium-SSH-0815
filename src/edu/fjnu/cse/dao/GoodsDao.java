/**
 * 
 */
package edu.fjnu.cse.dao;

import java.util.List;

import edu.fjnu.cse.domain.Goods;
import edu.fjnu.cse.domain.GoodsQueryHelper;

/**
 * @author Javon
 *
 */
public interface GoodsDao {

	public String save(Goods goods);
	
	public void update(Goods goods);
	
	public void delete(String goodsId);
	
	public List<Goods> loaAllByPage(Goods goods,int start,int size);
	
	public Goods getGoodsById(String goodsId);
	
	public int count(Goods goods);

	public byte[] loadPicById(String id);

	public int cntGoodsByHelper(GoodsQueryHelper helper);

	public List<Goods> loadScopedGoodssByHelper(GoodsQueryHelper helper,
			Integer startIndex, int fetchSize);

	public void updateGoodsPicName(String picName,String id);

}
