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
	<style>
		body{
			padding-top: 70px;
		}
	</style>
</head>

<body>

<jsp:include page="../header.jsp"></jsp:include>

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-2"></div>
			<div class="col-md-8">
				<c:if test="${!empty sessionScope.list }">
					<strong>구매완료</strong>
					<c:forEach var="product" items="${sessionScope.list}" varStatus="status">
						<pre>상품명 : ${product.prodName}<br/>개수 : ${totalList[status.index]}개<br/>가격 : ${product.price}원<br/><strong>총가격:${product.price * totalList[status.index] }원</strong></pre>
					</c:forEach>
				</c:if>			
				<c:if test="${empty sessionScope.list }">
					<table class="table table-striped table-bordered table-hover">
						<tr>
							<c:if test="${empty prodName }">
								<th>물품번호</th>
								<td>
								<%--<%=purchase.getPurchaseProd().getProdNo() --%>
								${purchase.purchaseProd.prodNo }
								</td>
							</c:if>
							<c:if test="${!empty prodName }">
								<th>상품명</th>
								<td>
								<%--<%=purchase.getPurchaseProd().getProdNo() --%>
								${prodName}
								</td>
							</c:if>
							</tr>
							<tr>
								<th>구매자아이디</th>
								<td>
								<%--<%=purchase.getBuyer().getUserId() --%>
								${ empty purchase.buyer.userId ? "없음" : purchase.buyer.userId }
								</td>
							</tr>
							<tr>
								<th>구매방법</th>
								<td>
								<%--<%= purchase.getPaymentOption().equals("1") ? "현금구매" : "신용구매"--%>
								${purchase.paymentOption==1 ? "현금구매" : "신용구매"}
								</td>
							</tr>
							<tr>
								<th>구매자이름</th>
								<td>
								<%--<%=!purchase.getReceiverName().equals("") ? purchase.getReceiverName() : "없음" --%>
								${ empty purchase.receiverName ? "없음" : purchase.receiverName }
								</td>
							</tr>
							<tr>
								<th>구매자연락처</th>
								<td>
								<%--<%=!purchase.getReceiverPhone().equals("") ? purchase.getReceiverPhone() : "없음" --%>
								${ empty purchase.receiverPhone ? "없음" : purchase.receiverPhone }
								</td>
							</tr>
							<tr>
								<th>구매자주소</th>
								<td>
								<%--<%=!purchase.getDivyAddr().equals("") ? purchase.getDivyAddr() : "없음" --%>
								${ empty purchase.divyAddr ? "없음" : purchase.divyAddr }
								</td>
							</tr>
								<tr>
								<th>구매요청사항</th>
								<td>
								<%--<%= purchase.getDivyRequest() == null ? purchase.getDivyRequest() : "없음" --%>
								${ empty purchase.divyRequest ? "없음" : purchase.divyRequest }	
								</td>
							</tr>
							<tr>
								<th>배송희망일자</th>
								<td>
								<%--<%= purchase.getDivyDate() == null ? purchase.getDivyDate() : "없음" --%>
								${ empty purchase.divyDate ? "없음" :  purchase.divyDate }
								</td>
							</tr>
							<tr>
							<c:if test="${empty prodTotal }">
								<th>구매수량</th>
								<td>
								<%--<%=!purchase.getReceiverPhone().equals("") ? purchase.getReceiverPhone() : "없음" --%>
								${purchase.purchaseQuantity}개
								</td>
							</c:if>
							<c:if test="${!empty prodTotal }">
								<th>구매수량</th>
								<td>
								<%--<%=!purchase.getReceiverPhone().equals("") ? purchase.getReceiverPhone() : "없음" --%>
								${prodTotal}
								</td>
							</c:if>
						</tr>
					</table>
					</c:if>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
</body>
</html>