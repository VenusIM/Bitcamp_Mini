<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>Model2 MVC Shop</title>

<link href="/css/left.css" rel="stylesheet" type="text/css">

</head>

	<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script type="text/javascript">
	$(function(){
		
		$("span:contains('로그인')").on("click", function(){
			$(window.parent.frames["rightFrame"].document.location).attr("href","/user/login");
		});
		
		$("span:contains('로그아웃')").on("click", function(){
			$(window.parent.frames.document.location).attr("href","/user/logout");
		});
		
		$("img").on("click",function(){
			Kakao.init('b3bed223fd618abc07f64c2103ca9659');
			console.log(Kakao.isInitialized());
			Kakao.Auth.login({
			      success: function(authObj) {
			        console.log(JSON.stringify(authObj))
			        $(window.parent.frames.document.location).attr("href","/user/login/pass");
			      },
			      fail: function(err) {
			        console.log(JSON.stringify(err))
			      },
			    })
		});
		
		$("h2:contains('Model2 MVC Shop')").on("click",function(){
			$(window.parent.frames.document.location).attr("href","/index.jsp");
		});	
	});

</script>

<body topmargin="0" leftmargin="0">
 
<table width="100%" height="50" border="0" cellpadding="0" cellspacing="0">
  <tr>
	<td height="10"></td>
	<td height="10" >&nbsp;</td>
  </tr>
  <tr>
    <td width="800" height="30">
    	<h2>Model2 MVC Shop</h2>
    </td>
    <td>
    <c:if test="${empty user.role}">
    	<img src="../images/RestAPIKaKao/kakao_login_medium_wide.png" align="middle">
    </c:if>
    </td>
  </tr>
  <tr>
    <td height="20" align="right" background="/images/img_bg.gif">
	    <table width="200" border="0" cellspacing="0" cellpadding="0">
	        <tr> 
	          <td width="115">
		          <c:if test="${ empty user }">
		          		<!-- //////////////////////////////////////////////////////////////////////////////////// 
		              <a href="/loginView.do" target="rightFrame">login</a>
		              	////////////////////////////////////////////////////////////////////////////////////////// -->
		              <!-- <a href="/user/login" target="rightFrame">login</a>-->
		              <span>로그인</span>
		              
		           </c:if>   
	          </td>
	          <td width="14">&nbsp;</td>
	          <td width="56">
		          <c:if test="${ ! empty user }">
		          		<!-- //////////////////////////////////////////////////////////////////////////////////// 
		              <a href="/logout.do" target="_parent">logout</a>
		              	////////////////////////////////////////////////////////////////////////////////////////// -->
		            	<!-- <a href="/user/logout" target="_parent">logout</a> -->
		            	<span>로그아웃</span>  
		           </c:if>
	          </td>
	        </tr>
	      </table>
      </td>
    <td height="20" background="/images/img_bg.gif">&nbsp;</td>
    
  </tr> 
  
</table>

</body>
</html>
