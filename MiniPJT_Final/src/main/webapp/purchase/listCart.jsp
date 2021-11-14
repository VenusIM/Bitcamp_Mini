<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
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
		
		$('span:contains("구매")').click(function(){
	        
			var prodNoList = $('.prodNoList:checked');
	        var totalList = $('.totalList');
	        //console.log(prodNoList.parent().next().next().next().children().html());
	        var flag = true;
	        var isActive = false;
	        if(prodNoList.length == 0){
	        	alert("구매하실 상품을 체크해 주세요!!");
	        	flag = false
	        	return;
	        }
	       
	        if(flag){
	        	for(var i=0; i<prodNoList.length; i++){
	        		var value = $(prodNoList[i]).val();
	        		var idValue = "#purchaseQuantity" + value;
	        		var count = $(idValue).val();
	        		
	        		if(count == 0){
	        			alert("상품 수량을 확인하세요!!");
	        			return;
	        		}
	        	}
	        	isActive = true;
	        }
	        
	        if(isActive){
	        	$('form').attr('method','post').attr('action','/purchase/addCartListView').submit();
	        }
	        
	        
	  	  
		});
		
		$('.prodName').click(function(){
			
			$(self.location).attr('href','/product/getProduct?prodNo='+$(this).next().text());
		});
		
		$('input:button').click(function(){
			
			var type = $(this).val();
			var prodNo = $(this).parent().next().text();
			var total = $(this).parent().next().next().text();
			var number =  $('#purchaseQuantity'+prodNo).val();
			
			 if(type === '+') {
				number = parseInt(number) + 1;
				if(number >= total ){
					number = total;
				}
			}else if(type === '-')  {
				number = parseInt(number) - 1;
				if(number<=0)
				  	number = 0;
				}
			// 결과 출력
			console.log(number);
			 $('#purchaseQuantity'+prodNo).val(number);

		});
		
		$('.pageNum').on("click",function(index){
			$('form')[0].reset();
			$('#currentPage').val($(this).text());
			$('form').attr('method','post').attr('action','/product/listProduct').submit();
		});
		
		$('#before').click(function(){
			$('form')[0].reset();
			$('#currentPage').val(${ resultPage.currentPage-1});
			$('form').attr('method','post').attr('action','/product/listProduct').submit();
		});
		
		$('#after').click(function(){
			$('form')[0].reset();
			$('#currentPage').val(${resultPage.endUnitPage+1});
			$('form').attr('method','post').attr('action','/product/listProduct').submit();
		});
		
	});
	
	
</script>

<style>
	body{
		padding-top:70px;
	}
</style>

</head>

<body bgcolor="#ffffff" text="#000000">
	<jsp:include page="/header.jsp"></jsp:include>
<div style="width:100%; margin-left:10px;">
<form name="detailForm">
<table class="table table-striped table-bordered table-hover">
	 <caption>장바구니</caption>
	 <thead>
		<tr>
			<th width="10%">선택</th>
			<th>상품이미지</th>
			<th>상품정보</th>
			<th>수량</th>
			<th>가격</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="purchase" items="${list}">
		<tr class="ct_list_pop">
			<td align="center">
				<input type="checkbox" class="prodNoList" name="prodNoList" value="${purchase.purchaseProd.prodNo }">
			</td>		
			<td align="center" width="50" height="100">
				 	<img src="/images/uploadFiles/${purchase.purchaseProd.fileName }" width="150" height="200">
			</td>
			<td align="left" width="100">
				<span>상품명</span> <br>
				<!-- <a href="/product/getProduct?prodNo=${purchase.purchaseProd.prodNo}">${purchase.purchaseProd.prodName}</a> -->
				<div>
					<span class='prodName'>${purchase.purchaseProd.prodName}</span>
					<span hidden="">${purchase.purchaseProd.prodNo}</span>
				</div>
				<br><br><br>
				<span>상품설명</span> <br>
				${purchase.purchaseProd.prodDetail }
			</td>
			<td width="40" align="center">
				<div>
					<span>남은 수량 : ${purchase.purchaseProd.prodTotal }개</span>
				</div>
				<div>
						<input type="button" class="btn btn-default" value='-'>
						<input type="text" class="text-center totalList" id="purchaseQuantity${purchase.purchaseProd.prodNo}" name="prodTotalList" value="0" style ="border-style: hidden; width:20px" >
						<input type="button" class="btn btn-default" value='+'>
					
				</div>
				<span hidden="">${purchase.purchaseProd.prodNo}</span>
				<span hidden="">${purchase.purchaseProd.prodTotal }</span>
			</td>

			<td width="50" align="center">
				${purchase.purchaseProd.price}<span style="margin-left: 5px">원</span>
			</td>
	</c:forEach>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="center">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>	
				<button type="button" class="btn btn-default"><span>구매</span></button>
			</tr>
		</table>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
						
			<jsp:include page="../common/pageNavigator.jsp"/>	
			
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->
</form>
</div>

</body>
</html>