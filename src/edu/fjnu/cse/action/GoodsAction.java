/**
 * 
 */
package edu.fjnu.cse.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import edu.fjnu.cse.domain.BuyCar;
import edu.fjnu.cse.domain.Goods;
import edu.fjnu.cse.domain.GoodsQueryHelper;
import edu.fjnu.cse.domain.GoodsType;
import edu.fjnu.cse.domain.PageBean;
import edu.fjnu.cse.domain.User;
import edu.fjnu.cse.service.GoodsService;
import edu.fjnu.cse.service.GoodsTypeService;
import edu.fjnu.cse.service.UserService;

/**
 * @author Javon
 * 
 */
public class GoodsAction extends ActionSupport implements
		ModelDriven<Goods>,SessionAware {
	
	private Goods goods = new Goods();
	private GoodsQueryHelper helper = new GoodsQueryHelper();
	private GoodsService goodsService;
	private GoodsTypeService goodsTypeService;
	private UserService userService;
	private String goodsId;
	private String parentId;
	private String subId;
	private String parentTypeName;
	private String subTypeName;
	private List<Goods> goodsList;
	private PageBean<Goods> pb = new PageBean<Goods>();
	private int pageCode = 1;
	private Map<String, Object> session = null;
	
	private int goodsCnt;
	private int userId;
	
	private File goodsPic;
	private String goodsPicFileName;
	private String goodsPicContentType;

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public GoodsService getGoodsService() {
		return goodsService;
	}

	public void setGoodsService(GoodsService goodsService) {
		this.goodsService = goodsService;
	}

	public List<Goods> getGoodsList() {
		return goodsList;
	}

	public void setGoodsList(List<Goods> goodsList) {
		this.goodsList = goodsList;
	}

	public PageBean<Goods> getPb() {
		return pb;
	}

	public void setPb(PageBean<Goods> pb) {
		this.pb = pb;
	}

	public GoodsQueryHelper getHelper() {
		return helper;
	}

	public void setHelper(GoodsQueryHelper helper) {
		this.helper = helper;
	}

	public int getPageCode() {
		return pageCode;
	}

	public void setPageCode(int pageCode) {
		this.pageCode = pageCode;
	}

	@Override
	public Goods getModel() {
		return goods;
	}
	
	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getSubId() {
		return subId;
	}

	public void setSubId(String subId) {
		this.subId = subId;
	}

	public File getGoodsPic() {
		return goodsPic;
	}

	public void setGoodsPic(File goodsPic) {
		this.goodsPic = goodsPic;
	}

	public String getGoodsPicFileName() {
		return goodsPicFileName;
	}

	public void setGoodsPicFileName(String goodsPicFileName) {
		this.goodsPicFileName = goodsPicFileName;
	}

	public String getGoodsPicContentType() {
		return goodsPicContentType;
	}

	public void setGoodsPicContentType(String goodsPicContentType) {
		this.goodsPicContentType = goodsPicContentType;
	}
	
	public GoodsTypeService getGoodsTypeService() {
		return goodsTypeService;
	}

	public void setGoodsTypeService(GoodsTypeService goodsTypeService) {
		this.goodsTypeService = goodsTypeService;
	}
	
	public String getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(String goodsId) {
		this.goodsId = goodsId;
	}
	
	public String getParentTypeName() {
		return parentTypeName;
	}

	public void setParentTypeName(String parentTypeName) {
		this.parentTypeName = parentTypeName;
	}

	public String getSubTypeName() {
		return subTypeName;
	}

	public void setSubTypeName(String subTypeName) {
		this.subTypeName = subTypeName;
	}

	public int getGoodsCnt() {
		return goodsCnt;
	}

	public void setGoodsCnt(int goodsCnt) {
		this.goodsCnt = goodsCnt;
	}
	
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	/**
	 * 跳转到商品添加页面
	 * @return
	 * @throws Exception
	 */
	public String toAdd() throws Exception{
		return "add_page";
	}
	
	/**
	 * 添加商品
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception{
		String picName = "null.jpg";
		if(goodsPic == null){
			String rootPath = ServletActionContext.getRequest().getRealPath("/images/null.jpg");
			goodsPic = new File(rootPath);
		}
		//从File中获得照片二进制数据
		else{
			picName = String.valueOf(System.currentTimeMillis()+".jpg");
		}
		FileInputStream fis = new FileInputStream(goodsPic);
		FileOutputStream fos = new FileOutputStream(new File(ServletActionContext.getRequest().getRealPath("/images/")+picName));
		byte[] picData = new byte[fis.available()];
		fis.read(picData);
		fos.write(picData);
		fis.close();
		fos.close();
		
		goods.setPic(picData);
		goods.setGoodsPicName(picName);
		
		System.out.println(goods);
		GoodsType subType = goodsTypeService.getGoodsTypeById(subId);
		GoodsType parentType = subType.getParent();
		goods.setSubType(subType);
		goods.setParentType(parentType);
		String pKey = goodsService.saveGoods(goods);
		System.out.println(pKey);
		goodsService.updateGoodsPicName(pKey+".jpg",pKey);
		reFileName(new File(ServletActionContext.getRequest().getRealPath("/images/")+picName), ServletActionContext.getRequest().getRealPath("/images/")+pKey+".jpg");
		return "loadAll";
	}
	
	/**
	 * 去修改页面
	 * @return
	 * @throws Exception
	 */
	public String toUpdate() throws Exception{
		goods = goodsService.getGoodsById(goods.getId());
		GoodsType parentType =  goods.getParentType();
		GoodsType subType = goods.getSubType();
		parentId = parentType.getId();
		subId = subType.getId();
		parentTypeName = parentType.getGoodsTypeName();
		subTypeName = subType.getGoodsTypeName();
		return "update_page";
	}
	
	/**
	 * 修改商品信息
	 * @return
	 * @throws Exception
	 */
	public String update() throws Exception{
		if(goodsPic == null){
			System.out.println(goods.getId());
			goods.setPic(goodsService.loadPicById(goods.getId()));
		}
		else{
			//从File中获得照片二进制数据
			new File(ServletActionContext.getRequest().getRealPath("/images/")+goods.getId()+".jpg").delete();
			FileInputStream fis = new FileInputStream(goodsPic);
			FileOutputStream fos = new FileOutputStream(new File(ServletActionContext.getRequest().getRealPath("/images/")+goods.getId()+".jpg"));
			byte[] picData = new byte[fis.available()];
			fis.read(picData);
			fos.write(picData);
			fis.close();
			fos.close();
			goods.setPic(picData);
		}
		
		GoodsType subType = goodsTypeService.getGoodsTypeById(subId);
		GoodsType parentType = subType.getParent();
		goods.setSubType(subType);
		goods.setParentType(parentType);
		goodsService.updateGoods(goods);
		return "loadAll";
	}
	
	/**
	 * 删除商品信息
	 * @return
	 * @throws Exception
	 */
	public String delete() throws Exception{
		goodsService.deleteGoods(goods.getId());
		return "loadAll";
	}
	
	/**
	 * 后台-查询商品列表
	 * @return
	 * @throws Exception
	 */
	public String loadAll() throws Exception{
		System.out.println(helper);
		pb.setPageSize(5);
		pb = goodsService.loadAllByPage(helper,pb);
		return "load_page";
	}
	
	/**
	 * 前台显示所有商品
	 * @return
	 * @throws Exception
	 */
	public String loadAllFront() throws Exception{
//		addBuyCar();
		System.out.println(helper);
//		pb.setPageSize(5);
		pb = goodsService.loadAllByPage(helper,pb);
		return "load_page_front";
	}
	
	/**
	 * 根据商品ID查询图片
	 * @return
	 * @throws Exception
	 */
	public String loadPicById() throws Exception{
		byte[] picData = goodsService.loadPicById(goods.getId());
		
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("image/jpeg");//browser = client agent
		response.getOutputStream().write(picData);
		response.getOutputStream().flush();
        response.getOutputStream().close();
		return null;
	}
	
	/**
	 * 去前台商品详情页
	 * @return
	 * @throws Exception
	 */
	public String infoGoodsFront() throws Exception{
		goods = goodsService.getGoodsById(goods.getId());
		return "info_page_front";
	}
	
	/**
	 * 商品页-添加商品到购物车
	 * @return
	 * @throws Exception
	 */
	public String addInBuyCarToLoadAll() throws Exception{
		addBuyCar();
		return "loadAllFront";
		
	}
	
	/**
	 * 商品页-从购物车移除商品
	 * @return
	 * @throws Exception
	 */
	public String removeFromBuyCarToLoadAll() throws Exception{
		removeBuyCar();
		return "loadAllFront";
	}
	
	/**
	 * 购物车管理页-添加商品至购物车
	 * @return
	 * @throws Exception
	 */
	public String addInBuyCarToMgr() throws Exception{
		addBuyCar();
		return "buyCarMgr";
		
	}
	
	/**
	 * 购物车管理页-从购物车移除商品
	 * @return
	 * @throws Exception
	 */
	public String removeFromBuyCarToMgr() throws Exception{
		removeBuyCar();
		return "buyCarMgr";
	}
	
	/**
	 * 去购物车管理页
	 * @return
	 * @throws Exception
	 */
	public String buyCarMgr() throws Exception{
		return "buycar_mgr";
	}
	
	/**
	 * 清空购物车
	 * @return
	 * @throws Exception
	 */
	public String clearBuyCar() throws Exception{
		session.remove("buycar");
		return "buyCarMgr";
	}
	
	
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	
	/**
	 * 下订单-去订单结算页
	 * @return
	 * @throws Exception
	 */
	public String toOrder() throws Exception{
		
		return "order_page";
	}
	
	/**
	 * 添加购物车-逻辑业务函数
	 */
	public void addBuyCar(){
		if(goodsId != null){
			goods = goodsService.getGoodsById(goodsId);
			
			BuyCar buyCar = new BuyCar();
			buyCar.setGoodsCnt(goodsCnt);
			buyCar.setGoodsId(goods.getId());
			buyCar.setUserId(userId);
			buyCar.setGoodsName(goods.getGoodsName());
			buyCar.setGoodsPrice(goods.getGoodsPrice());
			buyCar.setGoodsDesc(goods.getDesc());
			buyCar.setMoney(goodsCnt*buyCar.getGoodsPrice());
			
			if(session.get("buycar") == null){
				session.put("buycar", new HashSet<BuyCar>());
				HashSet<BuyCar> buyCarSet = (HashSet<BuyCar>) session.get("buycar");
				buyCarSet.add(buyCar);
			}
			else{
				HashSet<BuyCar> buyCarSet = (HashSet<BuyCar>) session.get("buycar");
				if(buyCarSet.contains(buyCar)){
					for(BuyCar buycar1 : buyCarSet){
						if(buycar1.equals(buyCar)){
							buyCar.setGoodsCnt(goodsCnt+buycar1.getGoodsCnt());
							buyCar.setMoney(buyCar.getGoodsCnt()*buycar1.getGoodsPrice());
//							((HashSet<BuyCar>)session.get("buycar")).remove(buycar1);
//							((HashSet<BuyCar>)session.get("buycar")).add(buycar1);
							buyCarSet.remove(buycar1);
							buyCarSet.add(buyCar);
							session.remove("buycar");
							session.put("buycar", buyCarSet);
							break;
						}
						
					}
				}
				else{
					buyCarSet.add(buyCar);
				}
			}
			
//			if(userId != 0){
//				User user = userService.getUserById(userId);
////				session.remove("user");
//				if(session.get("user") == null){
//					session.put("user", user);
//				}
//			}
		}
	}
	
	/**
	 * 从购物车中移除商品-逻辑业务函数
	 */
	public void removeBuyCar(){
		HashSet<BuyCar> buyCarSet = (HashSet<BuyCar>) session.get("buycar");
		BuyCar buyCar = new BuyCar();
		buyCar.setGoodsId(goodsId);
		buyCarSet.remove(buyCar);
		session.remove("buycar");
		session.put("buycar", buyCarSet);
	}
	
	/**
	 * 重命名图片名称-逻辑业务函数
	 * @param file
	 * @param newName
	 */
	public void reFileName(File file,String newName){
		file.renameTo(new File(newName));
	}
}
