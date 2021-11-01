package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;

@Repository("productDao")
public class ProductDaoImpl implements ProductDao{
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	@Override
	public void insertProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("ProductMapper.insertProduct",product);
	}
	@Override
	public Product findProduct(int prodNO) throws Exception {
		// TODO Auto-generated method stub
		
		return (Product)sqlSession.selectOne("ProductMapper.findProduct",prodNO);
	}
	@Override
	public Map<String, Object> getProductListUser(Search search) throws Exception {
		// TODO Auto-generated method stub
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		int totalCount = sqlSession.selectOne("ProductMapper.getTotalCountUser", search);
		List<Product> list = sqlSession.selectList("ProductMapper.getProductListUser",search);
		for(Product product : list) {
			String tranCode = product.getProTranCode();
			if(tranCode != null) {
				tranCode = tranCode.trim();
				if(tranCode.equals("1")) {
					tranCode = "구매완료";
				}else if(tranCode.equals("2")) {
					tranCode = "배송중";
				}else if(tranCode.equals("3")) {
					tranCode = "배송완료";
				}
			}else {
				tranCode="판매중";
			}
			product.setProTranCode(tranCode);
		}
		
		map.put("totalCount",totalCount);
		map.put("list", list);
		return map;
	}
	@Override
	public Map<String, Object> getProductListAdmin(Search search) throws Exception {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<String, Object>();
		
		int totalCount = sqlSession.selectOne("ProductMapper.getTotalCountAdmin", search);
		
		List<Product> list = sqlSession.selectList("ProductMapper.getProductListAdmin",search);
		
		for(Product product : list) {
			System.out.println(product+"\n");
			String tranCode = product.getProTranCode();
			if(tranCode != null) {
				tranCode = tranCode.trim();
				if(tranCode.equals("1")) {
					tranCode = "구매완료";
				}else if(tranCode.equals("2")) {
					tranCode = "배송중";
				}else if(tranCode.equals("3")) {
					tranCode = "배송완료";
				}
			}else {
				tranCode="판매중";
			}
			product.setProTranCode(tranCode);
		}
		
		map.put("totalCount",totalCount);
		map.put("list", list);
		return map;
	}
	@Override
	public void updateProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("ProductMapper.updateProduct",product);	
	}
	@Override
	public void updateProduct2(Product product) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("ProductMapper.updateProduct2",product);
	}
	
	public List<String> productAutoComplete(Search search) throws Exception{
		return sqlSession.selectList("ProductMapper.productAutoComplete",search);
	}
	
	
}
