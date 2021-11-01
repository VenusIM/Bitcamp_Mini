<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--<%@page import="com.model2.mvc.common.Page"%>
<%@page import="java.util.List"%>
<%@page import="com.model2.mvc.common.Search"%>
<%@page import="com.model2.mvc.service.domain.Purchase"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
 <%
 	List<Purchase> list= (List<Purchase>)request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");
	Search search=(Search)request.getAttribute("search");

%>   --%> 
<html>
<head>
<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
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
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm">
<input type="hidden" id="tranNo" name="tranNo" />
<input type="hidden" id="prodNo" name="prodNo" />

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11" >
			전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage } 페이지
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">수령인 이름</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">수령인 전화번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">정보수정</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<%--<% 
		for(int i=0; i<list.size(); i++) {
			Purchase purchase = list.get(i);
	--%>
	<c:set var="i" value="0"/>
	<c:forEach var="purchase" items="${list}">
		<c:set var="i" value="${i+1}"/>
		<tr class="ct_list_pop">
			<td align="center">${i}</td>
			<td></td>
			
			<td align="left">
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
			</td>
			<td></td>
			<td align="left">
			<%--<%= purchase.getReceiverName() --%>
			${empty purchase.receiverName ? '없음' : purchase.receiverName}
			</td>
			<td></td>
			<td align="left">
			<%--<%= purchase.getReceiverPhone() --%>
			${empty purchase.receiverPhone ? '없음' : purchase.receiverPhone}
			</td>	
			<td></td>
			<td align="left">
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
			</td>	
			<td></td>
			
			<td align="left">
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
			</td>	
		<tr>
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
		<%--<% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){
					◁ 이전
			<% }else{ %>
					<a href="javascript:fncGetPurchaseList('<%=resultPage.getCurrentPage()-1%>','1')">◀ 이전</a>
			<% } %>

			<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
					<a href="javascript:fncGetPurchaseList('<%=i %>','1');"><%=i %></a>
			<% 	}  %>
	
			<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
					이후 ▷
			<% }else{ %>
					<a href="javascript:fncGetPurchaseList('<%=resultPage.getEndUnitPage()+1%>','1')">이후 ▶</a>
			<% } %> --%>
		<!-- 
		 
			<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">
					◁ 이전
			</c:if>
			<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
					<a href="javascript:fncGetPurchaseList('${ resultPage.currentPage-1}','1')">◀ 이전</a>
			</c:if>
			
			<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}">
				<a href="javascript:fncGetPurchaseList('${i}','1');">${ i }</a>
			</c:forEach>
			
			<c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
					이후 ▷
			</c:if>
			<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
					<a href="javascript:fncGetPurchaseList('${resultPage.endUnitPage+1}','1')">이후 ▶</a>
			</c:if>
			 -->
			 
			 <input type="hidden" id="currentPage" name="currentPage"/>
			 <jsp:include page="../common/pageNavigator.jsp"/>
    	</td>
	</tr>
</table>

<!--  페이지 Navigator 끝 -->
</form>
</div>

</body>
</html>