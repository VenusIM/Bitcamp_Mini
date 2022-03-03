package com.model2.mvc.web.purchase;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.pattern.IntegerPatternConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
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
	
	public PurchaseController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	
//	@RequestMapping("/addPurchase.do")
	@RequestMapping("addPurchase")
	public String addPurchase(	@ModelAttribute("purchase") Purchase purchase,
								@ModelAttribute("product") Product product,
								HttpSession session) throws Exception{
		
		User user = (User)session.getAttribute("user");
		System.out.println(user);
		purchase.setBuyer(user);
		
		int prodTotal = productService.getProduct(product.getProdNo()).getProdTotal();
		prodTotal -= purchase.getPurchaseQuantity();
		product.setProdTotal(prodTotal);
		productService.updateProduct2(product);
		
		purchase.setPurchaseProd(product);
		purchase.setTranCode("1");
		System.out.println(purchase);
		
		purchaseService.addPurchase(purchase);
		
		return "forward:/purchase/addPurchase.jsp";
	}
	
//	@RequestMapping("/addPurchaseView.do")
	@RequestMapping("addPurchaseView")
	public String addPurchaseView(	@RequestParam("prodNo") String prodNo,
									Model model, HttpSession session) throws Exception{
		
		model.addAttribute("product",productService.getProduct(Integer.parseInt(prodNo)));
		
		User user = (User)session.getAttribute("user");
		if(user == null) {
			return "forward:/user/login";
		}
		
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	@RequestMapping("getPurchase")
	public String getPurchase(	@ModelAttribute("product") Product product,
								Model model, HttpSession session) throws Exception{
		
		int prodNo = product.getProdNo();
		int tranNo = product.getTranNo();
		
		Purchase purchase = null;
		List<Purchase> list = null;
		if(prodNo != 0 ) {
			list = purchaseService.getPurchase2(prodNo);
			model.addAttribute("list",list);
		}
		if(tranNo != 0) {
			purchase = purchaseService.getPurchase(tranNo);
			model.addAttribute("purchase",purchase);
		}
		
		model.addAttribute("user",(User)session.getAttribute("user"));
		
		return "forward:/purchase/getPurchase.jsp";
	}
	
//	@RequestMapping("/listPurchase.do")
	@RequestMapping("listPurchase")
	public String listPurchase(	@ModelAttribute("search") Search search,
								HttpSession session, Model model) throws Exception{
		
		//현재 오픈된 페이지 번호
		if(search.getCurrentPage() == null || search.getCurrentPage().equals("")){
			search.setCurrentPage("1");
		}else {
			String[] currentPage =search.getCurrentPage().split(",");
			search.setCurrentPage(currentPage[0]);
		}
		
		
		User user = (User)session.getAttribute("user");
		
		String[] sort= null;
		String rowCondition = search.getRowCondition();
		if(rowCondition != null && !rowCondition.equals("")) {
			sort = rowCondition.split(",");
			
			if(sort[0].equals("3개씩 보기")) {
				pageSize = 3;
			}else if(sort[0].equals("5개씩 보기")) {
				pageSize = 5;
			}else if(sort[0].equals("10개씩 보기")) {
				pageSize = 10;
			}
		}
		search.setPageSize(pageSize);
		
		String sortCondition = search.getSortCondition();
		if(sortCondition != null && !sortCondition.equals("")) {
			sort = sortCondition.split(",");
			search.setSortCondition(sort[0]);
		}
		
		Map<String , Object> map= purchaseService.getPurchaseList(search, user.getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("list", map.get("list"));
		model.addAttribute("search", search);
		
		return "forward:/purchase/listPurchase.jsp";
	}
	
//	@RequestMapping("/updatePurchase.do")
	@RequestMapping("updatePurchase")
	public String updatePurchase(	@ModelAttribute("purchase") Purchase purchase,
									@ModelAttribute("product") Product product,
									@ModelAttribute("user") User user) throws Exception{
		
		purchase.setPurchaseProd(product);
		purchase.setBuyer(user);
		purchaseService.updatePurchase(purchase);
		purchase.setOrderDate(LocalDate.now().toString());
		return "forward:/purchase/updatePurchase.jsp";
	}
	
	@RequestMapping("updatePurchaseView")
	public String updatePurchaseView(	@RequestParam("tranNo") int tranNo,
										Model model) throws Exception{
		
		model.addAttribute("purchase",purchaseService.getPurchase(tranNo));
		
		return "forward:/purchase/updatePurchaseView.jsp";
	}
//	@RequestMapping("/updateTranCode.do")
	@RequestMapping("updateTranCode")
	public String updateTranCode(	@RequestParam("tranNo") String tranNo,
									Model model) throws Exception{
		Purchase purchase = new Purchase();
		
		purchase.setTranNo(Integer.parseInt(tranNo));
		purchase.setTranCode("3");
		System.out.println(purchase);
		
		purchaseService.updateTranCode(purchase);
		
		return "forward:/purchase/listPurchase";
	}
//	@RequestMapping("/updateTranCodeByProd.do")
	@RequestMapping("updateTranCodeByProd")
	public String updateTranCodeByProd(	@ModelAttribute("purchase") Purchase purchase,
										@ModelAttribute("search") Search search,
										Model model) throws Exception{
		
		purchase.setTranCode("2");
		purchaseService.updateTranCode(purchase);
		
		search.setSearchCondition(null);
		search.setPageSize(pageSize);
		Map<String , Object> map = productService.getProductListAdmin(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("list", map.get("list"));
		
	
		return "forward:/product/listProduct.jsp";
	}
	//============================================장바구니======================================
	@RequestMapping("addPurchaseCart")
	public String addPurchaseCart( 	HttpServletRequest request
									,HttpSession session) throws Exception {
		
		User user = (User)session.getAttribute("user");
	
		if(user == null) {
			return "forward:/user/login	";
		}
		
		Purchase purchase = new Purchase();
			
		Product product = productService.getProduct(Integer.parseInt(request.getParameter("prodNo")));
		purchase.setPurchaseProd(product);
		purchase.setBuyer(user);
		
		if(purchaseService.findCart(purchase) == null) {
			
			purchaseService.addPurchaseCart(purchase);				
		}
		
		return "forward:/purchase/findCartList";
	}
	
	@RequestMapping("findCartList")
	public ModelAndView findCartList( @ModelAttribute("search") Search search, HttpSession session) throws Exception {
		
		if(search.getCurrentPage() == null || search.getCurrentPage().equals("")){
			search.setCurrentPage("1");
		}else {
			String[] currentPage =search.getCurrentPage().split(",");
			search.setCurrentPage(currentPage[0]);
		}
		
		String[] sort= null;
		String rowCondition = search.getRowCondition();
		if(rowCondition != null && !rowCondition.equals("")) {
			sort = rowCondition.split(",");
			
			if(sort[0].equals("3개씩 보기")) {
				pageSize = 3;
			}else if(sort[0].equals("5개씩 보기")) {
				pageSize = 5;
			}else if(sort[0].equals("10개씩 보기")) {
				pageSize = 10;
			}
		}
		search.setPageSize(pageSize);
		
		User user = (User)session.getAttribute("user");
		
		Map<String , Object> map= purchaseService.findCartList(search, user.getUserId());
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("total")).intValue(), pageUnit, pageSize);
		
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("forward:/purchase/listCart.jsp");
		mav.addObject("resultPage",resultPage);
		mav.addObject("list",map.get("list"));
	
		return mav;
	}
	
	@RequestMapping("addCartListView")
	public ModelAndView addCartListView(@ModelAttribute("product") Product product,
									HttpSession session) throws Exception{
		
		ModelAndView mav = new ModelAndView();
		
		String[] prodList = product.getProdNoList();
		String[] totalList = product.getProdTotalList();
		int totalPrice = 0;
		int totalCount = 0;
		String name = "";
		int count = 0;

		for(String str : totalList) {
			System.out.println("total : "+str+"\n");
			totalCount += Integer.parseInt(str);
		}
		
		List<Product> list = new ArrayList<Product>();
		for(String str : prodList) {
			count ++;
			product = productService.getProduct(Integer.parseInt(str));
			System.out.println("product : "+ product+"\n");
			list.add(product);
			totalPrice += product.getPrice()*Integer.parseInt(totalList[count-1]);
			name += product.getProdName();
			if(count < prodList.length) {
				name +=", ";}
			
		}
		session.setAttribute("list", list);
		session.setAttribute("totalList", totalList);
		session.setAttribute("prodList",prodList);
		
		mav.setViewName("forward:/purchase/addPurchaseView.jsp");
	
		mav.addObject("totalPrice",totalPrice);
		mav.addObject("name",name);
		mav.addObject("totalCount", totalCount);
		return mav;
	}
	
	@RequestMapping ("addCartList")
	public String addCartList(	@ModelAttribute Purchase purchase,
								HttpSession session, Model model) throws Exception{
		
		User user = (User)session.getAttribute("user");
		purchase.setBuyer(user);
		
		List<Product> prodList = (List<Product>)session.getAttribute("list");
		String[] totalList = (String[])session.getAttribute("totalList");
		
		int prodNo = 0;
		int count = 0;
		int temp = 0;
		
		for(Product prod : prodList) {
			count++;
			prodNo = prod.getProdNo();
			temp = prod.getProdTotal();
			prod.setProdTotal(temp-Integer.parseInt(totalList[count-1]));
			productService.updateProduct2(prod);
			
			purchase.setPurchaseProd(prod);
			purchase.setPurchaseQuantity(Integer.parseInt(totalList[count-1]));
			purchase.setTranCode("1");
			purchaseService.addPurchase(purchase);
		}
		System.out.println("logic 수행 끝");
	
		
		return "forward:/purchase/addPurchase.jsp";
	}
	
	@RequestMapping("deleteCart/{prodNo}")
	public String deleteCart(	@PathVariable("prodNo") int prodNo,
								HttpSession session) throws Exception{
		User user = (User)session.getAttribute("user");
		
		purchaseService.deleteCart(user.getUserId(), prodNo);
		
		return "forward:/purchase/findCartList";
	}
}
