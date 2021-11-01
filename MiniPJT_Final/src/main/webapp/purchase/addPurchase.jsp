<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--<%@page import="com.model2.mvc.service.domain.Purchase"%> 
<% Purchase purchase = (Purchase)request.getAttribute("purchase"); %>--%>    
    
<html>
<head>
<title>Insert title here</title>
</head>

<body>



다음과 같이 구매가 되었습니다.

<table border=1>
	<tr>
	<c:if test="${empty prodName }">
		<td>물품번호</td>
		<td>
		<%--<%=purchase.getPurchaseProd().getProdNo() --%>
		${purchase.purchaseProd.prodNo }
		</td>
		<td></td>
	</c:if>
	<c:if test="${!empty prodName }">
		<td>상품명</td>
		<td>
		<%--<%=purchase.getPurchaseProd().getProdNo() --%>
		${prodName}
		</td>
		<td></td>
	</c:if>
	</tr>
	<tr>
		<td>구매자아이디</td>
		<td>
		<%--<%=purchase.getBuyer().getUserId() --%>
		${ empty purchase.buyer.userId ? "없음" : purchase.buyer.userId }
		</td>
		<td></td>
	</tr>
	<tr>
		<td>구매방법</td>
		<td>
		<%--<%= purchase.getPaymentOption().equals("1") ? "현금구매" : "신용구매"--%>
		${purchase.paymentOption==1 ? "현금구매" : "신용구매"}
		</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자이름</td>
		<td>
		<%--<%=!purchase.getReceiverName().equals("") ? purchase.getReceiverName() : "없음" --%>
		${ empty purchase.receiverName ? "없음" : purchase.receiverName }
		</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자연락처</td>
		<td>
		<%--<%=!purchase.getReceiverPhone().equals("") ? purchase.getReceiverPhone() : "없음" --%>
		${ empty purchase.receiverPhone ? "없음" : purchase.receiverPhone }
		</td>
		<td></td>
	</tr>
	<tr>
		<td>구매자주소</td>
		<td>
		<%--<%=!purchase.getDivyAddr().equals("") ? purchase.getDivyAddr() : "없음" --%>
		${ empty purchase.divyAddr ? "없음" : purchase.divyAddr }
		</td>
		<td></td>
	</tr>
		<tr>
		<td>구매요청사항</td>
		<td>
		<%--<%= purchase.getDivyRequest() == null ? purchase.getDivyRequest() : "없음" --%>
		${ empty purchase.divyRequest ? "없음" : purchase.divyRequest }	
		</td>
		<td></td>
	</tr>
	<tr>
		<td>배송희망일자</td>
		<td>
		<%--<%= purchase.getDivyDate() == null ? purchase.getDivyDate() : "없음" --%>
		${ empty purchase.divyDate ? "없음" :  purchase.divyDate }
		</td>
		<td></td>
	</tr>
	<tr>
	<c:if test="${empty prodTotal }">
		<td>구매수량</td>
		<td>
		<%--<%=!purchase.getReceiverPhone().equals("") ? purchase.getReceiverPhone() : "없음" --%>
		${purchase.purchaseQuantity}개
		</td>
		<td></td>
	</c:if>
		<c:if test="${!empty prodTotal }">
		<td>구매수량</td>
		<td>
		<%--<%=!purchase.getReceiverPhone().equals("") ? purchase.getReceiverPhone() : "없음" --%>
		${prodTotal}
		</td>
		<td></td>
	</c:if>
	</tr>
</table>

</body>
</html>