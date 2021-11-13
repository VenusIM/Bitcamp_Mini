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

function fncGetUserList(currentPage) {
	$("#currentPage").val(currentPage)
	$("form").attr("method" , "POST").attr("action" , "/product/listProduct").submit();
}

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
		
		$('td:nth-child(7) > i').click(function(){
			
			var name = $(this).next().text();
			var prodNo = $(this).next().next().text();
			var tranCode = $(this).next().next().next().text();
			
			
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
						
						var displayValue ="<h5>"
											+"��ǰ��ȣ : "+JSONData.prodNo+"<br/>"
											+"<p style='display: inline-block; width: 250px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;'>��ǰ�̸� : "+JSONData.prodName+"</p><br/>"
											+"��ǰ�̹��� <br/>"
											+'<img src="/images/uploadFiles/'+JSONData.fileName+'" width="300" height="300"/><br/>'
											+'<p style="display: inline-block; width: 250px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">��ǰ������ : '+JSONData.prodDetail+'</p><br/>'
											+"��ǰ ���� : "+JSONData.price+"<br/>"
											+"������� : "+JSONData.regDateString+"<br/>"
											+'<a href="/product/updateProductView?prodNo='+JSONData.prodNo+'" id="update" class="btn btn-success" role="button">��ǰ����</a>'
											+"</h5>"
						$('h5').remove();
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

<div class="container">
	
		<div class="page-header text-info">
	       <h3>��ǰ����������</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0" ${search.searchCondition eq '0' ? "selected" : "" }>��ǰ��ȣ</option>
						<option value="1" ${search.searchCondition eq '1' ? "selected" : "" }>��ǰ��</option>
						<option value="2" ${search.searchCondition eq '2' ? "selected" : "" }>����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>

 <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >��ǰ��</th>
            <th align="left">������Ȳ</th>
            <th align="left">����</th>
            <th align="left">�����</th>
            <th align="left">�������</th>
          </tr>
        </thead>
       
		<tbody>
		
		  <c:set var="i" value="0" />
		  <c:forEach var="prod" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr>
			  <td align="center">${ i }</td>
			  <td>${prod.prodName}</td>
			  <td align="left">${prod.prodTotal} ��</td>
			  <td align="left">${prod.price} ��</td>
			  <td align="left">${prod.regDate}</td>
			  <td align="left">
					${prod.prodTotal == 0 ? '������' : prod.proTranCode }
			  </td>
			 
			  <td align="left">
			  	<i class="glyphicon glyphicon-ok" id= "${prod.prodNo}"></i>
			  	<span class="prod" hidden="hidden">${prod.prodName}</span>
			  	<span class="prod" hidden="hidden">${prod.prodNo}</span>
			  	<span class="prod" hidden="hidden">${prod.proTranCode}</span>
			  </td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
</div>

<jsp:include page="../common/pageNavigator_new.jsp"/>
<!--  ������ Navigator �� -->
</form>
</div>

</body>
</html>