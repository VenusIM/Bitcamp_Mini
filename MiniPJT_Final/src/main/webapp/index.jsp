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
			
			$.ajax(
				{
					url : "/product/rest/listProduct/search",
					method : "POST",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					dataType : "json",
					data : JSON.stringify({
						currentPage : 1
					}),
					success : function(JSONData,status){
						console.log(JSONData);
						var list = JSONData.list;
						for(var i=0; i<3; i++){
							
							var temp = list[i];
							console.log(temp.fileName);
							
							$($('.image')[i]).attr('src','/images/uploadFiles/'+temp.fileName);
							$($('.prodName')[i]).text(temp.prodName);
							$($('.price')[i]).text(temp.price+"��");
							$($('.prodDetail')[i]).text(temp.prodDetail);
							$($('.btn-success:contains("����")')[i]).attr('href','/purchase/addPurchaseView?prodNo='+temp.prodNo);
							$($('.btn-default:contains("��ٱ���")')[i]).attr('href','/purchase/addPurchaseCart?prodNo='+temp.prodNo);
						}
					}
				});
			
			$.ajax(
					{
						url : "/product/rest/listProduct/search",
						method : "POST",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						dataType : "json",
						data : JSON.stringify({
							currentPage : 2
						}),
						success : function(JSONData,status){
							console.log(JSONData);
							var list = JSONData.list;
							for(var i=3; i<6; i++){
								
								var temp = list[i-3];
								console.log(temp.fileName);
								
								$($('.image')[i]).attr('src','/images/uploadFiles/'+temp.fileName);
								$($('.prodName')[i]).text(temp.prodName);
								$($('.price')[i]).text(temp.price+"��");
								$($('.prodDetail')[i]).text(temp.prodDetail);
								$($('.btn-success:contains("����")')[i]).attr('href','/purchase/addPurchaseView?prodNo='+temp.prodNo);
								$($('.btn-default:contains("��ٱ���")')[i]).attr('href','/purchase/addPurchaseCart?prodNo='+temp.prodNo);
							}
						}
			});
			
			$('input[name="searchKeyword"]').keyup(function(){
				var searchKeyword = $(this).val();
		
				$.ajax(
					{
						url : "/product/rest/productAutoComplete/"+searchKeyword+"/1",
						method : "GET",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						dataType:"json",
						success : function(JSONData,status){
							var availableTags = JSONData;
							console.log(JSONData);
							$(function(){
								$('input[name="searchKeyword"]').autocomplete({
									source: availableTags
								});							
							});
						},
				});
				
			});
			
			$('.searchContainer').css('margin','50px');
			
			$('.search').css('display','flex');
			
			$('.thumbnail-container').css('margin','90px');
			
			$('#loginButton').click(function(){
				var id = $($('.input-group-addon')[0]).next().val();
				var pwd = $('.input-group-addon:contains("PWD")').next().val();
				
				if(id.length == 0){
					alert("���̵� �Է��� �ּ���.");
					return;
				}
				
				if(pwd.length == 0){
					alert("�н����带 �Է��� �ּ���.");
					return;
				}
				
				$('form').attr('method','post').attr('action','/user/login').submit();
			});
		});
		
		var page = 2;
		var isflag = true;
		$(window).scroll(function(e) {
			//console.log($(window).scrollTop());
			//console.log(e);
		    if (isflag && $(window).scrollTop() == $(document).height() - $(window).height()) {
		    	page += 1;
		    	console.log(page)
		    	$.ajax(
						{
							url : "/product/rest/listProduct/search",
							method : "POST",
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							dataType : "json",
							data : JSON.stringify({
								currentPage : page
							}),
							success : function(JSONData,status){
								console.log('JSONData'+JSONData);

								var str = "";								
								var list = JSONData.list;
								for(var i=0; i<3; i++){
									
									var temp = list[i];
									console.log(temp);
									if(list[i] == undefined){
										console.log('����');
										isflag = false;
										break;
									}
									var stringHtml = 		
										'<div class="col-sm-6 col-md-4">'
								    	+'<div class="thumbnail">'
								    	+'<img class="image" src="/images/uploadFiles/'+temp.fileName+'" border="0px" width="240px" height="180px">'
								      	+'<div class="caption">'
								        +'<h3 class="prodName">'+temp.prodName+'</h3>'
								        +'<h4 class="price">'+temp.price+'</h4>'
								        +'<p class="prodDetail">'+temp.prodDetail+'</p>'
								        +'<p><a href="/purchase/addPurchaseView?prodNo='+temp.prodNo+'" class="btn btn-success" role="button">����</a> <a href="/purchase/addPurchaseCart?prodNo='+temp.prodNo+'" class="btn btn-default" role="button">��ٱ���</a></p>'
								      	+'</div></div></div>';
								   	str += stringHtml;	
								   	
								   	
								}
								
								$('form').append('<div class="container-fluid" style="margin: 90px;"><div class="row"><div class="col-md-2"></div><div class="col-md-8"><div class="row">'
								+ str + '</div></div><div class="col-md-2"></div></div></div>');		
							}
					});
		    	}
		    
		});
		
		$(function(){
			$('a:contains("ȸ������")').click(function(){
				console.log('����');
				$('form').attr('method','get').attr('action','/user/addUser').submit();
			});
			
			$('.btn-default:contains("��ٱ���")').click(function(){
				var href = $(this).attr('href');
				console.log(href);
				
				
				if(${empty user.role}){
					alert('�α����� ���ּ���');
					$(this).attr('href',"/user/loginView.jsp");
				}else{
					if(confirm('��ǰ�� �����ϴ�. ��ٱ��Ϸ� �̵��Ͻðڽ��ϱ�?') == true){
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
<form>
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
					<li><a>�ֱ� �� ��ǰ</a></li>
				</ul>
				
				<ul class="nav navbar-nav navbar-right">

				<c:if test="${empty user.role }">
					<li><a>ȸ������</a></li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<span>�α���</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li class="dropdown-header">�α���</li>
							<li>
								<div class="input-group input-group-sm">
								  <span class="input-group-addon" id="sizing-addon3">I&emsp;&nbsp;D</span>
								  <input type="text" class="form-control" name="userId" placeholder="id" aria-describedby="sizing-addon3">
								</div>
							</li>
							<li>
								<div class="input-group input-group-sm">
								  <span class="input-group-addon" id="sizing-addon3">PWD</span>
								  <input type="password" class="form-control" name="password" placeholder="password" aria-describedby="sizing-addon3">
								</div>
							</li>
							<li>	
								<button type="button" id="loginButton" class="btn btn-success btn-xs btn-block">login</button>
							</li>
							<li>
								<img id="kakao-png" src="/images/RestApi/Kakao/kakaolink_btn_small.png"/>
							</li>
						</ul>
					</li>
				</c:if>
					
				<c:if test="${!empty user.role && user.role eq 'admin' }">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<span>${user.userName}��</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li class="dropdown-header">�����</li>
							<li><a>����� ����</a></li>
							<li class="divider"></li>
							<li class="dropdown-header">�Ǹ�</li>
							<li><a>��ǰ ����</a></li>
							<li><a>��� ����</a></li>				
						</ul>
					</li>
					<li>
						<a href="/purchase/findCartList">
							<span class="glyphicon glyphicon-shopping-cart"></span>
							<span>��ٱ���</span>
						</a>
					</li>
					<li>
						<a href="/user/logout">�α׾ƿ�</a>
					</li>					
					
				</c:if>
				<c:if test="${!empty user.role && user.role eq 'user' }">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							<span>${user.userName}��</span>
							<span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li class="dropdown-header">����</li>
							<li><a href="">����������</a></li>
							<li><a href="">���ų�����ȸ</a></li>		
						</ul>
					</li>
					<li>
						<a href="/purchase/findCartList">
							<span class="glyphicon glyphicon-shopping-cart"></span>
							<span>��ٱ���</span>
						</a>
					</li>
					<li>
						<a href="/user/logout">�α׾ƿ�</a>
					</li>				
					
				</c:if>
				</ul>
			</div>
		</div>
	</div>
	
	<div class="container-fluid searchContainer">
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<div class="form-group form-group-lg search">
					<input class="form-control" type="text" id="formGroupInputLarge" name="searchKeyword" placeholder="SearchKeyword...">
				    <button type="button" class="btn btn-default">
  						<span class="glyphicon glyphicon-search"></span>
					</button>
				</div>
			</div>
			<div class="col-md-3"></div>
		</div>
	</div>
	
	<div class="container-fluid thumbnail-container">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<div class="row">
				<c:forEach begin="0" end="2" step="1">
				  <div class="col-sm-6 col-md-4">
				    <div class="thumbnail">
				      <img class="image" src="" border="0px" width="240px" height="240px">
				      <div class="caption">
				        <h3 class="prodName"></h3>
				        <h4 class="price"></h4>
				        <p class="prodDetail"></p>
				        <p>
				        	<a href="" class="btn btn-success" role="button">����</a>
				         	<a href="" class="btn btn-default" role="button">��ٱ���</a>
				         </p>
				      </div>
				    </div>
				  </div>
				 </c:forEach>
				</div>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
	
	<div class="container-fluid thumbnail-container">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<div class="row">
				<c:forEach begin="0" end="2" step="1">
				  <div class="col-sm-6 col-md-4">
				    <div class="thumbnail">
				      <img class="image" src="" border="0px" width="240px" height="240px">
				      <div class="caption">
				        <h3 class="prodName"></h3>
				        <h4 class="price"></h4>
				        <p class="prodDetail"></p>
				        <p>
				        	<a href="" class="btn btn-success" role="button">����</a> 
				        	<a href="" class="btn btn-default" role="button">��ٱ���</a>
				        </p>
				      </div>
				    </div>
				  </div>
				 </c:forEach>
				</div>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
	
	<!-- <div class="container-fluid thumbnail-container">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<div class="row">
					<div id="enters"></div>					
				</div>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>-->
	
</form>
</body>
</html>