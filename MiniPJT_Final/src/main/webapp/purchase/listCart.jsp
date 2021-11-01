<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

	$(function(){
		
		$('span:contains("구매")').click(function(){
	        var prodNoList = $('.prodNoList:checked');
	      
	        if(prodNoList.length == 0){
	            alert("구매하실 상품을 체크해 주세요.");
	            return;
	        }else{
	        	$('#currentPage').val(${resultPage.currentPage});
				$('form').attr('method','post').attr('action','/purchase/addCartListView').submit();	        	
	        }	
		});
		
		$('.prodName').click(function(){
			
			$(self.location).attr('href','/product/getProduct?prodNo='+$(this).next().text());
		});
		
		$('input:button').click(function(){
			
			var type = $(this).val();
			var prodNo = $(this).parent().next().text();
			var total = $(this).parent().next().next().text();
			var number =  $('#purchaseQuantity'+prodNo).val();
			
			 if(type === '+') {
				number = parseInt(number) + 1;
				if(number >= total ){
					number = total;
				}
			}else if(type === '-')  {
				number = parseInt(number) - 1;
				if(number<=0)
				  	number = 0;
				}
			// 결과 출력
			console.log(number);
			 $('#purchaseQuantity'+prodNo).val(number);

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
		if(number == 1){
			document.getElementById("currentPage").value = currentPage;
		   	document.detailForm.action="/purchase/findCartList";
		   	document.detailForm.submit();
		}else{
			var isChecked = false;
	        var prodNoList = document.getElementsByName("prodNoList");
	        for(var i=0;i<prodNoList.length;i++){
	            if(prodNoList[i].checked == true) {
	                isChecked=true;
	                break;
	            }
	        }
	    
	        if(!isChecked){
	            alert("구매하실 상품을 체크해 주세요.");
	            return;
	        }else{
				document.getElementById("currentPage").value = currentPage;
			   	document.detailForm.action="/purchase/addCartListView";
			   	document.detailForm.submit();	        	
	        }
		}
	}
	
	function count(type,prodNo,total)  {
		  // 결과를 표시할 element
		  const name = "purchaseQuantity"+prodNo;
		  console.log(name);
		  const resultElement = document.getElementById(name);
		  console.log(resultElement);
		  const count = total;
		  console.log(total);
		  
		  // 현재 화면에 표시된 값
		  let number = resultElement.value;
		  
		  // 더하기/빼기
		 if(type === 'plus') {
		    number = parseInt(number) + 1;
			  if(number >= total){
				  number = total;
			  }
		  }else if(type === 'minus')  {
		    number = parseInt(number) - 1;
		    if(number<=1)
		    	number = 1;
		  }
		  // 결과 출력
		  resultElement.value = number;
	}
	*/
	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:100%; margin-left:10px;">
<form name="detailForm">
<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">
					장바구니
					</td>
				</tr>
			
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37">
		</td>
	</tr>
</table>

<table width="70%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px; margin: auto">
	<tr>
		<td colspan="11" >
			전체  ${resultPage.totalCount} 건수,	현재 ${resultPage.currentPage } 페이지
			[<input type="submit" name = "rowCondition" value="3개씩 보기" style='border:0px; background-color:white'>]
			[<input type="submit" name = "rowCondition" value="5개씩 보기" style='border:0px; background-color:white'>]
			[<input type="submit" name = "rowCondition" value="10개씩 보기" style='border:0px; background-color:white'>]
			<input type="hidden" name = "rowCondition" value="${search.rowCondition }">
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="20">
		선택
       </td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="50">상품이미지</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품정보</td>
		<td class="ct_line02"></td>	
		<td class="ct_list_b" width="40">수량</td>
		<td class="ct_line02"></td>	
		<td class="ct_list_b" width="40">가격</td>
		<td class="ct_line02"></td>	
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:forEach var="purchase" items="${list}">
		<tr class="ct_list_pop">
			<td align="center">
				<input type="checkbox"class="prodNoList" name="prodNoList" value="${purchase.purchaseProd.prodNo }">
			</td>
			<td></td>
			
			<td align="center" width="50" height="100">
				 	<img src="/images/uploadFiles/${purchase.purchaseProd.fileName }" width="150" height="200">
			</td>
			<td></td>
			<td align="left" width="100">
				<span>상품명</span> <br>
				<!-- <a href="/product/getProduct?prodNo=${purchase.purchaseProd.prodNo}">${purchase.purchaseProd.prodName}</a> -->
				<div>
					<span class='prodName'>${purchase.purchaseProd.prodName}</span>
					<span hidden="">${purchase.purchaseProd.prodNo}</span>
				</div>
				<br><br><br>
				<span>상품설명</span> <br>
				${purchase.purchaseProd.prodDetail }
			</td>
			<td></td>
			<td width="40" align="center">
				<div>
					<span>남은 수량 : ${purchase.purchaseProd.prodTotal }개</span>
				</div>
				<div>
					<!-- <td class="ct_write01"> -->
						<!-- <input type="button" value='-' onclick='count("minus",${purchase.purchaseProd.prodNo},${purchase.purchaseProd.prodTotal })'> -->
						<input type="button" value='-'>
						<input type="number" id="purchaseQuantity${purchase.purchaseProd.prodNo}" name="prodTotalList" value="1" style = "width:20px" >
						<!-- <input type="button" value='+' onclick='count("plus",${purchase.purchaseProd.prodNo},${purchase.purchaseProd.prodTotal })'> -->
						<input type="button" value='+'>
					<!-- </td> -->
				</div>
				<span hidden="">${purchase.purchaseProd.prodNo}</span>
				<span hidden="">${purchase.purchaseProd.prodTotal }</span>
			</td>
			<td></td>
			<td width="50" align="center">
				${purchase.purchaseProd.price}<span style="margin-left: 5px">원</span>
			</td>
			<td></td>
		<tr>
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="center">
		<table border="0" cellspacing="0" cellpadding="0">
		<tr>	
			<td width="17" height="23">
				<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
			</td>
			<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
				<!-- <a href="javascript:fncGetProductList('${resultPage.currentPage}','2')">구매</a> -->
				<span>구매</span>
			</td>
			<td width="14" height="23">
				<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
			</td>					
		</tr>
		</table>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="center">
						
			<jsp:include page="../common/pageNavigator.jsp"/>	
			
    	</td>
	</tr>
</table>
<!--  페이지 Navigator 끝 -->
</form>
</div>

</body>
</html>