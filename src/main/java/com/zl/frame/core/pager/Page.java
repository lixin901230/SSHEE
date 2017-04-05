package com.zl.frame.core.pager;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * @desc：分页实体
 * @param <T> 泛型参数
 * @author lixin
 * @date: 2013-11-6下午11:48:28
 */
public class Page<T> implements Serializable {
	
	private static final long serialVersionUID = 6010974773441586682L;
	
	/** 总记录数 */
	private Integer totalRow;
	/** 当前页码 */
	private Integer curPage = 1;
	/** 每页显示记录条数 */
	private Integer pageSize = 10;
	/** 总页数 */
	private Integer totalPage;
	/** 分页数据集 */
	private List<T> data = new ArrayList<T>();
	
	/** 排序方式 */
	public enum OrderType{
		asc, desc
	}
	private OrderType orderType = OrderType.desc;// 排序方式
	
	public Page() {}
	
	public Page(Integer curPage, Integer pageSize) {
		this.curPage = curPage;
		this.pageSize = pageSize;
	}

	public Page(Integer curPage, Integer pageSize, /*Integer totalPage,*/ Integer totalRow, List<T> data) {
		
		this.curPage = curPage;
		this.pageSize = pageSize;
		//this.totalPage = totalPage;
		this.totalPage = totalRow / pageSize + ((totalRow % pageSize) > 0 ? 1 : 0);
		this.totalRow = totalRow;
		this.data = data;
	}

	/**
	 * @param currentPage 
	 * @param pageSize
	 * @param data
	 */
	public Page(Integer curPage, Integer pageSize, List<T> data) {
		
		this.curPage = curPage;
		this.pageSize = pageSize;
		this.data = data;
	}

	public Integer getTotalRow() {
		return totalRow;
	}
	public void setTotalRow(Integer totalRow) {
		this.totalPage = totalRow / pageSize + ((totalRow % pageSize) > 0 ? 1 : 0);
		this.totalRow = totalRow;
	}
	public Integer getCurPage() {
		return curPage;
	}
	public void setCurPage(Integer curPage) {
		this.curPage = curPage;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public Integer getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}
	public List<T> getData() {
		return data;
	}
	public void setData(List<T> data) {
		this.data = data;
	}
	public OrderType getOrderType() {
		return orderType;
	}
	public void setOrderType(OrderType orderType) {
		this.orderType = orderType;
	}

	@Override
	public String toString() {
		return "Page [totalRow=" + totalRow + ", curPage=" + curPage
				+ ", pageSize=" + pageSize + ", totalPage=" + totalPage
				+ ", data=" + data + "]";
	}
}
