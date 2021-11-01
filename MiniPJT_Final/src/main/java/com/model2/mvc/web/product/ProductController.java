package com.model2.mvc.web.product;

import java.io.File;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

//@Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	private static final String FILE_SERVER_PATH = "C:\\Users\\yim33\\git\\zz_Model2_Web\\zz_Model2_Web\\src\\main\\webapp\\images\\uploadFiles";
	
	@Autowired
	@Qualifier("productService")
	private ProductService productService;
	
	public ProductController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
//	@RequestMapping("/addProduct.do")
	@PostMapping("addProduct")
	public String addProduct(	@ModelAttribute("product") Product product, @RequestParam(value = "fileUpload", required=false) MultipartFile file, Model model) throws Exception{
		
		if(!file.getOriginalFilename().isEmpty()) {
			file.transferTo(new File(FILE_SERVER_PATH, file.getOriginalFilename()));
		}
		
		product.setFileName(file.getOriginalFilename());
		product.setManuDate(product.getManuDate().replace("-", ""));
		
		productService.addProduct(product);
		return "forward:/product/addProduct.jsp";
	}
	
//	@RequestMapping("/getProduct.do")
																																																																					@RequestMapping(value = "getProduct")
	public String getProduct(	@ModelAttribute("product") Product product,
								HttpSession session,
								HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String menu = (String)session.getAttribute("menu");
		
		//menu가 manage일 경우 상품 수정 페이지로 이동
		if(menu.equals("manage")) {
			return "/product/updateProductView";
		}
		
		//열어본 페이지 목록
		String history=null;
		Cookie[] cookies = request.getCookies();
		if (cookies!=null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie cookie = cookies[i];
				System.out.println(cookie.getName());
				if (cookie.getName().equals("history")) {
					history = cookie.getValue();
				}
			}
			history += ","+ product.getProdNo();
		}
		Cookie cookie = new Cookie("history",history);
		cookie.setPath("/");
		response.addCookie(cookie);
		
		System.out.println(product);
		
		product = productService.getProduct(product.getProdNo());
		
		String tranCode = product.getProTranCode();
		
		if(tranCode != null) {
			tranCode = new String(tranCode.getBytes("8859_1"),"euc-kr");
		}
		product.setProTranCode(tranCode);
		
		session.setAttribute("product",product);
		
		return "redirect:/product/getProduct.jsp";
	}
	
//	@RequestMapping("/listProduct.do")
	@RequestMapping("listProduct")
	public String listProduct(	@ModelAttribute("search") Search search,
								HttpSession session, Model model,
								HttpServletRequest request) throws Exception{
		System.out.println("listProdiuct.do 실행");
		//현재 오픈된 페이지 번호
		if(search.getCurrentPage() == null || search.getCurrentPage().equals("")){
			search.setCurrentPage("1");
		}
		
		//상품검색, 상품관리 구분하기 위한 menu값 추출
		String menu = request.getParameter("menu");
		if(menu != null) {
			request.getSession().setAttribute("menu", menu);
		}else {
			menu = (String)request.getSession().getAttribute("menu");
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
		
		//페이지에 출력해야하는 row수 체크
		
		String searchKeyword = search.getSearchKeyword();
		System.out.println(searchKeyword);
		if(searchKeyword != null) {
			search.setSearchKeyword(new String(searchKeyword.getBytes("8859_1"), "euc-kr"));
		}
		System.out.println(search.getSearchKeyword());
		search.setPageSize(pageSize);
		
		String sortCondition = search.getSortCondition();
		if(sortCondition != null && !sortCondition.equals("")) {
			sort = sortCondition.split(",");
			search.setSortCondition(sort[0]);
		}
		
		System.out.println(search);
		
		Map<String , Object> map= null;
				
		if(menu.equals("manage")) {
			map = productService.getProductListAdmin(search);
		}else {
			map = productService.getProductListUser(search);
		}
		
		

		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("list", map.get("list"));
		model.addAttribute("search", search);
		
		return "forward:/product/listProduct.jsp";
	}

//	@RequestMapping("/updateProduct.do")
	@RequestMapping("updateProduct")
	public String updateProduct(@ModelAttribute("product") Product product, @RequestParam(value = "fileUpload", required=false) MultipartFile file, Model model) throws Exception {
		
		if(!file.getOriginalFilename().isEmpty()) {
			file.transferTo(new File(FILE_SERVER_PATH, file.getOriginalFilename()));
		}
		
		product.setFileName(file.getOriginalFilename());
		product.setManuDate(product.getManuDate().replace("-", ""));
		
		System.out.println(product);
		
		productService.updateProduct(product);
		
		product.setRegDate(productService.getProduct(product.getProdNo()).getRegDate());
		
		return "forward:/product/updateProduct.jsp";
	}
	
//	@RequestMapping("/updateProductView.do")
	@RequestMapping("updateProductView")
	public String updateProductView(int prodNo, Model model) throws Exception {
		
		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("product",product);
		
		return "forward:/product/updateProductView.jsp";
	}
}
