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

	/**
	 * 保存商品
	 * @param goods
	 * @return
	 */
	public String save(Goods goods);
	
	/**
	 * 修改商品
	 * @param goods
	 */
	public void update(Goods goods);
	
	/**
	 * 删除商品
	 * @param goodsId
	 */
	public void delete(String goodsId);
	
	/**
	 * 分页查询商品（未实现）
	 * @param goods
	 * @param start
	 * @param size
	 * @return
	 */
	public List<Goods> loaAllByPage(Goods goods,int start,int size);
	
	/**
	 * 通过Id查询商品
	 * @param goodsId
	 * @return
	 */
	public Goods getGoodsById(String goodsId);
	
	/**
	 * 查询商品记录数
	 * @param goods
	 * @return
	 */
	public int count(Goods goods);
	
	/**
	 * 根据商品id查询商品图片
	 * @param id
	 * @return
	 */
	public byte[] loadPicById(String id);

	/**
	 * 查询商品记录数（带组合查询条件）
	 * @param helper
	 * @return
	 */
	public int cntGoodsByHelper(GoodsQueryHelper helper);

	/**
	 * 查询商品列表（分页+组合查询）
	 * @param helper
	 * @param startIndex
	 * @param fetchSize
	 * @return
	 */
	public List<Goods> loadScopedGoodssByHelper(GoodsQueryHelper helper,
			Integer startIndex, int fetchSize);

	/**
	 * 修改商品图片名称
	 * @param picName
	 * @param id
	 */
	public void updateGoodsPicName(String picName,String id);

}
