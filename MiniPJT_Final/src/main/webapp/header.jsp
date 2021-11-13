<%@ page contentType="text/html; charset=euc-kr" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


	<script type="text/javascript">
		$(function(){
			
			$('span:contains("�α���")').on('click',function(){
				
				$('#loginModal').on('show.bs.modal');
					
				$('button:contains("LOGIN")').click(function(){
						
					var id = $('#modalId').val();
					var pwd = $('#modalPwd').val();
						
					if(id.length == 0){
						alert("���̵� �Է��� �ּ���.");
						return;
					}
						
					if(pwd.length == 0){
						alert("�н����带 �Է��� �ּ���.");
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
			
			$('span:contains("ȸ������")').on('click',function(){
				$('addModal').on('show.bs.modal');
			});
		});
		
		
		$(function(){
			$('a:contains("����������")').click(function(){
				$(this).attr("href","/user/getUser?userId=${user.userId}");
			});
			
			$('a:contains("���ų�����ȸ")').click(function(){
				$(this).attr('href',"/purchase/listPurchase");
			});
			
			$("a:contains('����� ����')").on("click" , function() {
		 		$(this).attr("href","/user/listUser");
			});
			
			$( "a:contains('��ǰ ���')" ).on("click" , function() {
		 		$(this).attr("href","/product/addProductView.jsp");
			});
			$("a:contains('��ǰ ����')" ).on("click" , function() {
		 		$(this).attr("href","/product/listProduct?menu=search");
			});
			
			$("a:contains('��� ����')").on("click" , function() {
		 		$(this).attr("href","/product/listProduct?menu=manage");
			});
			
		});
		
		 $(function() {
				//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
				$( "#addU" ).on("click" , function() {
					fncAddUser();
				});
			});	
			
			
			//============= "���"  Event ó�� ��  ���� =============
			$(function() {
				//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
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
					alert("���̵�� �ݵ�� �Է��ϼž� �մϴ�.");
					return;
				}
				if(pw == null || pw.length <1){
					alert("�н������  �ݵ�� �Է��ϼž� �մϴ�.");
					return;
				}
				if(pw_confirm == null || pw_confirm.length <1){
					alert("�н����� Ȯ����  �ݵ�� �Է��ϼž� �մϴ�.");
					return;
				}
				if(name == null || name.length <1){
					alert("�̸���  �ݵ�� �Է��ϼž� �մϴ�.");
					return;
				}
				
				if( pw != pw_confirm ) {				
					alert("��й�ȣ Ȯ���� ��ġ���� �ʽ��ϴ�.");
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
			

			//==>"�̸���" ��ȿ��Check  Event ó�� �� ����
			 $(function() {
				 
				 $("input[name='email']").on("change" , function() {
					
					 var email=$("input[name='email']").val();
				    
					 if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
				    	alert("�̸��� ������ �ƴմϴ�.");
				     }
				});
				 
			});	
			
			
		   ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		   //==> �ֹι�ȣ ��ȿ�� check �� ����������....
			function checkSsn() {
				var ssn1, ssn2; 
				var nByear, nTyear; 
				var today; 
		
				ssn = document.detailForm.ssn.value;
				// ��ȿ�� �ֹι�ȣ ������ ��츸 ���� ��� ����, PortalJuminCheck �Լ��� CommonScript.js �� ���� �ֹι�ȣ üũ �Լ��� 
				if(!PortalJuminCheck(ssn)) {
					alert("�߸��� �ֹι�ȣ�Դϴ�.");
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
								var strVale = "<h5>"+"�Է��Ͻ� "+id+"�� �ߺ��˴ϴ�."+"</h5>"
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
					<li><a>�ֱ� �� ��ǰ</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">

				<c:if test="${empty user.role }">
					<li><a><span data-toggle="modal" data-target="#addModal">ȸ������</span></a></li>
					<li><a><span data-toggle="modal" data-target="#loginModal">�α���</span></a></li>
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
							<li class="dropdown-header">������</li>
							<li><a>��ǰ ���</a></li>
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
						<a id="logout" href="/user/logout">�α׾ƿ�</a>
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
							<li><a>����������</a></li>
							<li><a>���ų�����ȸ</a></li>		
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
	<div hidden="" class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">�α���</h4>
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
									      <input type="checkbox"> �ڵ��α���
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
					<h4 class="modal-title" id="myModalLabel">ȸ������</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
		
					  <div class="form-group">
					    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">�� �� ��</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="userId" name="userId" placeholder="���̵�">
					      <h4></h4>	
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">��й�ȣ</label>
					    <div class="col-sm-4">
					      <input type="password" class="form-control" id="password" name="password" placeholder="��й�ȣ">
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="password2" class="col-sm-offset-1 col-sm-3 control-label">��й�ȣ Ȯ��</label>
					    <div class="col-sm-4">
					      <input type="password" class="form-control" id="password2" name="password2" placeholder="��й�ȣ Ȯ��">
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">�̸�</label>
					    <div class="col-sm-4">
					      <input type="password" class="form-control" id="userName" name="userName" placeholder="ȸ���̸�">
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">�ֹι�ȣ</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="ssn" name="ssn" placeholder="�ֹι�ȣ">
					      <span id="helpBlock" class="help-block">
					      	 <strong class="text-danger">" -  " ���� 13�ڸ��Է��ϼ���</strong>
					      </span>
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">�ּ�</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="addr" name="addr" placeholder="�ּ�">
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">�޴���ȭ��ȣ</label>
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
					      <input type="text" class="form-control" id="phone2" name="phone2" placeholder="��ȣ">
					    </div>
					    <div class="col-sm-2">
					      <input type="text" class="form-control" id="phone3" name="phone3" placeholder="��ȣ">
					    </div>
					    <input type="hidden" name="phone"  />
					  </div>
					  
					   <div class="form-group">
					    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">�̸���</label>
					    <div class="col-sm-4">
					      <input type="text" class="form-control" id="email" name="email" placeholder="�̸���">
					    </div>
					  </div>
					  
					  <div class="form-group">
					    <div class="col-sm-offset-4  col-sm-4 text-center">
					      <button type="button" id="addU" class="btn btn-primary"  >�� &nbsp;��</button>
						  <a class="btn btn-primary btn" href="#" role="button">��&nbsp;��</a>
					    </div>
					  </div>
					</form>
				</div>
			</div>
		</div>
	</div>