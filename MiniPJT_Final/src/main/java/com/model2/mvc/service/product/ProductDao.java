package com.model2.mvc.service.product;

import java.util.List;
import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

public interface ProductDao {
	
	public void insertProduct(Product product) throws Exception;
	
	public Product findProduct(int prodNO) throws Exception;
	
	public Map<String,Object> getProductListUser(Search search) throws Exception;
	
	public Map<String,Object> getProductListAdmin(Search search) throws Exception;
	
	public void updateProduct(Product product) throws Exception;
	
	public void updateProduct2(Product product) throws Exception;
	
	public List<String> productAutoComplete(Search search) throws Exception;
}
