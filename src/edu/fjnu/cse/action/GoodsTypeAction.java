/**
 * 
 */
package edu.fjnu.cse.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import net.sf.json.util.PropertyFilter;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import edu.fjnu.cse.domain.GoodsType;
import edu.fjnu.cse.domain.PageBean;
import edu.fjnu.cse.service.GoodsTypeService;
import edu.fjnu.cse.utils.StringUtil;

/**
 * @author Javon
 *
 */
public class GoodsTypeAction extends ActionSupport implements ModelDriven<GoodsType>{
	
	private GoodsType goodsType = new GoodsType();
	private GoodsTypeService goodsTypeService;
	private String parentId;
	private List<GoodsType> goodsTypeList;
	private PageBean<GoodsType> pb;
	private String pageUrl;
	private int pageCode = 1;
	private Map<String, Object> session = null;
	private JSONArray parentJson;
	
	@Override
	public GoodsType getModel() {
		return goodsType;
	}

	public GoodsType getGoodsType() {
		return goodsType;
	}

	public void setGoodsType(GoodsType goodsType) {
		this.goodsType = goodsType;
	}

	public GoodsTypeService getGoodsTypeService() {
		return goodsTypeService;
	}

	public void setGoodsTypeService(GoodsTypeService goodsTypeService) {
		this.goodsTypeService = goodsTypeService;
	}

	public String getParentId() {
		return parentId;
	}
	
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public List<GoodsType> getGoodsTypeList() {
		return goodsTypeList;
	}

	public void setGoodsTypeList(List<GoodsType> goodsTypeList) {
		this.goodsTypeList = goodsTypeList;
	}

	public PageBean<GoodsType> getPb() {
		return pb;
	}

	public void setPb(PageBean<GoodsType> pb) {
		this.pb = pb;
	}

	public String getPageUrl() {
		return pageUrl;
	}

	public void setPageUrl(String pageUrl) {
		this.pageUrl = pageUrl;
	}

	public int getPageCode() {
		return pageCode;
	}

	public void setPageCode(int pageCode) {
		this.pageCode = pageCode;
	}
	
	public JSONArray getParentJson() {
		return parentJson;
	}

	public void setParentJson(JSONArray parentJson) {
		this.parentJson = parentJson;
	}
	

	/**
	 * 跳转到商品类别添加页面
	 * @return
	 * @throws Exception
	 */
	public String toAdd() throws Exception{
		return "add_page";
	}
	
	/**
	 * 商品类别添加
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception{
		if(StringUtil.isEmpty(parentId)){
			goodsType.setParent(null);
		}
		else{
			GoodsType parent = new GoodsType();
			parent.setId(parentId);
			goodsType.setParent(parent);
		}
		System.out.println(goodsType);
		goodsTypeService.saveGoodsType(goodsType);
		return "add_page";
	}
	
	/**
	 * 获取父级类别json
	 * @return
	 * @throws Exception
	 */
	public String loadParentJson() throws Exception{
		JsonConfig cfg = new JsonConfig();
		cfg.setJsonPropertyFilter(new PropertyFilter()
		{
		         public boolean apply(Object source, String name, Object value) {
		           if(name.equals("active")||name.equals("subGoodsType") || name.equals("goodsList")) {
		             return true;
		           } else {
		             return false;
		          }
		}
		});
		
		List<GoodsType> list = goodsTypeService.loadAllParent();
		parentJson = JSONArray.fromObject(list,cfg);
//		System.out.println(parentJson.toString());
		return "parent_json";
	}
	
	/**
	 * 根据父类别id获取子类别json
	 * @return
	 * @throws Exception
	 */
	public String loadSubJson() throws Exception{
		JsonConfig cfg = new JsonConfig();
		cfg.setJsonPropertyFilter(new PropertyFilter()
		{
		         public boolean apply(Object source, String name, Object value) {
		           if(name.equals("active")||name.equals("subGoodsType") || name.equals("goodsList")) {
		             return true;
		           } else {
		             return false;
		          }
		}
		});
		Set<GoodsType> list = goodsTypeService.getGoodsTypeById(parentId).getSubGoodsType();
		parentJson = JSONArray.fromObject(list,cfg);
		return "parent_json";
	}
	
	/**
	 * 加载所有商品类别
	 * @return
	 * @throws Exception
	 */
	public String loadAll() throws Exception{
		goodsTypeList = goodsTypeService.loadAllParent();
		return "load_page";
	}
	
	/**
	 * 商品类别修改
	 * @return
	 * @throws Exception
	 */
	public String update() throws Exception{
		if(StringUtil.isEmpty(parentId)){
			goodsType.setParent(null);
		}
		else{
			GoodsType parent = new GoodsType();
			parent.setId(parentId);
			goodsType.setParent(parent);
		}
		goodsType.setActive("1");
		goodsTypeService.updateGoodsType(goodsType);
		return "loadAll";
	}
	
	/**
	 * 商品类别删除
	 * @return
	 * @throws Exception
	 */
	public String delete() throws Exception{
		goodsTypeService.deleteGoodsType(parentId);
		return "loadAll";
	}

}
