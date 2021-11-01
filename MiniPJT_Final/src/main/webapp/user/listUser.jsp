<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<title>회원 목록 조회</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script type="text/javascript">
	// 검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScrpt 이용  
	
	/*function fncGetUserList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
	   	document.detailForm.submit();		
	}*/
	
	$(function(){
		
		$('.pageNum').on("click",function(index){
			$('form')[0].reset();
			$('#currentPage').val($(this).text());
			$('form').attr('method','post').attr('action','/user/listUser').submit();
		});
		
		$('#before').click(function(){
			$('form')[0].reset();
			$('#currentPage').val(${ resultPage.currentPage-1});
			$('form').attr('method','post').attr('action','/user/listUser').submit();
		});
		
		$('#after').click(function(){
			$('form')[0].reset();
			$('#currentPage').val(${resultPage.endUnitPage+1});
			$('form').attr('method','post').attr('action','/user/listUser').submit();
		});
		
		$('span:contains("검색")').click(function(){
			$('#currentPage').val(1);
			$('form').attr('method','post').attr('action','/user/listUser').submit();
		});
		
		$('input[name="searchKeyword"]').keyup(function(){
			var searchKeyword = $(this).val();
			var searchCondition = $('select[name="searchCondition"]').val();
	
			$.ajax(
				{
					url : "/user/json/autoComplete/"+searchKeyword+"/"+searchCondition,
					method : "GET",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					dataType:"json",
					success : function(JSONData,status){
						var availableTags = JSONData;
						$(function(){
							$('input[name="searchKeyword"]').autocomplete({
								source: availableTags
							});							
						});
					},
			});
			
		});
		
		$('.userId').click(function(){
			var userId = $(this).text();
			console.log(userId)
			$.ajax(
				{
					url:"/user/json/getUser/"+userId,
					method: "GET",
					dataType:"json",
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					success: function(JSONData,status){
						
						var displayValue = "<h4>"
											+"아이디 : "+JSONData.userId+"<br/>"
											+"이  름 : "+JSONData.userName+"<br/>"
											+"이메일 : "+JSONData.email+"<br/>"
											+"ROLE : "+JSONData.role+"<br/>"
											+"등록일 : "+JSONData.regDateString+"<br/>"
											+"</h4>";
						$("h4").remove();
						$( "#"+userId+"" ).html(displayValue);
					}
				});
			//$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser?userId="+userId);
		});
		
	});
</script>

</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<!-- ////////////////////////////////////////////////////////////////////////////////////////////////////////// 
<form name="detailForm" action="/listUser.do" method="post">
////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
<form name="detailForm">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37" />
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">회원 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<div class="ui-widget">
				<select name="searchCondition" class="ct_input_g" style="width:80px">
					<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>회원ID</option>
					<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>회원명</option>
				</select>
				<input type="text" name="searchKeyword" 
							value="${! empty search.searchKeyword ? search.searchKeyword : ''}"  
							class="ct_input_g" style="width:200px; height:20px" >
			</div> 
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23"></td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<!-- <a href="javascript:fncGetUserList('1');">검색</a> -->
						<span>검색</span>
					</td>
					<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td colspan="11" >
			전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">이메일</td>		
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	
	<c:set var="i" value="0" />
	<c:forEach var="user" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${ i }</td>
			<td></td>
			<td align="left">
				<!-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				<a href="/getUser.do?userId=${user.userId}">${user.userId}</a></td>
               	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////-->
			<!-- <a href="/user/getUser?userId=${user.userId}">${user.userId}</a>-->
			<span class="userId">${user.userId }</span>
			</td>
			<td></td>
			<td align="left">${user.userName}</td>
			<td></td>
			<td align="left">${user.email}</td>		
		</tr>
		<tr>
			<td id="${user.userId}" colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
</table>


<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
	
			<jsp:include page="../common/pageNavigator.jsp"/>	
			
    	</td>
	</tr>
</table>
<!-- PageNavigation End... -->

</form>
</div>

</body>
</html>
