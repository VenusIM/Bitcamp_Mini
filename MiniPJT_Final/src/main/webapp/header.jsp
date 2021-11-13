<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


	<script type="text/javascript">
		$(function(){
			
			$('span:contains("로그인")').on('click',function(){
				
				$('#loginModal').on('show.bs.modal');
					
				$('button:contains("LOGIN")').click(function(){
						
					var id = $('#modalId').val();
					var pwd = $('#modalPwd').val();
						
					if(id.length == 0){
						alert("아이디를 입력해 주세요.");
						return;
					}
						
					if(pwd.length == 0){
						alert("패스워드를 입력해 주세요.");
						return;
					}
						
					$('#loginForm').attr('method','post').attr('action','/user/login').submit();
					
				});
				
				
				$("#kakao-png").on("click",function(){
					Kakao.init('b3bed223fd618abc07f64c2103ca9659');
					console.log(Kakao.isInitialized());
					Kakao.Auth.login({
					    success: function(authObj) {
							console.log(JSON.stringify(authObj))
						    $(self.location).attr("href","/user/login/pass");
					    },
						fail: function(err) {
							console.log(JSON.stringify(err))
						},
					})
				});
				
				$("#logout").on("click",function(){
					$.Ajax(
						{
							url : "/v1/user/logout",
							method : "post",
							Host: "kapi.kakao.com",
							Authorization: "Bearer {"+auth+"}",
							success : function(authObj){
								console.log(authObj);
							} 
						}		
					)
				});
				
			});
			
			$('span:contains("회원가입")').on('click',function(){
				$('addModal').on('show.bs.modal');
			});
		});
		
		
		$(function(){
			$('a:contains("내정보보기")').click(function(){
				$(this).attr("href","/user/getUser?userId=${user.userId}");
			});
			
			$('a:contains("구매내역조회")').click(function(){
				$(this).attr('href',"/purchase/listPurchase");
			});
			
			$("a:contains('사용자 관리')").on("click" , function() {
		 		$(this).attr("href","/user/listUser");
			});
			
			$( "a:contains('상품 등록')" ).on("click" , function() {
		 		$(this).attr("href","/product/addProductView.jsp");
			});
			$("a:contains('상품 관리')" ).on("click" , function() {
		 		$(this).attr("href","/product/listProduct?menu=search");
			});
			
			$("a:contains('배송 관리')").on("click" , function() {
		 		$(this).attr("href","/product/listProduct?menu=manage");
			});
			
		});
		
		 $(function() {
				//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$( "#addU" ).on("click" , function() {
					fncAddUser();
				});
			});	
			
			
			//============= "취소"  Event 처리 및  연결 =============
			$(function() {
				//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$("a[href='#' ]").on("click" , function() {
					$("form")[0].reset();
				});
			});	
		
			
			function fncAddUser() {
				
				var id=$("input[name='userId']").val();
				var pw=$("input[name='password']").val();
				var pw_confirm=$("input[name='password2']").val();
				var name=$("input[name='userName']").val();
				
				
				if(id == null || id.length <1){
					alert("아이디는 반드시 입력하셔야 합니다.");
					return;
				}
				if(pw == null || pw.length <1){
					alert("패스워드는  반드시 입력하셔야 합니다.");
					return;
				}
				if(pw_confirm == null || pw_confirm.length <1){
					alert("패스워드 확인은  반드시 입력하셔야 합니다.");
					return;
				}
				if(name == null || name.length <1){
					alert("이름은  반드시 입력하셔야 합니다.");
					return;
				}
				
				if( pw != pw_confirm ) {				
					alert("비밀번호 확인이 일치하지 않습니다.");
					$("input:text[name='password2']").focus();
					return;
				}
					
				var value = "";	
				if( $("input:text[name='phone2']").val() != ""  &&  $("input:text[name='phone3']").val() != "") {
					var value = $("option:selected").val() + "-" 
										+ $("input[name='phone2']").val() + "-" 
										+ $("input[name='phone3']").val();
				}

				$("input:hidden[name='phone']").val( value );
				
				$("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
			}
			

			//==>"이메일" 유효성Check  Event 처리 및 연결
			 $(function() {
				 
				 $("input[name='email']").on("change" , function() {
					
					 var email=$("input[name='email']").val();
				    
					 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
				    	alert("이메일 형식이 아닙니다.");
				     }
				});
				 
			});	
			
			
		   ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		   //==> 주민번호 유효성 check 는 이해정도로....
			function checkSsn() {
				var ssn1, ssn2; 
				var nByear, nTyear; 
				var today; 
		
				ssn = document.detailForm.ssn.value;
				// 유효한 주민번호 형식인 경우만 나이 계산 진행, PortalJuminCheck 함수는 CommonScript.js 의 공통 주민번호 체크 함수임 
				if(!PortalJuminCheck(ssn)) {
					alert("잘못된 주민번호입니다.");
					return false;
				}
			}
		
			function PortalJuminCheck(fieldValue){
			    var pattern = /^([0-9]{6})-?([0-9]{7})$/; 
				var num = fieldValue;
			    if (!pattern.test(num)) return false; 
			    num = RegExp.$1 + RegExp.$2;
		
				var sum = 0;
				var last = num.charCodeAt(12) - 0x30;
				var bases = "234567892345";
				for (var i=0; i<12; i++) {
					if (isNaN(num.substring(i,i+1))) return false;
					sum += (num.charCodeAt(i) - 0x30) * (bases.charCodeAt(i) - 0x30);
				}
				var mod = sum % 11;
				return ((11 - mod) % 10 == last) ? true : false;
			}
			 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		$(function(){
			$('#userId').keypress(function(){
				var id = $(this).val();
				$.ajax(
					{
						url : "/user/checkDuplication",
						method : "post",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						dataType : "json",
						data :{
							userId : id
						},
						success : function(JSONData,status){
							if(JSONData.result == true){
								var strVale = "<h5>"+"입력하신 "+id+"는 중복됩니다."+"</h5>"
								$('h4').html(strVale);
							}
							
						}
					}		
				)
			});
		});
		
	</script>

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
					<li><a><span data-toggle="modal" data-target="#addModal">회원가입</span></a></li>
					<li><a><span data-toggle="modal" data-target="#loginModal">로그인</span></a></li>
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
							<li class="dropdown-header">관리자</li>
							<li><a>상품 등록</a></li>
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
						<a id="logout" href="/user/logout">로그아웃</a>
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
							<li><a>내정보보기</a></li>
							<li><a>구매내역조회</a></li>		
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
	<div hidden="" class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">로그인</h4>
				</div>
				<div class="modal-body">
					<form id="loginForm">
									  <div class="form-group">
									    <label>ID</label>
									    <input id="modalId" type="text" class="form-control" name="userId" placeholder="Id">
									  </div>
									  <div class="form-group">
									    <label>Password</label>
									    <input id="modalPwd" type="password" class="form-control" name="password" placeholder="Password">
									  </div>
									  <div class="checkbox">
									    <label>
									      <input type="checkbox"> 자동로그인
									    </label>
									  </div>
									  <button type="button" class="btn btn-default">LOGIN</button>
									   <hr class="my-4">
									<div id="img">
										<div id="img-in">
											<div id="kakao-img">
												<img id="kakao-png" src="/images/RestApi/Kakao/kakao_login_medium_wide.png">
											</div>
										</div>
									</div>	
					</form>	
				</div>
			</div>
		</div>
	</div>
	
	<div hidden="" class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">회원가입</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
		
					  <div class="form-group">
					    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">아 이 디</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="userId" name="userId" placeholder="아이디">
					      <h4></h4>	
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">비밀번호</label>
					    <div class="col-sm-4">
					      <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="password2" class="col-sm-offset-1 col-sm-3 control-label">비밀번호 확인</label>
					    <div class="col-sm-4">
					      <input type="password" class="form-control" id="password2" name="password2" placeholder="비밀번호 확인">
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
					    <div class="col-sm-4">
					      <input type="password" class="form-control" id="userName" name="userName" placeholder="회원이름">
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">주민번호</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="ssn" name="ssn" placeholder="주민번호">
					      <span id="helpBlock" class="help-block">
					      	 <strong class="text-danger">" -  " 제외 13자리입력하세요</strong>
					      </span>
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">주소</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="addr" name="addr" placeholder="주소">
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">휴대전화번호</label>
					     <div class="col-sm-2">
					      <select class="form-control" name="phone1" id="phone1">
							  	<option value="010" >010</option>
								<option value="011" >011</option>
								<option value="016" >016</option>
								<option value="018" >018</option>
								<option value="019" >019</option>
							</select>
					    </div>
					    <div class="col-sm-2">
					      <input type="text" class="form-control" id="phone2" name="phone2" placeholder="번호">
					    </div>
					    <div class="col-sm-2">
					      <input type="text" class="form-control" id="phone3" name="phone3" placeholder="번호">
					    </div>
					    <input type="hidden" name="phone"  />
					  </div>
					  
					   <div class="form-group">
					    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">이메일</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="email" name="email" placeholder="이메일">
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <div class="col-sm-offset-4  col-sm-4 text-center">
					      <button type="button" id="addU" class="btn btn-primary"  >가 &nbsp;입</button>
						  <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
					    </div>
					  </div>
					</form>
				</div>
			</div>
		</div>
	</div>