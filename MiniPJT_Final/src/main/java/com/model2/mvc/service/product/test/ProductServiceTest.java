package com.model2.mvc.service.product.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.validator.PublicClassValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;



/*
 *	FileName :  UserServiceTest.java
 * �� JUnit4 (Test Framework) �� Spring Framework ���� Test( Unit Test)
 * �� Spring �� JUnit 4�� ���� ���� Ŭ������ ���� ������ ��� ���� �׽�Ʈ �ڵ带 �ۼ� �� �� �ִ�.
 * �� @RunWith : Meta-data �� ���� wiring(����,DI) �� ��ü ����ü ����
 * �� @ContextConfiguration : Meta-data location ����
 * �� @Test : �׽�Ʈ ���� �ҽ� ����
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {	"classpath:config/context-common.xml",
									"classpath:config/context-aspect.xml",
									"classpath:config/context-mybatis.xml",
									"classpath:config/context-transaction.xml" })
public class ProductServiceTest {

	//==>@RunWith,@ContextConfiguration �̿� Wiring, Test �� instance DI
	@Autowired
	@Qualifier("productService")
	private ProductService productService;

	//@Test
	public void testInsertProduct() throws Exception {
		
		Product product = new Product();
		product.setProdName("īī��");
		product.setProdTotal(10);
		product.setPrice(10000);
		product.setProdDetail("���ݸ��� ������");
		product.setManuDate("20211006");
		product.setFileName("īī��.jpg");
		
		productService.addProduct(product);

		System.out.println(product);
		

		Assert.assertEquals("īī��", product.getProdName());
		Assert.assertEquals(10000, product.getPrice());
		Assert.assertEquals("���ݸ��� ������", product.getProdDetail());
		Assert.assertEquals("20211006", product.getManuDate());
		Assert.assertEquals("īī��.jpg", product.getFileName());
	}
	
	//@Test
	public void testFindProduct() throws Exception {
		
		Product product = productService.getProduct(10010);
		
		System.out.println(product);
			
	}
	//@Test
	public void testGetProductListUser() throws Exception {
		
		Search search = new Search();
		
		search.setSearchCondition("1");
		search.setSearchKeyword("�Ｚ");
		search.setSortCondition("���� ���� ��");
		search.setCurrentPage("1");
		search.setPageSize(3);
		
		Map<String, Object> map = productService.getProductListUser(search);
		
		List<Product> list = (List<Product>)map.get("list");
		int totalCount = (int)map.get("totalCount");
		
		System.out.println("totalCount : "+totalCount);
		
		System.out.println(list.size());
		for(Object obj : list) {
			System.out.println(obj+"\n");
			
		}
	}
	
	//@Test
	public void testGetProductListAdmin() throws Exception {
		
		Search search = new Search();
		
		search.setSearchCondition("1");
		search.setSearchKeyword("�Ｚ");
		search.setSortCondition("���� ���� ��");
		search.setCurrentPage("1");
		search.setPageSize(3);
		
		Map<String, Object> map = productService.getProductListAdmin(search);
		
		List<Product> list = (List<Product>)map.get("list");
		int totalCount = (int)map.get("totalCount");
		
		System.out.println("totalCount : "+totalCount);
		
		System.out.println(list.size());
		for(Object obj : list) {
			System.out.println(obj+"\n");
			
		}
	}
	
	@Test
	public void testUpdateProduct() throws Exception {
		
		Product product = new Product();
		product.setProdNo(10009);
		product.setProdName("������");
		product.setProdDetail("ȭ��Ʈ ���ݸ� ������");
		product.setManuDate("19990205");
		product.setPrice(10000);
		product.setFileName("������.jpg");
		
		productService.updateProduct(product);
	}
	//@Test
	public void testUpdateProduct2() throws Exception {
		
		Product product = new Product();
		product.setProdNo(10017);
		product.setProdName("������");
		product.setProdDetail("ȭ��Ʈ ���ݸ� ������");
		product.setManuDate("19990205");
		product.setPrice(10000);
		product.setFileName("������.jpg");
		
		productService.updateProduct2(product);
	}
	
}
	