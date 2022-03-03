package com.model2.mvc.web.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
		
	public UserRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		
		System.out.println("/user/json/getUser : GET");
		
		//Business Logic
		return userService.getUser(userId);
	}

	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}
		
		return dbUser;
	}
	
	@RequestMapping(value="json/logout",method=RequestMethod.GET)
	public String logout(HttpSession session) {
		System.out.println("/user/logout : GET");
		
		session.invalidate();
		
		return "redirect:/index.jsp";
	}
	
	@RequestMapping( value="json/addUser", method=RequestMethod.POST)
	public User addUser(@RequestBody User user) throws Exception{
		System.out.println("/user/addUser : POST");
		userService.addUser(user);
		
		return userService.getUser(user.getUserId());
	}
	
	@RequestMapping(value="json/updateUser", method=RequestMethod.POST)
	public User updateUser(@RequestBody User user) throws Exception{
		
		userService.updateUser(user);
		
		return userService.getUser(user.getUserId());
	}
	
	@RequestMapping(value="json/checkDuplication", method=RequestMethod.POST)
	public Map<String, Object> checkDuplication_CodeHaus(
			@RequestBody String userId) throws Exception{
		
		boolean result = userService.checkDuplication(userId);
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		map.put("result", result);
		map.put("userId", userId);
		map.put("String", "한글처리 되나요?");
		
		return map;
	}
	
	@RequestMapping(value="json/listUser", method=RequestMethod.POST)
	public Map<String,Object> listUserPost(@RequestBody Search search) throws Exception{
		
		System.out.println("/user/listUser : POST");

		Map<String, Object> map = new HashMap<String,Object>();
		
		if(search.getCurrentPage() == null || search.getCurrentPage().equals("")){
			search.setCurrentPage("1");
		}
		if(search.getPageSize() == 0) {
			search.setPageSize(pageSize);
		}
		
		// Business logic 수행
		map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
	
	@RequestMapping(value="json/autoComplete/{searchKeyword}/{searchCondition}", method=RequestMethod.GET)
	public List<String> userAutoComplete(	@PathVariable("searchCondition") String searchCondition,
										@PathVariable("searchKeyword") String searchKeyword) throws Exception{
		
		Search search = new Search();
		search.setSearchCondition(searchCondition);
		search.setSearchKeyword(searchKeyword);
		
		return userService.userAutoComplete(search);
	}
	
	@RequestMapping(value="json/listUser/{value}", method=RequestMethod.GET)
	public Map<String,Object> listUserGet(@ModelAttribute Search search) throws Exception{
		
		System.out.println("/user/listUser : GET");

		Map<String, Object> map = new HashMap<String,Object>();
		
		if(search.getCurrentPage() == null || search.getCurrentPage().equals("")){
			search.setCurrentPage("1");
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		map.put("resultPage", resultPage);
		map.put("search", search);
		
		return map;
	}
}