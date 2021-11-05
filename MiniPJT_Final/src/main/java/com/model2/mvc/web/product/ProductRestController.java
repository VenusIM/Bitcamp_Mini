package com.model2.mvc.web.product;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping(value = "/product/*")
public class ProductRestController {
	
	@Autowired
	@Qualifier("productService")
	private ProductService productService;

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	public ProductRestController() {
		System.out.println(this.getClass()+"\n");
	}
	
	@RequestMapping(value="rest/addProduct", method=RequestMethod.POST)
	public Product addProductJson(@RequestBody Product product ) throws Exception{
		
		product.setManuDate(product.getManuDate().replace("-", ""));
		
		//productService.addProduct(product);
		
		return productService.getProduct(product.getProdNo());
	}
	
	@RequestMapping(value="rest/getProduct", method=RequestMethod.POST)
	public Product getProductJson(	@RequestBody Product product) throws Exception{
		
		System.out.println(product);
		
		product = productService.getProduct(product.getProdNo());
		System.out.println(product);
		
		return product;
	}
	
	@RequestMapping(value="rest/listProduct/{currentPage}/{menu}", method=RequestMethod.GET)
	public Map<String,Object> listProduct(	@PathVariable("currentPage") String currentPage,
											@PathVariable("menu") String menu,
											HttpServletRequest request) throws Exception{
		System.out.println("listProdiuct.do 실행");
		
		System.out.println(currentPage);
		System.out.println(menu);
		
		if(menu != null) {
			request.getSession().setAttribute("menu", menu);
		}else {
			menu = (String)request.getSession().getAttribute("menu");
		}
		
		Search search = new Search();
		
		search.setCurrentPage(currentPage);
		search.setPageSize(pageSize);
		
		Map<String , Object> map= null;
		
		if(menu.equals("manage")) {
			map = productService.getProductListAdmin(search);
		}else {
			map = productService.getProductListUser(search);
		}
		
		Page resultPage = new Page( currentPage, ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		map.put("resultPage", resultPage);
		map.put("search",search);
		return map;
	}
	
	@RequestMapping(value="rest/listProduct/option/{menu}/{searchKeyword}", method=RequestMethod.POST)
	public Map<String,Object> listProductOption(	@RequestBody Search search,
													@PathVariable("menu") String menu,
													@PathVariable("searchKeyword") String searchKeyword,
													HttpServletRequest request) throws Exception{
		
		System.out.println("option 실행");
		System.out.println(search);
		System.out.println(request);
		
		if(menu != null) {
			request.getSession().setAttribute("menu", menu);
		}else {
			menu = (String)request.getSession().getAttribute("menu");
		}
		
		search.setSearchKeyword(searchKeyword);
		
		search.setPageSize(pageSize);
		
		Map<String , Object> map= null;
		
		if(menu.equals("manage")) {
			map = productService.getProductListAdmin(search);
		}else {
			map = productService.getProductListUser(search);
		}
		
		return map;
	}
	
	@RequestMapping(value="rest/listProduct/{menu}", method=RequestMethod.POST)
	public Map<String,Object> listProduct(	@RequestBody Search search,
											@PathVariable String menu,
											HttpServletRequest request) throws Exception{
		System.out.println("listProdiuct.do 실행");
		System.out.println(search);
		System.out.println(request);

		//String currentPage = search.getCurrentPage();
		
		
		if(menu != null) {
			request.getSession().setAttribute("menu", menu);
		}else {
			menu = (String)request.getSession().getAttribute("menu");
		}
		
		search.setPageSize(pageSize);
		
		Map<String , Object> map= null;
		
		if(menu.equals("manage")) {
			map = productService.getProductListAdmin(search);
		}else {
			map = productService.getProductListUser(search);
		}

		return map;
	}
	
	@RequestMapping(value="rest/updateProduct", method=RequestMethod.POST)
	public Product updateProduct(	@RequestBody Product product) throws Exception{
		
		product.setManuDate(product.getManuDate().replace("-", ""));
		productService.updateProduct(product);
		product = productService.getProduct(10008);
		product.setRegDate(productService.getProduct(product.getProdNo()).getRegDate());
		
		
		return product;
	}
	
	@RequestMapping(value="rest/updateProductView", method=RequestMethod.POST)
	public Product updateProductView( @RequestBody int prodNo) throws Exception{
		
		return productService.getProduct(prodNo);
	}
	
	@RequestMapping(value="rest/productAutoComplete/{searchKeyword}/{searchCondition}", method=RequestMethod.GET)
	public List<String> productAutoComplete(	@PathVariable("searchKeyword") String searchKeyword,
												@PathVariable("searchCondition") String searchCondition) throws Exception{
		
		System.out.println(searchKeyword);
		searchKeyword= new String(searchKeyword.getBytes("8859_1"), "UTF-8");
		System.out.println(searchKeyword);
		
		Search search = new Search();
		search.setSearchCondition(searchCondition);
		search.setSearchKeyword(searchKeyword);
		
		return productService.productAutoComplete(search);
	}
	
}
