package com.model2.mvc.service.product.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;
import com.model2.mvc.service.product.ProductService;

@Service("productService")
public class ProductServiceImpl implements ProductService{
	
	@Autowired
	@Qualifier("productDao")
	private ProductDao productDao;
	
	@Override
	public void addProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		productDao.insertProduct(product);
	}

	@Override
	public Product getProduct(int prodNo) throws Exception {
		// TODO Auto-generated method stub
		return productDao.findProduct(prodNo);
	}

	@Override
	public Map<String, Object> getProductListUser(Search search) throws Exception {
		// TODO Auto-generated method stub
		return productDao.getProductListUser(search);
	}

	@Override
	public Map<String, Object> getProductListAdmin(Search search) throws Exception {
		// TODO Auto-generated method stub
		return productDao.getProductListAdmin(search);
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		productDao.updateProduct(product);
	}

	@Override
	public void updateProduct2(Product product) throws Exception {
		// TODO Auto-generated method stub
		productDao.updateProduct2(product);
	}

	@Override
	public List<String> productAutoComplete(Search search) throws Exception {
		// TODO Auto-generated method stub
		return productDao.productAutoComplete(search);
	}
	
}
