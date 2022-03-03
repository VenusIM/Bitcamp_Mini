<%@page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>��ǰ����ȸ</title>

<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
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
			$("button:contains('����')").on('click',function(){
				console.log("Ŭ��")
				$('form').attr('method','post').attr('action','/purchase/addPurchaseView').submit();
			});
		});
	</script>
	
	<style>
		body{
			padding-top: 70px;
		}
	</style>
</head>

<body>

<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
<div class="page-header">
	       <h3 class=" text-info">��ǰ������ȸ</h3>
	       <h5 class="text-muted"><strong class="text-danger">��ǰ����</strong>�Դϴ�.</h5>
	       </div>
<table class="table table-hover table-striped" >
	<tr>
		<th>
			��ǰ��ȣ
		</th>
		<td>
			${product.prodNo}
		</td>
	<tr>
		<th>
			��ǰ��
		</th>
		<td>
		${product.prodName}
		</td>
	</tr>
	<tr>
		<th>��ǰ�̹���</th>
		<td class="ct_write01">
			<img src="/images/uploadFiles/${product.fileName}" width="300" height="300"/>
		</td>
	</tr>
	<tr>
		<th>��ǰ������</th>
		<td>
		${product.prodDetail}
		</td>
	</tr>
	<tr>
		<th>��������</th>
		<td>
		${product.manuDate}
		</td>
	</tr>
	<tr>
		<th>����</th>
		<td>
		${product.price}
		</td>
	</tr>
	<tr>
		<th>�������</th>
		<td>
		${product.regDate}
		</td>
	</tr>
</table>
<div class="container">
	<div class="row">
	<form>
		<button type="button" class="btn btn-success">����</button>
		<input type="hidden" name="prodNo" value="${product.prodNo}"> 
	</form>
	</div>
</div>
</div>
</body>