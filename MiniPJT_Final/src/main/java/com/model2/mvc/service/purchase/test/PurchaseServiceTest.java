package com.model2.mvc.service.purchase.test;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-common.xml",
									"classpath:config/context-aspect.xml",
									"classpath:config/context-mybatis.xml",
									"classpath:config/context-transaction.xml" })
public class PurchaseServiceTest {
	
	@Autowired
	@Qualifier("purchaseService")
	private PurchaseService purchaseService; 
	
	//@Test
	public void testInsertPurchase() throws Exception{

		User user = new User();
		Product product = new Product();
		Purchase purchase = new Purchase();
		
		user.setUserId("user11");
		product.setProdNo(10003);
	
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		purchase.setPurchaseQuantity(5);
		purchase.setPaymentOption("1");
		purchase.setReceiverName("홍길동");
		purchase.setReceiverPhone("010-1234-5678");
		purchase.setDivyAddr("서울시 비트캠프");
		purchase.setDivyRequest("빠른배송");
		purchase.setTranCode("1");
		purchase.setDivyDate("19990205");
		
		purchaseService.addPurchase(purchase);
	}
	
	//@Test
	public void testFindPurchase() throws Exception{
	
		System.out.println(purchaseService.getPurchase(10001));
		
	}
	
	//@Test
	public void testFindPurchase2() throws Exception{
		List<Purchase> list = purchaseService.getPurchase2(10003);
		
		for(Purchase purchase : list) {
			System.out.println(purchase);
		}
		
	}
	
	//@Test
	public void testGetPurchaseList() throws Exception{
		
		Search search = new Search();
		search.setCurrentPage("1");
		search.setPageSize(3);
		
		String buyerId = "user11";
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, buyerId);
	
		List<Purchase> list = (List<Purchase>) map.get("list");
		
		for(Object obj : list) {
			System.out.println(obj+"\n");
		}
	}
	
	//@Test
	public void testUpdatePurchase() throws Exception{
		
		Product product = new Product();
		Purchase purchase = new Purchase();
		
		product.setProdNo(10002);
		
		purchase.setPaymentOption("0");
		purchase.setReceiverName("홍길순");
		purchase.setReceiverPhone("010-9876-5432");
		purchase.setDivyAddr("경기도 하남시");
		purchase.setDivyRequest("느린 배송");
		purchase.setDivyDate("1999/02/05");
		purchase.setPurchaseProd(product);
		
		purchaseService.updatePurchase(purchase);
	}
	
	//@Test
	public void testUpdateTranCode() throws Exception{
		
		Purchase purchase = new Purchase();
		
		purchase.setTranCode("2");
		purchase.setTranNo(10001);
		
		purchaseService.updateTranCode(purchase);
	}
	
	
}
