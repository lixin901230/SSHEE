package com.zl.frame.core.util;

import java.util.ArrayList;
import java.util.List;

/**
 * @desc：使用easyui的datagrid展示数据列表时封装的数据model，
 * @author lixin
 * @date: 2013-11-27上午10:19:29
 */
@SuppressWarnings("rawtypes")
public class DataGrid {

	private Long total = 0L;
	private List rows = new ArrayList();
	
	public DataGrid() {}

	public DataGrid(Long total, List rows) {
		this.total = total;
		this.rows = rows;
	}

	public Long getTotal() {
		return total;
	}

	public void setTotal(Long total) {
		this.total = total;
	}

	public List getRows() {
		return rows;
	}

	public void setRows(List rows) {
		this.rows = rows;
	}

}
