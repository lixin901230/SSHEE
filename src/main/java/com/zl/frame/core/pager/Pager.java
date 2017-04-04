package com.zl.frame.core.pager;

/**
 * 用于分页的bean
 */
import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;

public class Pager<T> implements Serializable{

	private static final long serialVersionUID = -8499693921276098886L;

	public final static Integer PAGESIZE = 10;
	
	private Integer curPage = 1;			//当前页
	private Integer pageSize = PAGESIZE;	//每页显示条数
	private Integer totalRow = 0;			//总记录数
	private Integer totalPage = 0;			//总页数
	private List<T> data;					//分页数据集合

	private Integer[] indexes = new Integer[0];
	private Integer startIndex = 0;
	private Integer previousPage = 0;
	private Integer nextPage = 0;
	private Integer pagesizenum[] = {10,15,20,25,30,35,40,45,50,100,200,300,500}; 
	
	
	// 排序方式
	public enum OrderType{
		asc, desc
	}
	private String property;// 查找属性名称
	private String keyword;// 查找关键字
	private Map<String,Object> searchItem;
	private String orderBy = "createDate";// 排序字段
	private OrderType orderType = OrderType.desc;// 排序方式
	
	public Pager(){
		
	}
	
	public Pager(Integer curPage, Integer pageSize, Integer totalPage, Integer totalRow, List<T> data) {

		setPageSize(pageSize);
		setTotalRow(totalRow);
		setData(data);
		setCurPage(curPage);
	}

	public List<T> getData() {
		return data;
	}

	public void setData(List<T> data) {
		this.data = data;
	}

	public Integer getPageSize() {
//		Integer sessionPageSize = getSessionPageSize();
//		if(sessionPageSize!=null){
//			return sessionPageSize.intValue();
//		}else{
//			return pageSize;
//		}
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getTotalRow() {
		return totalRow;
	}

	public Integer[] getPagesizenum() {
		return pagesizenum;
	}

	public void setPagesizenum(Integer[] pagesizenum) {
		this.pagesizenum = pagesizenum;
	}
	
	@SuppressWarnings("unused")
	private Integer getSessionPageSize(){
		try {
			Map<String, Object> session = ActionContext.getContext().getSession();
			return Integer.parseInt((String)session.get("pagesize"));
		} catch (Exception e) {
			return null;
		}
	}
	
	public void setTotalRow(Integer totalRow) {
		if (totalRow > 0) {
			this.totalRow = totalRow;
			Integer count = totalRow / getPageSize();
			if (totalRow % getPageSize() > 0)
				count++;
			indexes = new Integer[count];
			for (Integer i = 0; i < count; i++) {
				indexes[i] = getPageSize() * i;
			}
			this.totalPage = count;
		} else {
			this.totalRow = 0;
			this.totalPage = 0;
		}
	}

	public Integer[] getIndexes() {
		return indexes;
	}

	public void setIndexes(Integer[] indexes) {
		this.indexes = indexes;
	}

	public Integer getStartIndex() {
		startIndex =pageSize * (curPage-1);
		return startIndex;
	}

	public void setStartIndex(Integer startIndex) {
		if(startIndex<0){
			startIndex = 0;
		}
		this.startIndex = startIndex;
	}

	public Integer getNextIndex() {
		Integer nextIndex = getStartIndex() + pageSize;
		if (nextIndex >= totalRow)
			return getStartIndex();
		else
			return nextIndex;
	}

	public Integer getPreviousIndex() {
		Integer previousIndex = getStartIndex() - pageSize;
		if (previousIndex < 0)
			return 0;
		else
			return previousIndex;
	}

	public Integer getTotalPage() {
		return totalPage;
	}

	public void setCurPage(Integer curPage) {
		this.curPage = curPage;
		this.previousPage = curPage - 1 <= 0 ? curPage:curPage-1;
		this.nextPage = curPage+1 > totalPage ? curPage:curPage+1;
	}

	public Integer getCurPage() {
		return curPage;
	}

	public Integer getPreviousPage() {
		return previousPage;
	}

	public Integer getNextPage() {
		return nextPage;
	}

	public String getProperty() {
		return property;
	}

	public void setProperty(String property) {
		this.property = property;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}

	public OrderType getOrderType() {
		return orderType;
	}

	public void setOrderType(OrderType orderType) {
		this.orderType = orderType;
	}

	public static Integer getPAGESIZE() {
		return PAGESIZE;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}

	public void setPreviousPage(Integer previousPage) {
		this.previousPage = previousPage;
	}

	public void setNextPage(Integer nextPage) {
		this.nextPage = nextPage;
	}

	public Map<String, Object> getSearchItem() {
		return searchItem;
	}

	public void setSearchItem(Map<String, Object> searchItem) {
		this.searchItem = searchItem;
	}

}
