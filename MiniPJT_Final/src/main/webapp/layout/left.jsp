<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>Model2 MVC Shop</title>

<link href="/css/left.css" rel="stylesheet" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

$(function() {
	$( ".Depth03:contains('개인정보조회')" ).on("click" , function() {
		$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser?userId=${user.userId}");
	});
	
	$( ".Depth03:contains('회원정보조회')" ).on("click" , function() {
 		$(window.parent.frames["rightFrame"].document.location).attr("href","/user/listUser");
	});
	
	$( ".Depth03:contains('판매상품등록')" ).on("click" , function() {
 		$(window.parent.frames["rightFrame"].document.location).attr("href","/product/addProductView.jsp");
	});
	
	$( ".Depth03:contains('판매상품관리')" ).on("click" , function() {
 		$(window.parent.frames["rightFrame"].document.location).attr("href","/product/listProduct?menu=manage");
	});
	
	$( ".Depth03:contains('상 품 검 색')" ).on("click" , function() {
 		$(window.parent.frames["rightFrame"].document.location).attr("href","/product/listProduct?menu=search");
	});
	
	$( ".Depth03:contains('장 바 구 니')" ).on("click" , function() {
		$(window.parent.frames["rightFrame"].document.location).attr("href","/purchase/findCartList");
	});
	
	$( ".Depth03:contains('구매이력조회')" ).on("click" , function() {
		$(window.parent.frames["rightFrame"].document.location).attr('href',"/purchase/listPurchase");
	});
	
	$( ".Depth03:contains('최근 본 상품')" ).on("click" , function() {
		window.open("/history.jsp","popWin","left=300, top=200, width=300, height=200, marginwidth=0, marginheight=0, scrollbars=yes, scrolling=yes, menubar=no, resizable=no");
	});
});
</script>
</head>

<body background="/images/left/imgLeftBg.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >

<table width="159" border="0" cellspacing="0" cellpadding="0">

<!--menu 01 line-->
<tr>
	<td valign="top"> 
		<table  border="0" cellspacing="0" cellpadding="0" width="159" >	
			<tr>
				<c:if test="${ !empty user }">
					<tr>
						<td class="Depth03">
							<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
							<a href="/getUser.do?userId=${user.userId}" target="rightFrame">개인정보조회</a>
							////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
							<a href="/user/getUser?userId=${user.userId}" target="rightFrame">개인정보조회</a>-->
							개인정보조회
						</td>
					</tr>
				</c:if>
			
				<c:if test="${user.role == 'admin'}">
					<tr>
						<td class="Depth03" >
							<!-- //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
							<a href="/listUser.do" target="rightFrame">회원정보조회</a>
							////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
							<a href="/user/listUser" target="rightFrame">회원정보조회</a>-->
							회원정보조회
						</td>
					</tr>
				</c:if>
			
				<tr>
					<td class="DepthEnd">&nbsp;</td>
				</tr>
		</table>
	</td>
</tr>

<!--menu 02 line-->
<c:if test="${user.role == 'admin'}">
	<tr>
		<td valign="top"> 
			<table  border="0" cellspacing="0" cellpadding="0" width="159">
				<tr>
					<td class="Depth03">
						<!-- <a href="/product/addProductView.jsp;" target="rightFrame">판매상품등록</a> -->
						판매상품등록
					</td>
				</tr>
				<tr>
					<td class="Depth03">
						<!-- <a href="/product/listProduct?menu=manage"  target="rightFrame">판매상품관리</a> -->
						판매상품관리
					</td>
				</tr>
				<tr>
					<td class="DepthEnd">&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
</c:if>

<!--menu 03 line-->
<tr>
	<td valign="top"> 
		<table  border="0" cellspacing="0" cellpadding="0" width="159">
			<tr>
				<td class="Depth03">
					<!-- <a href="/product/listProduct?menu=search" target="rightFrame">상 품 검 색</a> -->
					상 품 검 색
				</td>
			</tr>
			
			<c:if test="${ !empty user && user.role == 'user'}">
			<tr>
				<td class="Depth03">
					<!-- <a href="/purchase/findCartList" target="rightFrame">장 바 구 니</a> -->
					장 바 구 니
				</td>
			</tr>
			<tr>
				<td class="Depth03">
					<!-- <a href="/purchase/listPurchase"  target="rightFrame">구매이력조회</a> -->
					구매이력조회
				</td>
			</tr>
			</c:if>
			
			<tr>
				<td class="DepthEnd">&nbsp;</td>
			</tr>
			<tr>
				<td class="Depth03">
					<!-- <a href="javascript:history()">최근 본 상품</a> -->
					최근 본 상품
				</td>
			</tr>
		</table>
	</td>
</tr>

</table>

</body>
</html>
