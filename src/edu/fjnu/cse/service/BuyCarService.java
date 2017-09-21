/**
 * 
 */
package edu.fjnu.cse.service;

import edu.fjnu.cse.domain.BuyCar;
import edu.fjnu.cse.domain.Goods;

/**
 * @author Javon
 * 
 * 购物车Service
 */
public interface BuyCarService {
	/**
	 * 添加购物车（未实现）
	 * @param buycar
	 * @param goods
	 * @return
	 */
	BuyCar addGoods(BuyCar buycar,Goods goods);
}
