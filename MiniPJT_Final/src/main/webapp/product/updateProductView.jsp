<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%--<%@page import="com.model2.mvc.service.domain.Product"%>
<% Product product = (Product)request.getAttribute("product"); %> --%>

<html>
<head>
<title>상품등록</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript" src="../javascript/calendar.js">
</script>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

	$(function(){
		
		$('span:contains("수정")').click(function(){
			$(self.location).attr('method','post').attr('action','/product/updateProduct').attr('enctype','multipart/form-data').submit();
		});
		
		$('span:contains("취소")').click(function(){
			$(window.parent.frames.document.location).attr('href','/index.jsp');
		});
		
		$('input[name="manuDate"]').click(function(){
			show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value);
		});
	});

/*
function fncUpdateProduct(){
	document.detailForm.action='/product/updateProduct';
	document.detailForm.submit();
}
*/


</script>
</head>
<body bgcolor="#ffffff" text="#000000">

<form name="detailForm">
<input type="hidden" name='prodNo' value='${product.prodNo }'/>
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37"/>
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">상품수정</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif"	width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품명 <imgsrc="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle">
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">
						<input type="text" name="prodName" class="ct_input_g" value="${product.prodName }"
									style="width: 100px; height: 19px" maxLength="20">
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품상세정보 <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="prodDetail" class="ct_input_g" value="${product.prodDetail }"
						style="width: 100px; height: 19px" maxLength="10" minLength="6"/>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			제조일자 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<!-- <input type="text" name="manuDate" readonly="readonly" class="ct_input_g" value='${product.manuDate}'
						style="width: 100px; height: 19px"	maxLength="10" minLength="6"/>
				&nbsp;<img src="../images/ct_icon_date.gif" width="15" height="15" 
										onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)"/> -->
				<input type="text" name="manuDate" readonly="readonly" class="ct_input_g" value='${product.manuDate}'
						style="width: 100px; height: 19px"	maxLength="10" minLength="6"/>						 
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			가격 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="price" 	class="ct_input_g"  value = "${product.price }"
						style="width: 100px; height: 19px" maxLength="10">&nbsp;원
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">상품이미지</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input	type="file" name="fileUpload" class="ct_input_g" style="width: 200px; height: 19px" maxLength="13"/>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">상품수량</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input	type="number" name="prodTotal" class="ct_input_g"  value="${product.prodTotal }"
							style="width: 50px; height: 19px" maxLength="13"/>개
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
		<table border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01"  style="padding-top: 3px;">
					<!-- <a href="javascript:fncUpdateProduct();">수정</a> -->
					<span>수정</span>
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
				<td width="30"></td>
				<td width="17" height="23">
					<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
				</td>
				<td background="/images/ct_btnbg02.gif" class="ct_btn01"	 style="padding-top: 3px;">
					<!-- <a href="javascript:history.go(-1)">취소</a> -->
					<span>취소</span>
				</td>
				<td width="14" height="23">
					<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</form>
</body>
</html>