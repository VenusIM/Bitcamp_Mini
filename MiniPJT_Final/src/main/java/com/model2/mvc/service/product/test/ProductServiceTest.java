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
 * ㅇ JUnit4 (Test Framework) 과 Spring Framework 통합 Test( Unit Test)
 * ㅇ Spring 은 JUnit 4를 위한 지원 클래스를 통해 스프링 기반 통합 테스트 코드를 작성 할 수 있다.
 * ㅇ @RunWith : Meta-data 를 통한 wiring(생성,DI) 할 객체 구현체 지정
 * ㅇ @ContextConfiguration : Meta-data location 지정
 * ㅇ @Test : 테스트 실행 소스 지정
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {	"classpath:config/context-common.xml",
									"classpath:config/context-aspect.xml",
									"classpath:config/context-mybatis.xml",
									"classpath:config/context-transaction.xml" })
public class ProductServiceTest {

	//==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("productService")
	private ProductService productService;

	//@Test
	public void testInsertProduct() throws Exception {
		
		Product product = new Product();
		product.setProdName("카카오");
		product.setProdTotal(10);
		product.setPrice(10000);
		product.setProdDetail("초콜릿을 만들자");
		product.setManuDate("20211006");
		product.setFileName("카카오.jpg");
		
		productService.addProduct(product);

		System.out.println(product);
		

		Assert.assertEquals("카카오", product.getProdName());
		Assert.assertEquals(10000, product.getPrice());
		Assert.assertEquals("초콜릿을 만들자", product.getProdDetail());
		Assert.assertEquals("20211006", product.getManuDate());
		Assert.assertEquals("카카오.jpg", product.getFileName());
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
		search.setSearchKeyword("삼성");
		search.setSortCondition("높은 가격 순");
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
		search.setSearchKeyword("삼성");
		search.setSortCondition("가격 낮은 순");
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
		product.setProdName("가가오");
		product.setProdDetail("화이트 초콜릿 만들자");
		product.setManuDate("19990205");
		product.setPrice(10000);
		product.setFileName("ㅋㅋ오.jpg");
		
		productService.updateProduct(product);
	}
	//@Test
	public void testUpdateProduct2() throws Exception {
		
		Product product = new Product();
		product.setProdNo(10017);
		product.setProdName("가가오");
		product.setProdDetail("화이트 초콜릿 만들자");
		product.setManuDate("19990205");
		product.setPrice(10000);
		product.setFileName("ㅋㅋ오.jpg");
		
		productService.updateProduct2(product);
	}
	
}
	