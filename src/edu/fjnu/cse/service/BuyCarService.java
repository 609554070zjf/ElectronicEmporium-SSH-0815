/**
 * 
 */
package edu.fjnu.cse.service;

import edu.fjnu.cse.domain.BuyCar;
import edu.fjnu.cse.domain.Goods;

/**
 * @author Javon
 *
 */
public interface BuyCarService {
	BuyCar addGoods(BuyCar buycar,Goods goods);
}
