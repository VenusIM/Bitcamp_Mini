<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>구매 목록조회</title>

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
		
		$('.trans').click(function(){
			$(self.location).attr('href','/purchase/getPurchase?tranNo='+$(this).next().text());
		});
		
		$('span:contains("물품도착")').click(function(){
			var currentPage = $(this).next().text();
			var prodNo = $(this).next().next().text();
			var tranNo = $(this).next().next().next().text();
			
			console.log(currentPage);
			console.log(prodNo);
			console.log(tranNo);
			
			$('#currentPage').val(currentPage);
			$('#prodNo').val(prodNo);
			$('#tranNo').val(tranNo);
			
			$('form').attr('method','post').attr('action','/purchase/updateTranCode').submit();
		});
		
		$('.pageNum').on("click",function(index){
			$('form')[0].reset();
			$('#currentPage').val($(this).text());
			$('form').attr('method','get').attr('action','/purchase/listPurchase').submit();
		});
		
		$('#before').click(function(){
			$('form')[0].reset();
			$('#currentPage').val(${ resultPage.currentPage-1});
			$('form').attr('method','get').attr('action','/purchase/listPurchase').submit();
		});
		
		$('#after').click(function(){
			$('form')[0].reset();
			$('#currentPage').val(${resultPage.endUnitPage+1});
			$('form').attr('method','get').attr('action','/purchase/listPurchase').submit();
		});
	});

	/*
	function fncGetPurchaseList(currentPage, number) {
		document.getElementById("currentPage").value = currentPage;
		document.detailForm.action = "/purchase/listPurchase";
		document.detailForm.submit();						
	}
	
	function fncGetPurchaseList2(currentPage, number1, number2){
		console.log(number1,number2)
		document.getElementById("currentPage").value = currentPage;
		document.getElementById("tranNo").value = number1;
		document.getElementById("prodNo").value = number2;
		document.detailForm.action = "/purchase/updateTranCode";
		document.detailForm.submit();
	}
	*/
</script>

<style>
	body{
		padding-top: 70px;
	}
</style>

</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">
	<jsp:include page="/header.jsp"></jsp:include>
<form name="detailForm">
<input type="hidden" id="tranNo" name="tranNo" />
<input type="hidden" id="prodNo" name="prodNo" />

<table class="table table-striped table-bordered table-hover">
	 <caption>구매 목록조회</caption>
	 <thead>
		<tr>
			<th width="5%">No</th>
			<th width="19%">상품명</th>
			<th width="19%">수령인 이름</th>
			<th width="19%">수령인 전화번호</th>
			<th width="19%">배송현황</th>
			<th width="19%">정보수정</th>
		</tr>
	</thead>
	<tbody>
	<c:set var="i" value="0"/>
	<c:forEach var="purchase" items="${list}">
		<c:set var="i" value="${i+1}"/>
		<tr>
			<th>${i}</th>
			
			<th>
			<c:if test="${purchase.tranCode eq '2' }">
				${purchase.purchaseProd.prodName}
			</c:if>
			<c:if test="${purchase.tranCode ne '2' }">
				<!-- <a href="/purchase/getPurchase?tranNo=${purchase.tranNo}">${purchase.purchaseProd.prodName}</a> -->
				<div>
					<span class="trans">${purchase.purchaseProd.prodName}</span>
					<span hidden="">${purchase.tranNo}</span>
				</div>
			</c:if>
			</th>
			<th>
			<%--<%= purchase.getReceiverName() --%>
			${empty purchase.receiverName ? '없음' : purchase.receiverName}
			</th>
			<th>
			<%--<%= purchase.getReceiverPhone() --%>
			${empty purchase.receiverPhone ? '없음' : purchase.receiverPhone}
			</th>	
			<th>
					<%--<%if(purchase.getTranCode().equals("1")) {--%>
					<c:if test="${purchase.tranCode eq '1' }">
						현재 구매완료 상태입니다.
					</c:if>
					<c:if test="${purchase.tranCode eq '2' }">
						현재 배송중 입니다.
					</c:if>
					<c:if test="${purchase.tranCode eq '3' }">
						물품 수령완료 상태입니다.
					</c:if>
			</th>
			<th>
				<%--<%if(purchase.getTranCode().equals("2")){ --%>
				<c:if test="${purchase.tranCode eq '2' }">
					<!-- <a href="javascript:fncGetPurchaseList2('${resultPage.currentPage }','${purchase.tranNo}','${purchase.purchaseProd.prodNo }')" onClick = "confirm('물품을 수령 하셨습니까?')">물품도착</a> -->
					<div>
						<span>물품도착</span>
						<span hidden="">${resultPage.currentPage }</span>
						<span hidden="">${purchase.tranNo}</span>
						<span hidden="">${purchase.purchaseProd.prodNo }</span>
					</div>
				</c:if>
				<%--<%} else if(purchase.getTranCode().equals("3")){--%>
				<c:if test="${purchase.tranCode eq '3' }">
					물품수령
				<%--<%} --%>
				</c:if>
			</th>	
		</tr>
	</c:forEach>
	</tbody>
</table>

<jsp:include page="../common/pageNavigator_new.jsp"/>

<!--  페이지 Navigator 끝 -->
</form>
</div>

</body>
</html>