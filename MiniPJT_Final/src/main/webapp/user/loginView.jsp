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
	<script type="text/javascript">
	
		$(function(){
			
			$('button:contains("LOGIN")').click(function(){
				
				var id = $('input[name="userId"]').val();
				var pwd = $('input[name="password"]').val();
				
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
			margin-top: 70px;
		}
		.login-container{
			margin-top: 15%;
		}
		
		#img{
			display:flex;
			margin-top:20px;
			justify-content: center;
		}
		#img-in{
			display:flex;
			justify-content: center;
		}
		#login-bar-img{
			display: flex;
			justify-content: space-between;
		}
		
	</style>
</head>

<body>
<form>
	<jsp:include page="../header.jsp"></jsp:include>
	
	<div class="container-fluid login-container">
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				
				  <div class="form-group">
				    <label>ID</label>
				    <input type="text" class="form-control" name="userId" placeholder="Id">
				  </div>
				  <div class="form-group">
				    <label>Password</label>
				    <input type="password" class="form-control" name="password" placeholder="Password">
				  </div>
				  <div class="checkbox">
				    <label>
				      <input type="checkbox"> Check me out
				    </label>
				  </div>
				  <button type="button" class="btn btn-default">LOGIN</button>
				<div id="img">
					<div id="img-in">
						<div id="kakao-img">
							<img id="kakao-png" src="/images/RestApi/Kakao/kakao_login_medium_wide.png">
						</div>
					</div>
				</div>
				
			</div>
			<div class="col-md-4"></div>
		</div>
	</div>
	
</form>
</body>
</html>
</body>
</html>