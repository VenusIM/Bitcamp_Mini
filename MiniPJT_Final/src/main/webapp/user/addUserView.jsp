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

	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
	<script type="text/javascript">
	
$(function(){
		
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
			// 결과 출력
			console.log(number);
			 $('#total').val(number);
		});
		
		$('.btn-default:contains("장바구니")').attr('href','/purchase/addPurchaseCart?prodNo='+${product.prodNo});
		
		$("#datepicker").on("click",function(){			
			$("#datepicker").datepicker({
				minDate: "+1D", 
				maxDate: "+1M +10D",
				dateFormat : "yy/mm/dd"
			});
		});
		
		$("input[name='addr']").click(function(){
				window.open("../juso/jusoPopup.jsp","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
		});
	});
function jusoCallBack(roadFullAddr){
	// 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
	$('input[name="addr"]').val(roadFullAddr);
}
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
	      <h2>회원가입</h2>
	      <p class="lead">정보를 입력해 주세요.</p>
	    </div>
	</div>
	<div class="container-fluid">
	<div class="col-md-4"></div>
	<div class="col-md-6">
	    <div class="row">
	      <div class="col-md-7 col-lg-8">
	        <form class="needs-validation" method="POST" action="/purchase/addPurchase">
	          <div class="my-3">
				<hr class="my-4">
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
	    <div class="col-md-2"></div>
	</div>
  </body>
</html>