/**
 * 
 */
package edu.fjnu.cse.domain;

import java.util.Collection;
import java.util.List;

/**
 * @author Javon
 * 
 */
public class PageBean<T> {
	/** 当前页码 **/
	private int pageCode;
	/** 总页数 **/
	private int totalPage;
	/** 当前页记录 **/
	private Collection<T> datas;
	/** 总记录数 **/
	private int totalRecord;
	/** 记录开始位置 **/
	private Integer startIndex;
	/** 记录结束位置 **/
	private Integer endIndex;
	/** 每页显示的记录数 **/
	private int pageSize;
	/** 是否有下一页 **/
	private Boolean nextPage;
	/** 是否有上一页 **/
	private Boolean prePage;

	public PageBean() {
		super();
		pageCode = 1;
		pageSize = 10;
	}

	public int getStartIndex()
	{
		return pageSize*(pageCode-1);  // size:10 pageno:3   21
	}
	
	public int getEndIndex()
	{
		return (pageSize*pageCode>this.totalRecord)? this.totalRecord:(pageSize*pageCode);
	}
	
	public void setStartIndex(Integer startIndex) {
		this.startIndex = startIndex;
	}

	public void setEndIndex(Integer endIndex) {
		this.endIndex = endIndex;
	}

	public void setNextPage(Boolean nextPage) {
		this.nextPage = nextPage;
	}

	public void setPrePage(Boolean prePage) {
		this.prePage = prePage;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}

	public PageBean(int pageCode, int totalRecord) {
		this(pageCode, totalRecord, 10);
	}

	public PageBean(int pageCode, int totalRecord, int pageSize) {
		super();
		this.pageCode = pageCode;
		this.totalRecord = totalRecord;
		this.pageSize = pageSize;
	}

	public int getPageCode() {
		return pageCode;
	}

	public void setPageCode(int pageCode) {
		this.pageCode = pageCode;
	}

	public int getTotalPage() {
		// 计算总页数 = 总记录数/当前页数
		totalPage = this.totalRecord / pageSize;
		return totalRecord % pageSize == 0 ? totalPage : totalPage + 1;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public Collection<T> getDatas() {
		return datas;
	}

	public void setDatas(Collection<T> datas) {
		this.datas = datas;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	public Boolean getNextPage() {
		return pageCode<getTotalPage()?true:false;
	}

	public Boolean getPrePage() {
		return pageCode>1?true:false;
	}

}
