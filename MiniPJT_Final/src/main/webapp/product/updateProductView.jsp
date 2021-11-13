<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%--<%@page import="com.model2.mvc.service.domain.Product"%>
<% Product product = (Product)request.getAttribute("product"); %> --%>

<html>
<head>
<title>상품수정</title>

<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
	<script type="text/javascript" src="../javascript/calendar.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<!-- <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script> -->
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

	<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script type="text/javascript">

	$(function(){
		
		$("button").on("click",function(){
			$('form').attr('method','post').attr('action','/product/updateProduct').attr('enctype','multipart/form-data').submit();
		});
		
		$('a[role="button"]').click(function(){
			$(window.parent.frames.document.location).attr('href','/index.jsp');
		});
		
		$("#datepicker").datepicker({
			maxDate: "0D",
			dateFormat : "yy-mm-dd"
		});
	});

/*
function fncUpdateProduct(){
	document.detailForm.action='/product/updateProduct';
	document.detailForm.submit();
}
*/


</script>
<style type="text/css">
	body{
		padding: 70px;
	}
</style>

</head>
<body>
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="../header.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header text-center">
	       <h3 class=" text-info">정보 수정</h3>
	       <h5 class="text-muted">상품 정보를 <strong class="text-danger">최신 데이터로 관리</strong>해 주세요.</h5>
	    </div>
	    
	    <!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		<input type="hidden" name='prodNo' value='${product.prodNo}'/>
		  <div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">상 품 명</label>
		    <div class="col-sm-4">
		      <input type="text" name="prodName" class="form-control" maxLength="20" value="${product.prodName }">
		    </div>
		  </div>
		
		  <div class="form-group">
		    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		    <div class="col-sm-4">
		      <input type="text" name="prodDetail" class="form-control" maxLength="10" minLength="6" value="${product.prodDetail }"/>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="password2" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-4">
		    	<input type="text" id="datepicker" name="manuDate" readonly="readonly" class="form-control" value='${product.manuDate}' /> 
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">가격</label>
		    <div class="col-sm-4">
		    	<input type="text" name="price" 	class="form-control" maxLength="7" value = "${product.price }">  
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">상품이미지</label>
		    <div class="col-sm-4">
		      <input type="file" name="fileUpload" class="form-control" maxLength="13"/>
			</div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">상품수량</label>
			<div class="col-sm-4">
				<input	type="text" name="prodTotal" class="form-control"  value="0" maxLength="4" value="${product.prodTotal}"/>
			</div>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary">수 &nbsp;정</button>
			  <a class="btn btn-primary btn" href="#" role="button">취 &nbsp;소</a>
		    </div>
		  </div>
		</form>
 	</div>
</body>

</html>	