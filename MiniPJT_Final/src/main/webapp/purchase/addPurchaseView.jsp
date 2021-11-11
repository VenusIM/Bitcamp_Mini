<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<title>Insert title here</title>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
	<script src="https://cdn.bootpay.co.kr/js/bootpay-3.3.2.min.js" type="application/javascript"></script>
	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
	<script type="text/javascript">
	
$(function(){
		
	$('input[name="receiverName"]').tooltip({
		position: {
			        my: "left top",
			        at: "right+5 top-5",
			        collision: "none"
      	}
	});
	
	$('input[name="receiverPhone"]').tooltip({
		position: {
	        my: "left top",
	        at: "right+5 top-5",
	        collision: "none"
		}
	});
	
		$('button:contains("구매하기")').on("click",function(){
	
			if($('input[name="receiverName"]').val() == ""){
				alert("성함을 입력하세요.");
				return;
			}
			
			if($('input[name="receiverPhone"]').val() == ""){
				alert("연락처를 입력하세요.");
				return;
			}
			
			if($('input[name="divyAddr"]').val() == ""){
				alert("주소를 입력하세요.");
				return;
			}
			
			if($('#total').val() == 0){
				console.log($('#total').val());
				alert("상품은 0개 이상 구매하셔야 합니다.");
				return;
			}
			
			if($("#credit").is(":checked") == true){
				
				BootPay.request({
					price: $('#priceTotal').next().text(),	
					application_id: "618a4bac7b5ba4b3a352ae77",
					name: '${product.prodName}',
					show_agree_window: 1,
					items: [
						{
							item_name: '${product.prodName}',
							qty: $('#total').val(), 
							unique: '123',
							price: $('#priceTotal').next().text()
						}
					],
					user_info: {
						username: '${user.userName}'
					},
					order_id: ${product.prodNo}, //고유 주문번호로, 생성하신 값을 보내주셔야 합니다.
					params: {callback1: '그대로 콜백받을 변수 1', callback2: '그대로 콜백받을 변수 2', customvar1234: '변수명도 마음대로'},
					
					extra: {
						theme: 'red', // [ red, purple(기본), custom ]
						custom_background: '#00a086', // [ theme가 custom 일 때 background 색상 지정 가능 ]
						custom_font_color: '#ffffff' // [ theme가 custom 일 때 font color 색상 지정 가능 ]
					}
				}).error(function (data) {
					//결제 진행시 에러가 발생하면 수행됩니다.
					console.log(data);
				}).cancel(function (data) {
					//결제가 취소되면 수행됩니다.
					console.log(data);
				}).ready(function (data) {
					// 가상계좌 입금 계좌번호가 발급되면 호출되는 함수입니다.
					console.log(data);
					$("#addP").attr("method","post").attr("action","/purchase/addPurchase").submit();
				}).confirm(function (data) {
					//결제가 실행되기 전에 수행되며, 주로 재고를 확인하는 로직이 들어갑니다.
					//주의 - 카드 수기결제일 경우 이 부분이 실행되지 않습니다.
					console.log(data);
					var enable = true; // 재고 수량 관리 로직 혹은 다른 처리
					if (enable) {
						BootPay.transactionConfirm(data); // 조건이 맞으면 승인 처리를 한다.
					} else {
						BootPay.removePaymentWindow(); // 조건이 맞지 않으면 결제 창을 닫고 결제를 승인하지 않는다.
					}
				}).close(function (data) {
				    // 결제창이 닫힐때 수행됩니다. (성공,실패,취소에 상관없이 모두 수행됨)
				    console.log(data);
				}).done(function (data) {
					
					console.log(data);
				});
			}else{
				$("#addP").attr("method","post").attr("action","/purchase/addPurchase").submit();
			}
		});
	
		$('input:button').click(function(){
			
			var type = $(this).val();
			console.log(type);
			var number =  $('#total').val();
			console.log(number);
			 if(type === '+') {
				number = parseInt(number) + 1;
				if(number >= parseInt(${product.prodTotal}) ){
					number = parseInt(${product.prodTotal})
				}
			}else if(type === '-')  {
				number = parseInt(number) - 1;
				if(number<=0)
				  	number = 0;
				}
			
			 $('#total').val(number);
			 $('#price').text('상품가격: '+${product.price}*number+' 원');
			 $('#priceTotal').text('총액 : '+(${product.price} * number + 3000)+ ' 원');
			 $('#priceTotal').next().text(${product.price} * number + 3000);
		});
		
		$('.btn-default:contains("장바구니")').attr('href','/purchase/addPurchaseCart?prodNo='+${product.prodNo});
		
		$("#datepicker").on("click",function(){			
			$("#datepicker").datepicker({
				minDate: "+1D", 
				maxDate: "+1M +10D",
				dateFormat : "yy/mm/dd"
			});
		});
		
		$(document).on('click','#cart',function(){
			
				if(confirm('상품이 담겼습니다. 장바구니로 이동하시겠습니까?') == true){
					$(this).attr('href','/purchase/listCart');

				}else{
					$(this).attr('href','/index.jsp');
				}					
			
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
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="container">
	
	    <div class="py-5 text-center">
	      <h2>구매 페이지</h2>
	      <p class="lead">정보를 입력해 주세요.</p>
	    </div>
	
	    <div class="row g-5">
	      <div class="col-md-5 col-lg-4 order-md-last">
	        <h4 class="d-flex justify-content-between align-items-center mb-3">
	          <span class="text-primary">상품 정보</span>
	          <span class="badge bg-primary rounded-pill">1</span>
	        </h4>
	        <ul class="list-group mb-3">
	        	<li class="list-group-item d-flex justify-content-between bg-light">
	            <div class="text-success">
	              <h6 class="my-0">Product No</h6>
	              <small>NO.${product.prodNo }</small>
	            </div>
	            <span class="text-success"></span>
	          </li>
	          <li class="list-group-item d-flex justify-content-between lh-sm">
	            <div>
	              <h6 class="my-0">Product name</h6>
	              <small class="text-muted">${product.prodName}</small>
	            </div>
	            <span class="text-muted"></span>
	          </li>
	          <li class="list-group-item d-flex justify-content-between lh-sm">
	            <div>
	              <h6 class="my-0">Product Detail</h6>
	              <small class="text-muted">${product.prodDetail }</small>
	            </div>
	            <span class="text-muted"></span>
	          </li>
	          <li class="list-group-item d-flex justify-content-between lh-sm">
	            <div>
	              <h6 class="my-0">Product Image</h6>
	              <small class="text-muted">
	              	<img src="../images/uploadFiles/${product.fileName}" width="300px" height="300px">
	              </small>
	            </div>
	            <span class="text-muted"></span>
	          </li>
	          <li class="list-group-item d-flex justify-content-between">
	            <span>Price (Kor)</span></br>
	            <c:if test="${product.price >= 30000 }">
	            	<strong id="price">상품가격: 0 원</strong>
	            </c:if>
	            <c:if test="${product.price < 30000 }">
	            	<strong id="price">상품가격: 0원</strong></br>
	            	<strong>배송비 : &nbsp3000</strong></br>
	            	<span id="priceTotal" style="color: red; font-weight: bolder;">총액 : 3000 원</span>
	            	<span hidden=""></span>
	            </c:if>
	          </li>
	          <li class="list-group-item d-flex justify-content-between">
	          	<hr class="my-4">
				<label for="address" class="form-label">구매수량</label>
				<div class="col-12">
					<input type="button" class="btn btn-default" value='-'>
					<input type="text" class="text-center" id='total' name="purchaseQuantity" value="0" style = "width:30px; height: 30px; border-style: hidden; font-size: 15px"  readonly="readonly">
					<input type="button" class="btn btn-default" value='+'>
				</div>
	          </li>
	         </ul>
	
	        <form id="cart" class="card p-2">
	          <div class="input-group">
	            <a href="" class="btn btn-default" role="button">장바구니</a>
	          </div>
	        </form>
	      </div>
	      <div class="col-md-7 col-lg-8">
	        <form class="needs-validation" id="addP">
	          <div class="my-3">
				<hr class="my-4">
	            <div class="col-12">
	              <label for="username" class="form-label">구매자성함</label>
	              <div class="input-group has-validation">
	                <input type="text" class="form-control tooltip_event" title="성함을 입력해 주세요." name="receiverName" value="${user.userId}" >
	              </div>
	            </div>
	
	            <div class="col-12">
	              <label for="phone" class="form-label">구매자연락처<span class="text-muted"></span></label>
	              <div class="input-group has-validation">
	             	 <input type="text" class="form-control tooltip_event" title="연락처를 입력해 주세요." name="receiverPhone" value="${ empty user.phone ? '' : user.phone  }">
	              </div>
	            </div>
	
	            <div class="col-12">
	              <label for="address" class="form-label">구매자주소</label>
	              <input type="text" class="form-control" name="divyAddr" value="${ empty user.addr || user.addr eq 'null' ? '' : user.addr }">
	            </div>
	            
	            <div class="col-12">
	              <label for="address" class="form-label">구매요청사항(선택)</label>
	              <input type="text" class="form-control" name="divyRequest" value="">
	            </div>
		        <div class="col-12">
		          <label for="address" class="form-label">배송희망일(선택)</label>
		          <div class="input-group has-validation">
		          	<p><input type="text" id="datepicker" class="form-control" name="divyDate" value="" readonly="readonly"></p>
		          </div>
		        </div>
	          </div>
	
	          
				<hr class="my-4">
				<c:if test="${product.prodTotal eq 0}">
					<pre style="color: red">상품 재고가 모두 소진 되었습니다.</pre>
				</c:if>
				<c:if test="${product.prodTotal ne 0}">
					<pre style="color: red">총 ${product.prodTotal}개 남았습니다.</pre>
				</c:if>
	          <hr class="my-4">
	
	          <h4 class="mb-3">결제 방식</h4>
	
	          <div class="my-3">
	            <div class="form-check">
	              <input id="credit" name="paymentOption" type="radio" value="1" class="form-check-input1" checked required>
	              <label class="form-check-label" for="credit">신용카드</label>
	            </div>
	            <div class="form-check">
	              <input id="debit" name="paymentOption" type="radio" value="2" class="form-check-input1" required>
	              <label class="form-check-label" for="debit">현금</label>
	            </div>
	          </div>
	          <hr class="my-4">
				
				<h4 class="mb-3">수령 방식</h4>
	
	          <div class="my-3">
	            <div class="form-check">
	              <input id="take" name="tranOption" type="radio" class="form-check-input2" checked required>
	              <label class="form-check-label" for="take">방문수령</label>
	            </div>
	            <div class="form-check">
	              <input id="give" name="tranOption" type="radio" class="form-check-input2" required>
	              <label class="form-check-label" for="give">배송받기</label>
	            </div>
	            <div class="_1rGSKv6aq_" style="margin-top: 12px;">
	            <div class="bd_3Uotb bd_C8Tz1">
		            <span class="bd_ChMMo">택배배송 </span>
		            <span class="bd_ChMMo">
			            <span class="bd_3uare">3,000 </span>원
			            <span class="bd_2XJf1">(주문시 결제)</span>
		            </span>
	            </div>
	            <p class="bd_1g_zz" style="margin-top: 3px;">30,000원 이상 구매 시 무료 / 제주 추가 3,000원, 제주 외 도서지역 추가 4,000원</p></div>
	          </div>
				
	          <hr class="my-4">
	
	          <button class="w-100 btn btn-default btn-lg" type="button">구매하기</button>
			<input type="hidden" name="prodNo" value="${product.prodNo}">
	        </form>
	      </div>
	    </div>
	</div>
  </body>
</html>

</body>
</html>