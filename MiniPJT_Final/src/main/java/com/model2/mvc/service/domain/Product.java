package com.model2.mvc.service.domain;

import java.sql.Date;


public class Product {
	
	private String fileName;
	private String manuDate;
	private int price;
	private String prodDetail;
	private String prodName;
	private int prodNo;
	private String[] prodNoList;
	private Date regDate;
	private String proTranCode;
	private int prodTotal;
	private String[] prodTotalList;
	private int tranNo;
	
	public Product(){
	}
	
	public String[] getProdTotalList() {
		return prodTotalList;
	}

	public void setProdTotalList(String[] prodTotalList) {
		this.prodTotalList = prodTotalList;
	}

	public int getTranNo() {
		return tranNo;
	}

	public void setTranNo(int tranNo) {
		this.tranNo = tranNo;
	}

	public String[] getProdNoList() {
		return prodNoList;
	}

	public void setProdNoList(String[] prodNoList) {
		this.prodNoList = prodNoList;
	}

	public int getProdTotal() {
		return prodTotal;
	}

	public void setProdTotal(int prodTotal) {
		this.prodTotal = prodTotal;
	}

	public String getProTranCode() {
		return proTranCode;
	}
	public void setProTranCode(String proTranCode) {
		this.proTranCode = proTranCode;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getManuDate() {
		return manuDate;
	}
	public void setManuDate(String manuDate) {
		this.manuDate = manuDate;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getProdDetail() {
		return prodDetail;
	}
	public void setProdDetail(String prodDetail) {
		this.prodDetail = prodDetail;
	}
	public String getProdName() {
		return prodName;
	}
	public void setProdName(String prodName) {
		this.prodName = prodName;
	}
	public int getProdNo() {
		return prodNo;
	}
	public void setProdNo(int prodNo) {
		this.prodNo = prodNo;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	// Override
	public String toString() {
		return "Product :  [tranNo]" + tranNo + "[fileName]" + fileName + "[prodTotal]" + prodTotal
				+ "[manuDate]" + manuDate+ "[price]" + price + "[prodDetail]" + prodDetail
				+ "[prodName]" + prodName + "[prodNo]" + prodNo + "[prodNoList]" + prodNoList
				+ "[proTranCode]" + proTranCode ;
	}	
}