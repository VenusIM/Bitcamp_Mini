package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	@Autowired
	@Qualifier("purchaseService")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productService")
	private ProductService productService;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	public static void main(String[] args) {
		
	}
	
	public PurchaseRestController() {
		System.out.println(this.getClass()+"\n");
	}
	
	@RequestMapping(value="rest/addPurchase", method=RequestMethod.POST)
	public Purchase addPurchase(@RequestBody Purchase purchase ) throws Exception{
		
		Product product = purchase.getPurchaseProd(); 
		
		int prodTotal = productService.getProduct(product.getProdNo()).getProdTotal();
		System.out.println("prodTotalBefore : "+prodTotal);
		
		prodTotal -= purchase.getPurchaseQuantity();
		System.out.println("prodTotalAfter : "+prodTotal);
		
		product.setProdTotal(prodTotal);
		productService.updateProduct2(product);
		
		purchase.setPurchaseProd(product);
		purchase.setTranCode("1");
		
		purchaseService.addPurchase(purchase);
		
		return purchaseService.getPurchase(10005);
	}
	
	@RequestMapping(value="rest/addPurchaseView/{prodNo}", method=RequestMethod.GET)
	public Product addPurchaseView(	@PathVariable("prodNo") int prodNo,
									HttpSession session) throws Exception{
		
		User user = (User)session.getAttribute("user");
		if(user != null && user.getRole() != null) {
			return null;
		}
		
		return productService.getProduct(prodNo);
		
	}
	
	public void getPurchase() throws Exception{
		
	}
	
	@RequestMapping(value="rest/listPurchase", method=RequestMethod.POST)
	public Map<String, Object> listPurchase( 	@RequestBody String value) throws Exception{
		
		JSONObject obj = (JSONObject)JSONValue.parse(value);
		
		ObjectMapper objectMapper = new ObjectMapper();
		Search search = objectMapper.readValue(obj.get("search").toString(), Search.class);
		System.out.println(search);
		
		search.setPageSize(pageSize);
		
		User user = objectMapper.readValue(obj.get("user").toString(), User.class);
		System.out.println(user.getUserId());
		
		Map<String , Object> map= purchaseService.getPurchaseList(search, user.getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		map.put("resultPage", resultPage);
		map.put("search",search);
		
		return map;
	}
	
	public void updatePurchase() throws Exception{
		
	}
	
	public void updatePurchaseView() throws Exception{
		
	}
	
	public void updateTranCode() throws Exception{
		
	}
	
	public void updateTranCodeByProd() throws Exception{
		
	}
	
	public void addPurchaseCart() throws Exception{
		
	}
	
	public void findCartList() throws Exception{
		
	}
	
	public void addCartListView() throws Exception{
		
	}
	
	public void addCartList() throws Exception{
		
	}
}
