<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<script type="text/javascript">
		$(function(){
			
			$('span:contains("로그인")').on('click',function(){
				
				$('#loginModal').on('show.bs.modal');
					
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
						
					$('#loginForm').attr('method','post').attr('action','/user/login').submit();
					
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
			
			$('span:contains("회원가입")').on('click',function(){
				$('addModal').on('show.bs.modal');
			});
		});
		
		$(function(){
			
			$('a[role="button"]:contains("장바구니")').click(function(){
				
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
		
		$(function(){
			$('a:contains("내정보보기")').click(function(){
				$(this).attr("href","/user/getUser?userId=${user.userId}");
			});
			
			$('a:contains("구매내역조회")').click(function(){
				$(this).attr('href',"/purchase/listPurchase");
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
									    <input type="text" class="form-control" name="userId" placeholder="Id">
									  </div>
									  <div class="form-group">
									    <label>Password</label>
									    <input type="password" class="form-control" name="password" placeholder="Password">
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
					<form>		
			          <div class="my-3">
			            <div class="col-12">
			              <label for="userId" class="form-label">아이디</label>
			              <div class="input-group has-validation">
			                <input type="text" class="form-control" name="userId">
			              </div>
			            </div>
			
			            <div class="col-12">
			              <label for="password" class="form-label">비밀번호<span class="text-muted"></span></label>
			              <div class="input-group has-validation">
			             	 <input type="password" class="form-control" name="password">
			              </div>
			            </div>
			
			            <div class="col-12">
			              <label for="password2" class="form-label">비밀번호 확인</label>
			            <div class="input-group has-validation">
			              <input type="text" class="form-control" name="password2" value="${ empty user.addr || user.addr eq 'null' ? '' : user.addr }">
			            </div>
			            </div>
			            
			            <div class="col-12">
			              <label for="userName" class="form-label">이름</label>
			            <div class="input-group has-validation">
			              <input type="text" class="form-control" name="userName" value="">
			            </div>
			            </div>
				        <div class="col-12">
				          <label for="addr" class="form-label">주소</label>
				          <div class="input-group has-validation">
				          	<p><input type="text" class="form-control" name="addr" value=""></p>
				          </div>
				        </div>
				        <div class="col-12">
				          <div class="row">		        
				          <label for="ssn" class="form-label">휴대전화번호</label>
				          <select name="phone1" class="ct_input_g" style="width:50px; height:25px"
									onChange="document.detailForm.phone2.focus();">
								<option value="010" >010</option>
								<option value="011" >011</option>
								<option value="016" >016</option>
								<option value="018" >018</option>
								<option value="019" >019</option>
							</select>
				          	<p><input type="text" class="form-control" name="phone2" value=""></p>
		
				          	<p><input type="text" class="form-control" name="phone3" value=""></p>
		
				          	<input type="hidden" name="phone" class="ct_input_g"  />
				        </div>
				        </div>
				        <div class="col-12">
				          <label for="ssn" class="form-label">주민번호(-제외, 13자리 입력)</label>
				          <div class="input-group has-validation">
				          	<p><input type="text" class="form-control" name="ssn" value=""></p>
				          </div>
				        </div>
				        <div class="col-12">
				          <label for="ssn" class="form-label">주민번호(-제외, 13자리 입력)</label>
				          <div class="input-group has-validation">
				          	<p><input type="text" class="form-control" name="ssn" value=""></p>
				          </div>
				        </div>
			          </div>
			
			          <hr class="my-4">
					</form>	
				</div>
			</div>
		</div>
	</div>