package com.model2.mvc.service.purchase.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;

@Service("purchaseService")
public class PurchaseServiceImpl implements PurchaseService{
	
	@Autowired
	@Qualifier("purchaseDao")
	private PurchaseDao purchaseDao;
	
	public PurchaseServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void addPurchase(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		purchaseDao.insertPurchase(purchase);
	}

	@Override
	public Purchase getPurchase(int tranNo) throws Exception {
		// TODO Auto-generated method stub
		return purchaseDao.findPurchase(tranNo);
	}

	@Override
	public List<Purchase> getPurchase2(int prodNo) throws Exception {
		// TODO Auto-generated method stub
		return purchaseDao.findPurchase2(prodNo);
	}

	@Override
	public Map<String, Object> getPurchaseList(Search search, String buyerId) throws Exception {
		// TODO Auto-generated method stub
		return purchaseDao.getPurchaseList(search, buyerId);
	}

	@Override
	public Map<String, Object> getSaleList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		purchaseDao.updatePurchase(purchase);
	}

	@Override
	public void updateTranCode(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		purchaseDao.updateTranCode(purchase);
	}

	@Override
	public void addPurchaseCart(Purchase purchase) throws Exception{
		purchaseDao.insertPurchaseCart(purchase);
	}

	@Override
	public Purchase findCart(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		return purchaseDao.findCart(purchase);
	}

	@Override
	public Map<String, Object> findCartList(Search search , String userId) throws Exception {
		// TODO Auto-generated method stub
		return purchaseDao.findCartList(search,userId);
	}

	@Override
	public void deleteCart(String userId, int prodNo) throws Exception {
		// TODO Auto-generated method stub
		purchaseDao.deleteCart(userId, prodNo);
	}
	
}
