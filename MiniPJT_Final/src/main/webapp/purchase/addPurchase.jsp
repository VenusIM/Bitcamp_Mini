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



������ ���� ���Ű� �Ǿ����ϴ�.

<table border=1>
	<tr>
	<c:if test="${empty prodName }">
		<td>��ǰ��ȣ</td>
		<td>
		<%--<%=purchase.getPurchaseProd().getProdNo() --%>
		${purchase.purchaseProd.prodNo }
		</td>
		<td></td>
	</c:if>
	<c:if test="${!empty prodName }">
		<td>��ǰ��</td>
		<td>
		<%--<%=purchase.getPurchaseProd().getProdNo() --%>
		${prodName}
		</td>
		<td></td>
	</c:if>
	</tr>
	<tr>
		<td>�����ھ��̵�</td>
		<td>
		<%--<%=purchase.getBuyer().getUserId() --%>
		${ empty purchase.buyer.userId ? "����" : purchase.buyer.userId }
		</td>
		<td></td>
	</tr>
	<tr>
		<td>���Ź��</td>
		<td>
		<%--<%= purchase.getPaymentOption().equals("1") ? "���ݱ���" : "�ſ뱸��"--%>
		${purchase.paymentOption==1 ? "���ݱ���" : "�ſ뱸��"}
		</td>
		<td></td>
	</tr>
	<tr>
		<td>�������̸�</td>
		<td>
		<%--<%=!purchase.getReceiverName().equals("") ? purchase.getReceiverName() : "����" --%>
		${ empty purchase.receiverName ? "����" : purchase.receiverName }
		</td>
		<td></td>
	</tr>
	<tr>
		<td>�����ڿ���ó</td>
		<td>
		<%--<%=!purchase.getReceiverPhone().equals("") ? purchase.getReceiverPhone() : "����" --%>
		${ empty purchase.receiverPhone ? "����" : purchase.receiverPhone }
		</td>
		<td></td>
	</tr>
	<tr>
		<td>�������ּ�</td>
		<td>
		<%--<%=!purchase.getDivyAddr().equals("") ? purchase.getDivyAddr() : "����" --%>
		${ empty purchase.divyAddr ? "����" : purchase.divyAddr }
		</td>
		<td></td>
	</tr>
		<tr>
		<td>���ſ�û����</td>
		<td>
		<%--<%= purchase.getDivyRequest() == null ? purchase.getDivyRequest() : "����" --%>
		${ empty purchase.divyRequest ? "����" : purchase.divyRequest }	
		</td>
		<td></td>
	</tr>
	<tr>
		<td>����������</td>
		<td>
		<%--<%= purchase.getDivyDate() == null ? purchase.getDivyDate() : "����" --%>
		${ empty purchase.divyDate ? "����" :  purchase.divyDate }
		</td>
		<td></td>
	</tr>
	<tr>
	<c:if test="${empty prodTotal }">
		<td>���ż���</td>
		<td>
		<%--<%=!purchase.getReceiverPhone().equals("") ? purchase.getReceiverPhone() : "����" --%>
		${purchase.purchaseQuantity}��
		</td>
		<td></td>
	</c:if>
		<c:if test="${!empty prodTotal }">
		<td>���ż���</td>
		<td>
		<%--<%=!purchase.getReceiverPhone().equals("") ? purchase.getReceiverPhone() : "����" --%>
		${prodTotal}
		</td>
		<td></td>
	</c:if>
	</tr>
</table>

</body>
</html>