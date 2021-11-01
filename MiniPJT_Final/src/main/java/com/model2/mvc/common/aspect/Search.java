package com.model2.mvc.common.aspect;


public class Search {
	
	///Field
	private String curruntPage;
	private String searchCondition;
	private String searchKeyword;
	private int pageSize;
	private String sortCondition;
	private String rowCondition;
	private int endRowNum;
	private int startRowNum;
	///Constructor
	public Search() {
	}
	
	///Method
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int paseSize) {
		this.pageSize = paseSize;
	}
	
	public String getCurrentPage() {
		return curruntPage;
	}
	public void setCurrentPage(String curruntPage) {
		this.curruntPage = curruntPage;
	}

	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	public String getSortCondition() {
		return sortCondition;
	}
	
	public void setSortCondition(String sortCondition) {
		this.sortCondition = sortCondition;
	}
	
	public String getRowCondition() {
		return rowCondition;
	}
	
	public void setRowCondition(String rowCondition) {
		this.rowCondition = rowCondition;
	}
	
	public int getEndRowNum() {
		return Integer.parseInt(getCurrentPage())*getPageSize();
	}
	
	public int getStartRowNum() {
		return (Integer.parseInt(getCurrentPage())-1)*getPageSize()+1;
	}
	
	@Override
	public String toString() {
		return "Search [curruntPage=" + curruntPage + ", searchCondition="
				+ searchCondition + ", searchKeyword=" + searchKeyword +", endRowNum=" + endRowNum
				+ ", startRowNum=" + startRowNum+ ", pageSize=" + pageSize + ", sortCondition=" + sortCondition +", rowCondition=" +rowCondition+"]";
	}
}