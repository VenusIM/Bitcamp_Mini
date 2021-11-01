package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;

import oracle.net.aso.s;

@Repository("purchaseDao")
public class PurchaseDaoImpl implements PurchaseDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public PurchaseDaoImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void insertPurchase(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("PurchaseMapper.insertPurchase",purchase);
	}

	@Override
	public Purchase findPurchase(int tranNo) throws Exception {
		// TODO Auto-generated method stub
		
		Purchase purchase = sqlSession.selectOne("PurchaseMapper.findPurchase",tranNo);
		System.out.println(purchase);
		
		if(purchase.getDivyDate() != null) {
			purchase.setDivyDate(purchase.getDivyDate().substring(0,10));
		}
		if(purchase.getOrderDate() != null) {
			purchase.setOrderDate(purchase.getOrderDate().substring(0,10));
		}
		
		String tranCode = purchase.getTranCode();
		
		if( tranCode == null ) {
			tranCode = "판매중";
		}else {
			tranCode = tranCode.trim();
			if(tranCode.equals("1")){
				tranCode = "구매완료";
			}else if(tranCode.equals("2")){
				tranCode = "배송중";
			}else if(tranCode.equals("3")){
				tranCode = "배송완료";
			}
		}
		purchase.setTranCode(tranCode);
		
		String paymentOption = purchase.getPaymentOption().trim();
		if(paymentOption.equals("1")) {
			paymentOption="현금구매";
		}else {
			paymentOption="신용구매";
		}
		purchase.setPaymentOption(paymentOption);
		
		
		return purchase;
	}

	@Override
	public List<Purchase> findPurchase2(int prodNo) throws Exception {
		// TODO Auto-generated method stub
		
		List<Purchase> list = sqlSession.selectList("PurchaseMapper.findPurchase2",prodNo);
		
		String tranCode = null;
		for(Purchase purchase : list) {
			tranCode = purchase.getTranCode().trim();
			purchase.setTranCode(tranCode);
		}
		
		return list;
	}

	@Override
	public Map<String, Object> getPurchaseList(Search search, String buyerId) throws Exception {
		// TODO Auto-generated method stub
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("buyerId", buyerId);
		
		List<Purchase> list = sqlSession.selectList("PurchaseMapper.getPurchaseList", map);
		
		String tranCode = null;
		for(Purchase purchase : list) {
			tranCode = purchase.getTranCode().trim();
			purchase.setTranCode(tranCode);
		}
		
		int totalCount = sqlSession.selectOne("PurchaseMapper.getTotalCount",buyerId);
		
		
		map.clear();
		map.put("totalCount", totalCount);
		map.put("list", list); 
		
		return map;
	}

	@Override
	public Map<String, Object> getSaleList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("PurchaseMapper.updatePurchase",purchase);
		
	}

	@Override
	public void updateTranCode(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("PurchaseMapper.updateTranCode",purchase);
	}
	
	@Override
	public void insertPurchaseCart(Purchase purchase) throws Exception{
		sqlSession.insert("PurchaseMapper.insertPurchaseCart",purchase);
	}

	@Override
	public Purchase findCart(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
	
		return sqlSession.selectOne("PurchaseMapper.getCart",purchase);
	}

	@Override
	public Map<String, Object> findCartList(Search search , String userId) throws Exception {
		// TODO Auto-generated method stub
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("userId", userId);
		
		List<Purchase> list = sqlSession.selectList("PurchaseMapper.getCartList", map);
		int total = sqlSession.selectOne("PurchaseMapper.getTotalCart",userId);
		map.clear();
		
		map.put("list",list);
		map.put("total", total);
		
		return map;
	}
	@Override
	public void deleteCart(String userId , int prodNo) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("prodNo", prodNo);
		
		sqlSession.delete("PurchaseMapper.deleteCart",map);
	}

}
