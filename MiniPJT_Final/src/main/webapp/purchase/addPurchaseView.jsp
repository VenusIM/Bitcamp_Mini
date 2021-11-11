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
	
		$('button:contains("�����ϱ�")').on("click",function(){
	
			if($('input[name="receiverName"]').val() == ""){
				alert("������ �Է��ϼ���.");
				return;
			}
			
			if($('input[name="receiverPhone"]').val() == ""){
				alert("����ó�� �Է��ϼ���.");
				return;
			}
			
			if($('input[name="divyAddr"]').val() == ""){
				alert("�ּҸ� �Է��ϼ���.");
				return;
			}
			
			if($('#total').val() == 0){
				console.log($('#total').val());
				alert("��ǰ�� 0�� �̻� �����ϼž� �մϴ�.");
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
					order_id: ${product.prodNo}, //���� �ֹ���ȣ��, �����Ͻ� ���� �����ּž� �մϴ�.
					params: {callback1: '�״�� �ݹ���� ���� 1', callback2: '�״�� �ݹ���� ���� 2', customvar1234: '������ �������'},
					
					extra: {
						theme: 'red', // [ red, purple(�⺻), custom ]
						custom_background: '#00a086', // [ theme�� custom �� �� background ���� ���� ���� ]
						custom_font_color: '#ffffff' // [ theme�� custom �� �� font color ���� ���� ���� ]
					}
				}).error(function (data) {
					//���� ����� ������ �߻��ϸ� ����˴ϴ�.
					console.log(data);
				}).cancel(function (data) {
					//������ ��ҵǸ� ����˴ϴ�.
					console.log(data);
				}).ready(function (data) {
					// ������� �Ա� ���¹�ȣ�� �߱޵Ǹ� ȣ��Ǵ� �Լ��Դϴ�.
					console.log(data);
					$("#addP").attr("method","post").attr("action","/purchase/addPurchase").submit();
				}).confirm(function (data) {
					//������ ����Ǳ� ���� ����Ǹ�, �ַ� ��� Ȯ���ϴ� ������ ���ϴ�.
					//���� - ī�� ��������� ��� �� �κ��� ������� �ʽ��ϴ�.
					console.log(data);
					var enable = true; // ��� ���� ���� ���� Ȥ�� �ٸ� ó��
					if (enable) {
						BootPay.transactionConfirm(data); // ������ ������ ���� ó���� �Ѵ�.
					} else {
						BootPay.removePaymentWindow(); // ������ ���� ������ ���� â�� �ݰ� ������ �������� �ʴ´�.
					}
				}).close(function (data) {
				    // ����â�� ������ ����˴ϴ�. (����,����,��ҿ� ������� ��� �����)
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
			 $('#price').text('��ǰ����: '+${product.price}*number+' ��');
			 $('#priceTotal').text('�Ѿ� : '+(${product.price} * number + 3000)+ ' ��');
			 $('#priceTotal').next().text(${product.price} * number + 3000);
		});
		
		$('.btn-default:contains("��ٱ���")').attr('href','/purchase/addPurchaseCart?prodNo='+${product.prodNo});
		
		$("#datepicker").on("click",function(){			
			$("#datepicker").datepicker({
				minDate: "+1D", 
				maxDate: "+1M +10D",
				dateFormat : "yy/mm/dd"
			});
		});
		
		$(document).on('click','#cart',function(){
			
				if(confirm('��ǰ�� �����ϴ�. ��ٱ��Ϸ� �̵��Ͻðڽ��ϱ�?') == true){
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
	      <h2>���� ������</h2>
	      <p class="lead">������ �Է��� �ּ���.</p>
	    </div>
	
	    <div class="row g-5">
	      <div class="col-md-5 col-lg-4 order-md-last">
	        <h4 class="d-flex justify-content-between align-items-center mb-3">
	          <span class="text-primary">��ǰ ����</span>
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
	            	<strong id="price">��ǰ����: 0 ��</strong>
	            </c:if>
	            <c:if test="${product.price < 30000 }">
	            	<strong id="price">��ǰ����: 0��</strong></br>
	            	<strong>��ۺ� : &nbsp3000</strong></br>
	            	<span id="priceTotal" style="color: red; font-weight: bolder;">�Ѿ� : 3000 ��</span>
	            	<span hidden=""></span>
	            </c:if>
	          </li>
	          <li class="list-group-item d-flex justify-content-between">
	          	<hr class="my-4">
				<label for="address" class="form-label">���ż���</label>
				<div class="col-12">
					<input type="button" class="btn btn-default" value='-'>
					<input type="text" class="text-center" id='total' name="purchaseQuantity" value="0" style = "width:30px; height: 30px; border-style: hidden; font-size: 15px"  readonly="readonly">
					<input type="button" class="btn btn-default" value='+'>
				</div>
	          </li>
	         </ul>
	
	        <form id="cart" class="card p-2">
	          <div class="input-group">
	            <a href="" class="btn btn-default" role="button">��ٱ���</a>
	          </div>
	        </form>
	      </div>
	      <div class="col-md-7 col-lg-8">
	        <form class="needs-validation" id="addP">
	          <div class="my-3">
				<hr class="my-4">
	            <div class="col-12">
	              <label for="username" class="form-label">�����ڼ���</label>
	              <div class="input-group has-validation">
	                <input type="text" class="form-control tooltip_event" title="������ �Է��� �ּ���." name="receiverName" value="${user.userId}" >
	              </div>
	            </div>
	
	            <div class="col-12">
	              <label for="phone" class="form-label">�����ڿ���ó<span class="text-muted"></span></label>
	              <div class="input-group has-validation">
	             	 <input type="text" class="form-control tooltip_event" title="����ó�� �Է��� �ּ���." name="receiverPhone" value="${ empty user.phone ? '' : user.phone  }">
	              </div>
	            </div>
	
	            <div class="col-12">
	              <label for="address" class="form-label">�������ּ�</label>
	              <input type="text" class="form-control" name="divyAddr" value="${ empty user.addr || user.addr eq 'null' ? '' : user.addr }">
	            </div>
	            
	            <div class="col-12">
	              <label for="address" class="form-label">���ſ�û����(����)</label>
	              <input type="text" class="form-control" name="divyRequest" value="">
	            </div>
		        <div class="col-12">
		          <label for="address" class="form-label">��������(����)</label>
		          <div class="input-group has-validation">
		          	<p><input type="text" id="datepicker" class="form-control" name="divyDate" value="" readonly="readonly"></p>
		          </div>
		        </div>
	          </div>
	
	          
				<hr class="my-4">
				<c:if test="${product.prodTotal eq 0}">
					<pre style="color: red">��ǰ ��� ��� ���� �Ǿ����ϴ�.</pre>
				</c:if>
				<c:if test="${product.prodTotal ne 0}">
					<pre style="color: red">�� ${product.prodTotal}�� ���ҽ��ϴ�.</pre>
				</c:if>
	          <hr class="my-4">
	
	          <h4 class="mb-3">���� ���</h4>
	
	          <div class="my-3">
	            <div class="form-check">
	              <input id="credit" name="paymentOption" type="radio" value="1" class="form-check-input1" checked required>
	              <label class="form-check-label" for="credit">�ſ�ī��</label>
	            </div>
	            <div class="form-check">
	              <input id="debit" name="paymentOption" type="radio" value="2" class="form-check-input1" required>
	              <label class="form-check-label" for="debit">����</label>
	            </div>
	          </div>
	          <hr class="my-4">
				
				<h4 class="mb-3">���� ���</h4>
	
	          <div class="my-3">
	            <div class="form-check">
	              <input id="take" name="tranOption" type="radio" class="form-check-input2" checked required>
	              <label class="form-check-label" for="take">�湮����</label>
	            </div>
	            <div class="form-check">
	              <input id="give" name="tranOption" type="radio" class="form-check-input2" required>
	              <label class="form-check-label" for="give">��۹ޱ�</label>
	            </div>
	            <div class="_1rGSKv6aq_" style="margin-top: 12px;">
	            <div class="bd_3Uotb bd_C8Tz1">
		            <span class="bd_ChMMo">�ù��� </span>
		            <span class="bd_ChMMo">
			            <span class="bd_3uare">3,000 </span>��
			            <span class="bd_2XJf1">(�ֹ��� ����)</span>
		            </span>
	            </div>
	            <p class="bd_1g_zz" style="margin-top: 3px;">30,000�� �̻� ���� �� ���� / ���� �߰� 3,000��, ���� �� �������� �߰� 4,000��</p></div>
	          </div>
				
	          <hr class="my-4">
	
	          <button class="w-100 btn btn-default btn-lg" type="button">�����ϱ�</button>
			<input type="hidden" name="prodNo" value="${product.prodNo}">
	        </form>
	      </div>
	    </div>
	</div>
  </body>
</html>

</body>
</html>