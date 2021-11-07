<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%--<%@page import="com.model2.mvc.common.util.CommonUtil"%>
<%@page import="com.model2.mvc.common.Page"%>
<%@page import="java.util.List"%>
<%@page import="com.model2.mvc.service.domain.Product"%>
<%@page import="com.model2.mvc.common.Search"%>
<%@page import="com.model2.mvc.service.domain.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%
	List<Product> list= (List<Product>)request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");

	Search search=(Search)request.getAttribute("search");
	String menu = (String)session.getAttribute("menu");
	User uv = (User)session.getAttribute("user");
	
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
	
	String role = null;
	if(uv != null){
		role = uv.getRole();
	}else{
		role = "";
	}
%> --%>

<html>
<head>
<title>��ǰ �����ȸ</title>
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
		
		$('input[name="searchKeyword"]').keyup(function(){
			var searchKeyword = $(this).val();
			var searchCondition = $('select[name="searchCondition"]').val();
	
			$.ajax(
				{
					url : "/product/rest/productAutoComplete/"+searchKeyword+"/"+searchCondition,
					method : "GET",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					dataType:"json",
					success : function(JSONData,status){
						var availableTags = JSONData;
						console.log(JSONData);
						$(function(){
							$('input[name="searchKeyword"]').autocomplete({
								source: availableTags
							});							
						});
					},
			});
			
		});
		
		$('.prod').click(function(){
			var name = $(this).text();
			var prodNo = $(this).next().text();
			var tranCode = $(this).next().next().text();
			
			$.ajax(
				{
					url : "/product/rest/getProduct",
					method : "POST",
					data :  JSON.stringify({
						prodNo : prodNo
					}),
					dataType:"json",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success: function(JSONData,status){
						
						var displayValue ="<h4>"
											+"��ǰ��ȣ : "+JSONData.prodNo+"<br/>"
											+"��ǰ�̸� : "+JSONData.prodName+"<br/>"
											+"��ǰ�̹��� <br/>"
											+'<img src="/images/uploadFiles/'+JSONData.fileName+'" width="300" height="300"/><br/>'
											+"��ǰ������ : "+JSONData.prodDetail+"<br/>"
											+"��ǰ ���� : "+JSONData.price+"<br/>"
											+"������� : "+JSONData.regDateString+"<br/>" 
											+"</h4>"
						$('h4').remove();
						$( "#"+prodNo+"" ).html(displayValue);					
					}		
			});
			
			//$(self.location).attr('href','/product/getProduct?prodNo='+prodNo+'&proTranCode='+tranCode);
		});
		
		$('span:contains("����ϱ�")').click(function(){
			$('#currentPage').val(1);
			$('#tranNo').val($(this).next().text());
			
			$('form').attr('method','post').attr('action','/purchase/updateTranCodeByProd').submit();
		});
		
		$('.pageNum').on("click",function(index){
			$('form')[0].reset();
			$('#currentPage').val($(this).text());
			$('form').attr('method','post').attr('action','/product/listProduct').submit();
		});
		
		$('#before').click(function(){
			$('form')[0].reset();
			$('#currentPage').val(${ resultPage.currentPage-1});
			$('form').attr('method','post').attr('action','/product/listProduct').submit();
		});
		
		$('#after').click(function(){
			$('form')[0].reset();
			$('#currentPage').val(${resultPage.endUnitPage+1});
			$('form').attr('method','post').attr('action','/product/listProduct').submit();
		});
	
	});
	
	/*
	function fncGetProductList(currentPage, number) {
		console.log(number);
		if(number == 1){
			document.getElementById("currentPage").value = currentPage;
		   	document.detailForm.action="/product/listProduct";
		   	document.detailForm.submit();
		}else {
			document.getElementById("currentPage").value = currentPage;
			document.getElementById("tranNo").value = number;
		   	document.detailForm.action="/purchase/updateTranCodeByProd";
		   	document.detailForm.submit();
		}
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
<jsp:include page="../header.jsp"></jsp:include>
<div style="width:98%; margin-left:10px;">

<form name="detailForm">
<input type="hidden" id="tranNo" name="tranNo"/>
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					<%--<%=menu.equals("manage")? "��ǰ����" : "��ǰ ��� ��ȸ"--%>
					${menu eq 'manage' ? "��ǰ����" : "��ǰ ��� ��ȸ"}
					</td>
				</tr>
			
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37">
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
		<div class="ui-widget">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<!-- <option value="0" <%--<%=(searchCondition.equals("0") ? "selected" : "")%>>��ǰ��ȣ</option>
				<option value="1" <%=(searchCondition.equals("1") ? "selected" : "")%>>��ǰ��</option>
				<option value="2" <%=(searchCondition.equals("2") ? "selected" : "")%>--%>>����</option> -->
				
				<option value="0" ${search.searchCondition eq '0' ? "selected" : "" }>��ǰ��ȣ</option>
				<option value="1" ${search.searchCondition eq '1' ? "selected" : "" }>��ǰ��</option>
				<option value="2" ${search.searchCondition eq '2' ? "selected" : "" }>����</option>
				
			</select>
			<input 	type="text" name="searchKeyword"
														   <%--<%= searchKeyword %>--%>
													value="${search.searchKeyword}" class="ct_input_g" style="width:200px; height:19px" >
		</div>
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
					<input type="submit" value=">�˻�" style='border:1px; background-color:white; border-style: solid;'>
					<td width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<!-- <td colspan="11" >
			��ü  <%--<%= resultPage.getTotalCount() --%> �Ǽ�,	���� <%--<%= resultPage.getCurrentPage() --%> ������
		</td> -->
		
		<td colspan="11" >
			��ü  ${resultPage.totalCount} �Ǽ�,	���� ${resultPage.currentPage } ������
		</td>
		
		
		
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">��ǰ��</td>
		<td class="ct_line02"></td>
		<c:if test="${user.role eq 'admin'}">
			<td class="ct_list_b" width="150">������Ȳ</td>
			<td class="ct_line02"></td>
		</c:if>
		<td class="ct_list_b" width="150">����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����</td>		
		<td class="ct_line02"></td>
		<td class="ct_list_b">�������</td>		
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<%--
		for(int i=0; i<list.size(); i++) {
			Product product = list.get(i);
	--%>
	
	<c:set var="i" value="0"/>	
	<c:forEach var="prod" items="${list}">
		<c:set var="i" value="${i+1}" />
	<tr class="ct_list_pop">
		<td align="center">
							<%--<%=i+1--%>
							${i}
									</td>
		<td></td>
		
		<td align="left">
				<%--<%if(role.equals("admin")){
					<a href="/getProduct.do?menu=<%=menu %>&prodNo=<%=product.getProdNo() %>"><%= product.getProdName() %></a>
				<%}else{ 
					if(product.getProTranCode().equals("�Ǹ���")){%>
						<a href="/getProduct.do?menu=<%=menu %>&prodNo=<%=product.getProdNo() %>"><%= product.getProdName() %></a>
					<%}else{ %>
						<%=product.getProdName() %>
					<%} %>
			 	<%} %>--%>
			 	<!-- <a href="/product/getProduct?prodNo=${prod.prodNo}&proTranCode=${prod.proTranCode}">${prod.prodName}</a> -->
			 	
			 	<span class="prod">${prod.prodName}</span>
			 	<span class="prod" hidden="">${prod.prodNo}</span>
			 	<span class="prod" hidden="">${prod.proTranCode}</span>
			 	
		</td>
		<c:if test="${user.role eq 'admin'}">
			<td></td>
			<td align="left">
			<%--<%= product.getPrice() --%>
			${prod.prodTotal}
			</td>
		</c:if>
		<td></td>
		<td align="left">
		<%--<%= product.getPrice() --%>
		${prod.price}
		</td>
		<td></td>
		<td align="left">
		<%--<%= product.getRegDate() --%>
		${prod.regDate}
		</td>
		<td></td>
		<td align="left">
		<%--<%if(menu.equals("search")){ 
				if(role.equals("admin")){%>
					<%=product.getProTranCode() %>
				<%}else{ %>
					<%= product.getProTranCode().equals("�Ǹ���") ? "�Ǹ���" : "������"%>
				<%} %>
				
		<%}else if(menu.equals("manage")){%>
			  <%if(product.getProTranCode().equals("���ſϷ�")){ %>
			  		<input type="hidden" name="prodNo" value="<%=product.getProdNo() %>"/>
					���ſϷ� <a href="javascript:fncGetProductList('<%=resultPage.getCurrentPage()%>','2')">����ϱ�</a>
				<%}else{ %>
					<%=product.getProTranCode() %>
				<%} %>
		<%} %>--%>
		
		<c:if test="${menu == 'search'}">
			<c:if test="${user.role eq 'admin' }">
				${prod.prodTotal == 0 ? '������' : prod.proTranCode }
			</c:if>
			<c:if test="${user.role ne 'admin' }">
				${prod.prodTotal == 0 ? '������' : '�Ǹ���'}
			</c:if>
		</c:if>
		<c:if test="${menu eq 'manage' }">
			<c:if test="${prod.proTranCode eq '���ſϷ�' }">
				<!-- ���ſϷ� <a href="javascript:fncGetProductList('${resultPage.currentPage}','${prod.tranNo}')" onClick="return confirm('����Ͻðڽ��ϱ�?')">����ϱ�</a> -->
				<div>
					<span>���ſϷ�</span>&nbsp;
					<span>����ϱ�</span>
					<span hidden="">${prod.tranNo}</span>
				</div>
			</c:if>
			<c:if test="${prod.proTranCode ne '���ſϷ�'}">
				${prod.prodTotal == 0 ? '������' : prod.proTranCode }
			</c:if>
		</c:if>
		</td>	
	<tr>
		<td id="${prod.prodNo}" colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	</c:forEach>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
	
			<jsp:include page="../common/pageNavigator.jsp"/>	
			
    	</td>
	</tr>
</table>
<!--  ������ Navigator �� -->
</form>
</div>

</body>
</html>