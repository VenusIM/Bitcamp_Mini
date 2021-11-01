<%@page contentType="text/html; charset=euc-kr"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--
<%@page import="com.model2.mvc.service.domain.User"%>
<%@page import="com.model2.mvc.service.domain.Product"%>
	Product product = (Product)session.getAttribute("product");
	User user=(User)session.getAttribute("user");
	String menu = (String)session.getAttribute("menu");
	
	String history=null;
	Cookie[] cookies = request.getCookies();
	if (cookies!=null && cookies.length > 0) {
		for (int i = 0; i < cookies.length; i++) {
			Cookie cookie = cookies[i];
			System.out.println(cookie.getName());
			if (cookie.getName().equals("history")) {
				history = cookie.getValue();
			}
		}
		history += ","+product.getProdNo();
	}
	Cookie cookie = new Cookie("history",history);
	response.addCookie(cookie);
--%>	

<html>
<head>
<title>상품상세조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

</head>

<body bgcolor="#ffffff" text="#000000">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">상품상세조회</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif" width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">
			상품번호 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">
					<%--<%=product.getProdNo() --%>
					${product.prodNo}
					</td>
					<td></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">
			상품명 <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		<%--<%=product.getProdName() --%>
		${product.prodName}
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">상품이미지</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		<%--<%=product.getFileName() --%>
		<img src="/images/uploadFiles/${product.fileName}" width="300" height="300"/>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">상품상세정보</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		<%--<%=product.getProdDetail() --%>
		${product.prodDetail}
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">제조일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		<%--<%=product.getManuDate() --%>
		${product.manuDate}
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">가격</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		<%--<%=product.getPrice() --%>
		${product.price}
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
	<tr>
		<td width="104" class="ct_write">등록일자</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		<%--<%=product.getRegDate() --%>
		${product.regDate}
		</td>
	</tr>

	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td width="53%"></td>
		<td align="right">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<%--<%if(user != null && user.getRole().equals("user")){ --%>
					<c:if test="${user.role eq 'user' && product.prodTotal ne 0}">
						<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
							<!-- <a href="/addPurchaseView.do?prodNo=<%--product.getProdNo()--%>">구매</a> -->
							<a href="/purchase/addPurchaseCart">상품 담기</a>
							<td width="14" height="23">
							<img src="/images/ct_btnbg03.gif" width="14" height="23">
						</td>
						
						<td width="14" height="23">
							
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
							<!-- <a href="/addPurchaseView.do?prodNo=<%--product.getProdNo()--%>">구매</a> -->
							<a href="/purchase/addPurchaseView?prodNo=${product.prodNo}">구매</a>
						</td>
						
						<td width="14" height="23">
							<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
					<%--<%} --%>
					</c:if>
						<td width="30"></td>					
						<td width="17" height="23">
							<img src="/images/ct_btnbg01.gif" width="17" height="23">
						</td>
						<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:history.go(-1);">확인</a>
					</td>
					<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</body>