<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>

<title>Model2 MVC Shop</title>

<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<!-- <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script> -->
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
	<script type="text/javascript">
		$(function(){
			
			$('#loginButton').click(function(){
				var id = $($('.input-group-addon')[0]).next().val();
				var pwd = $('.input-group-addon:contains("PWD")').next().val();
				
				if(id.length == 0){
					alert("아이디를 입력해 주세요.");
					return;
				}
				
				if(pwd.length == 0){
					alert("패스워드를 입력해 주세요.");
					return;
				}
				
				$('form').attr('method','post').attr('action','/user/login').submit();
			});
		});
		
		$(function(){
			$('a:contains("회원가입")').click(function(){
				console.log('실행');
				$('form').attr('method','get').attr('action','/user/addUser').submit();
			});
			
			$('.btn-default:contains("장바구니")').click(function(){
				var href = $(this).attr('href');
				console.log(href);
				
				
				if(${empty user.role}){
					alert('로그인을 해주세요');
					$(this).attr('href',"/user/loginView.jsp");
				}else{
					if(confirm('상품이 담겼습니다. 장바구니로 이동하시겠습니까?') == true){
						$(this).attr('href',href);

					}else{
						$(this).attr('href','/index.jsp');
					}					
				}
			});
			
			$("#kakao-png").on("click",function(){
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
		});
		
	</script>
	
	<style>
		body{
			padding-top:70px;
		}
	</style>
</head>
<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="container-fluid">
			<a class="navbar-brand" href="/">
				<span class="glyphicon glyphicon-gift"></span>
				<span> Model2 MVC SHOP </span>
				<span class="glyphicon glyphicon-gift"></span>
			</a>
			
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
			</div>	
			
			<div class="collapse navbar-collapse" id="target">
				<ul class="nav navbar-nav">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<span>BEST</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li><a href="#">1</a></li>
							<li><a href="#">2</a></li>					
						</ul>
					</li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<span>CATEGORY</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li><a href="#">1</a></li>
							<li><a href="#">2</a></li>			
						</ul>
					</li>
					<li><a>최근 본 상품</a></li>
				</ul>
				
				<ul class="nav navbar-nav navbar-right">

				<c:if test="${empty user.role }">
					<li><a>회원가입</a></li>
					<li class="dropdown">
						<a class="dropdown-toggle" data-toggle="dropdown">
							<span>로그인</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li class="dropdown-header">로그인</li>
							
						</ul>
					</li>
				</c:if>
					
				<c:if test="${!empty user.role && user.role eq 'admin' }">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<span>${user.userName}님</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li class="dropdown-header">사용자</li>
							<li><a>사용자 관리</a></li>
							<li class="divider"></li>
							<li class="dropdown-header">판매</li>
							<li><a>상품 관리</a></li>
							<li><a>배송 관리</a></li>				
						</ul>
					</li>
					<li>
						<a href="/purchase/findCartList">
							<span class="glyphicon glyphicon-shopping-cart"></span>
							<span>장바구니</span>
						</a>
					</li>
					<li>
						<a href="/user/logout">로그아웃</a>
					</li>					
					
				</c:if>
				<c:if test="${!empty user.role && user.role eq 'user' }">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<span>${user.userName}님</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li class="dropdown-header">정보</li>
							<li><a href="">내정보보기</a></li>
							<li><a href="">구매내역조회</a></li>		
						</ul>
					</li>
					<li>
						<a href="/purchase/findCartList">
							<span class="glyphicon glyphicon-shopping-cart"></span>
							<span>장바구니</span>
						</a>
					</li>
					<li>
						<a href="/user/logout">로그아웃</a>
					</li>				
					
				</c:if>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>