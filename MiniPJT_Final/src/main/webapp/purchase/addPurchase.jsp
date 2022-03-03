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
					<strong>���ſϷ�</strong>
					<c:forEach var="product" items="${sessionScope.list}" varStatus="status">
						<pre>��ǰ�� : ${product.prodName}<br/>���� : ${totalList[status.index]}��<br/>���� : ${product.price}��<br/><strong>�Ѱ���:${product.price * totalList[status.index] }��</strong></pre>
					</c:forEach>
				</c:if>			
				<c:if test="${empty sessionScope.list }">
					<table class="table table-striped table-bordered table-hover">
						<tr>
							<c:if test="${empty prodName }">
								<th>��ǰ��ȣ</th>
								<td>
								<%--<%=purchase.getPurchaseProd().getProdNo() --%>
								${purchase.purchaseProd.prodNo }
								</td>
							</c:if>
							<c:if test="${!empty prodName }">
								<th>��ǰ��</th>
								<td>
								<%--<%=purchase.getPurchaseProd().getProdNo() --%>
								${prodName}
								</td>
							</c:if>
							</tr>
							<tr>
								<th>�����ھ��̵�</th>
								<td>
								<%--<%=purchase.getBuyer().getUserId() --%>
								${ empty purchase.buyer.userId ? "����" : purchase.buyer.userId }
								</td>
							</tr>
							<tr>
								<th>���Ź��</th>
								<td>
								<%--<%= purchase.getPaymentOption().equals("1") ? "���ݱ���" : "�ſ뱸��"--%>
								${purchase.paymentOption==1 ? "���ݱ���" : "�ſ뱸��"}
								</td>
							</tr>
							<tr>
								<th>�������̸�</th>
								<td>
								<%--<%=!purchase.getReceiverName().equals("") ? purchase.getReceiverName() : "����" --%>
								${ empty purchase.receiverName ? "����" : purchase.receiverName }
								</td>
							</tr>
							<tr>
								<th>�����ڿ���ó</th>
								<td>
								<%--<%=!purchase.getReceiverPhone().equals("") ? purchase.getReceiverPhone() : "����" --%>
								${ empty purchase.receiverPhone ? "����" : purchase.receiverPhone }
								</td>
							</tr>
							<tr>
								<th>�������ּ�</th>
								<td>
								<%--<%=!purchase.getDivyAddr().equals("") ? purchase.getDivyAddr() : "����" --%>
								${ empty purchase.divyAddr ? "����" : purchase.divyAddr }
								</td>
							</tr>
								<tr>
								<th>���ſ�û����</th>
								<td>
								<%--<%= purchase.getDivyRequest() == null ? purchase.getDivyRequest() : "����" --%>
								${ empty purchase.divyRequest ? "����" : purchase.divyRequest }	
								</td>
							</tr>
							<tr>
								<th>����������</th>
								<td>
								<%--<%= purchase.getDivyDate() == null ? purchase.getDivyDate() : "����" --%>
								${ empty purchase.divyDate ? "����" :  purchase.divyDate }
								</td>
							</tr>
							<tr>
							<c:if test="${empty prodTotal }">
								<th>���ż���</th>
								<td>
								<%--<%=!purchase.getReceiverPhone().equals("") ? purchase.getReceiverPhone() : "����" --%>
								${purchase.purchaseQuantity}��
								</td>
							</c:if>
							<c:if test="${!empty prodTotal }">
								<th>���ż���</th>
								<td>
								<%--<%=!purchase.getReceiverPhone().equals("") ? purchase.getReceiverPhone() : "����" --%>
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