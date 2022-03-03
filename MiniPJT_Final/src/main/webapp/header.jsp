<%@ page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<script type="text/javascript">
	$(function() {

		$('span:contains("�α���")')
				.on(
						'click',
						function() {

							$('#loginModal').on('show.bs.modal');

							$('button:contains("LOGIN")').click(
									function() {

										var id = $('#modalId').val();
										var pwd = $('#modalPwd').val();

										if (id.length == 0) {
											alert("���̵� �Է��� �ּ���.");
											return;
										}

										if (pwd.length == 0) {
											alert("�н����带 �Է��� �ּ���.");
											return;
										}

										$('#loginForm').attr('method', 'post')
												.attr('action', '/user/login')
												.submit();

									});

							$("#kakao-png")
									.on(
											"click",
											function() {
												Kakao
														.init('b3bed223fd618abc07f64c2103ca9659');
												console.log(Kakao
														.isInitialized());
												Kakao.Auth
														.login({
															success : function(
																	authObj) {
																Kakao.API
																		.request({
																			url : '/v2/user/me',
																			success : function(
																					result) {
																				console
																						.log(result);
																				$(
																						'#kakaoId')
																						.val(
																								result.kakao_account.profile.nickname);
																				$(
																						'#kakaoName')
																						.val(
																								result.kakao_account.profile.nickname);
																				$(
																						'#kakaoEmail')
																						.val(
																								result.kakao_account.email);
																				$(
																						'#kakaoImage')
																						.val(
																								result.kakao_account.profile.thumbnail_image_url);
																				$(
																						'#addKakao')
																						.attr(
																								'method',
																								'post')
																						.attr(
																								'action',
																								'/user/kakaoUser')
																						.submit();
																			}
																		});

																//$(self.location).attr("href","/user/login/pass");
															},
															fail : function(err) {
																console
																		.log(JSON
																				.stringify(err))
															},
														})
											});

							$("#logout").on("click", function() {
								if (Kakao.Auth.getAccessToken()) {
									Kakao.Auth.logout();
								}
							});

						});

		$('span:contains("ȸ������")').on('click', function() {
			$('addModal').on('show.bs.modal');
		});
	});

	$(function() {
		$('a:contains("����������")').click(function() {
			$(this).attr("href", "/user/getUser?userId=${user.userId}");
		});

		$('a:contains("���ų�����ȸ")').click(function() {
			$(this).attr('href', "/purchase/listPurchase");
		});

		$("a:contains('����� ����')").on("click", function() {
			$(this).attr("href", "/user/listUser");
		});

		$("a:contains('��ǰ ���')").on("click", function() {
			$(this).attr("href", "/product/addProductView.jsp");
		});
		$("a:contains('��ǰ ����')").on("click", function() {
			$(this).attr("href", "/product/listProduct?menu=search");
		});

		$("a:contains('��� ����')").on("click", function() {
			$(this).attr("href", "/product/listProduct?menu=manage");
		});
		
		$("a:contains('�ֱ� �� ��ǰ')").on("click",function(){
			window.open('/history.jsp','popup','top=10, left=10, width=500, height=600, status=no, menubar=no, toolbar=no, resizable=no');
		});

	});

	$(function() {
		$('#userId').keypress(
				function() {
					var id = $(this).val();
					$.ajax({
						url : "/user/checkDuplication",
						method : "post",
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						dataType : "json",
						data : {
							userId : id
						},
						success : function(JSONData, status) {
							if (JSONData.result == true) {
								var strVale = "<h5>" + "�Է��Ͻ� " + id
										+ "�� �ߺ��˴ϴ�." + "</h5>"
								$('h4').html(strVale);
							}

						}
					})
				});
	});

	$(function() {
		$('a:contains("LOCATION")').click(function() {
			$(this).attr("href", "/info.jsp");
		});
	});
</script>


<div class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
		<a class="navbar-brand" href="/"> <span
			class="glyphicon glyphicon-gift"></span> <span> Model2 MVC
				SHOP </span> <span class="glyphicon glyphicon-gift"></span>
		</a>

		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#target">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
		</div>

		<div class="collapse navbar-collapse" id="target">
			<ul class="nav navbar-nav">
				<li><a>LOCATION</a></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown"> <span>CATEGORY</span> <span
						class="caret"></span>
				</a>
					<ul class="dropdown-menu">
						<li><a href="#">1</a></li>
						<li><a href="#">2</a></li>
					</ul></li>
				<li><a>�ֱ� �� ��ǰ</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">

				<c:if test="${empty user.role }">
					<li><a><span data-toggle="modal" data-target="#addModal">ȸ������</span></a></li>
					<li><a><span id="modalLog" data-toggle="modal" data-target="#loginModal">�α���</span></a></li>
				</c:if>
				<c:if test="${!empty user.role && user.role eq 'admin' }">
					<c:if test="${!empty user.userImage}">
						<li>
							<div style="height: 30px; width: 30px; margin-top: 10px">
								<img src="${user.userImage}" height="100%" width="100%">
							</div>
						</li>
					</c:if>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown">
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
						</ul></li>
					<li><a href="/purchase/findCartList"> <span
							class="glyphicon glyphicon-shopping-cart"></span> <span>��ٱ���</span>
					</a></li>
					<li><a id="logout" href="/user/logout">�α׾ƿ�</a></li>

				</c:if>
				<c:if test="${!empty user.role && user.role eq 'user' }">
					<c:if test="${!empty user.userImage}">
						<li>
							<div style="height: 30px; width: 30px; margin-top: 10px">
								<img src="${user.userImage}" height="100%" width="100%">
							</div>
						</li>
					</c:if>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown"> 
						<span>${user.userName}��</span>
						<span class="caret"></span>
					</a>
						<ul class="dropdown-menu">
							<li class="dropdown-header">����</li>
							<li><a>����������</a></li>
							<li><a>���ų�����ȸ</a></li>
						</ul></li>
					<li><a href="/purchase/findCartList"> <span
							class="glyphicon glyphicon-shopping-cart"></span> <span>��ٱ���</span>
					</a></li>
					<li><a href="/user/logout">�α׾ƿ�</a></li>

				</c:if>
			</ul>
		</div>
	</div>
</div>
<div hidden="" class="modal fade" id="loginModal" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">�α���</h4>
			</div>
			<div class="modal-body">
				<form id="loginForm">
					<div class="form-group">
						<label>ID</label> <input id="modalId" type="text"
							class="form-control" name="userId" placeholder="Id">
					</div>
					<div class="form-group">
						<label>Password</label> <input id="modalPwd" type="password"
							class="form-control" name="password" placeholder="Password">
					</div>
					<div class="checkbox">
						<label> <input type="checkbox"> �ڵ��α���
						</label>
					</div>
					<button type="button" class="btn btn-default">LOGIN</button>
					<hr class="my-4">
					<div id="img">
						<div id="img-in">
							<div id="kakao-img">
								<img id="kakao-png"
									src="/images/RestApi/Kakao/kakao_login_medium_wide.png">
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<form id="addKakao">
	<input type="hidden" id="kakaoName" name="userName"> <input
		type="hidden" id="kakaoEmail" name="email"> <input
		type="hidden" id="kakaoUserId" name="userId"> <input
		type="hidden" id="kakaoImage" name="userImage">
</form>