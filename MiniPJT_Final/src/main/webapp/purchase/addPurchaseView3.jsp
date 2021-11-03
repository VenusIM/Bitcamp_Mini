<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- <%@page import="com.model2.mvc.service.domain.User"%>
<%@page import="com.model2.mvc.service.domain.Product"%>
<% User user = (User)session.getAttribute("user"); %>
<% Product product = (Product)request.getAttribute("product"); %> --%>

<html>
<head>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<title>���������Է�</title>

<script type="text/javascript" src="../javascript/calendar.js">
</script>
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">


	$(function(){
		
		$('input:button').click(function(){
			
			var type = $(this).val();
			console.log(type);
			var number =  $('#total').val();
			console.log(number);
			 if(type === '+') {
				number = parseInt(number) + 1;
				if(number >= parseInt(${product.prodTotal}) ){
					number = parseInt(${product.prodTotal})
				}
			}else if(type === '-')  {
				number = parseInt(number) - 1;
				if(number<=0)
				  	number = 0;
				}
			// ��� ���
			console.log(number);
			 $('#total').val(number);

		});
		
		$('input[name="divyDate"]').click(function(){
			show_calendar('document.addPurchase.divyDate', document.addPurchase.divyDate.value);
		});
		
		$('span[id="add"]:contains("����")').click(function(){
			console.log("�����");
			$('form').attr('method','post').attr('action','/purchase/addPurchase').submit();
		});
		
		$('span[id="cart"]:contains("����")').click(function(){
			$('form').attr('method','post').attr('action','/purchase/addCartList').submit();
		});
		$('span:contains("���")').click(function(){
			$(window.parent.frames.document.location).attr('href','/index.jsp');
		});
	});

	/*
function fncAddPurchase(){
	
	document.addPurchase.action = '/purchase/addPurchase';
	document.addPurchase.submit();
}

function fncAddCartPurchase() {
	
	document.addPurchase.action = '/purchase/addCartList';
	document.addPurchase.submit();
}

function count(type)  {
	  // ����� ǥ���� element
	  const resultElement = document.getElementById('total');
	  
	  
	  // ���� ȭ�鿡 ǥ�õ� ��
	  let number = resultElement.value;
	  
	  // ���ϱ�/����
	 if(type === 'plus') {
	    number = parseInt(number) + 1;
		  if(number >= ${product.prodTotal}){
			  number = ${product.prodTotal}
		  }
	  }else if(type === 'minus')  {
	    number = parseInt(number) - 1;
	    if(number<=0)
	    	number = 0;
	  }
	  // ��� ���
	  resultElement.value = number;
}
*/

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<form name="addPurchase">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">���������Է�</td>
					<td width="20%" align="right">&nbsp;</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37"/>
		</td>
	</tr>
</table>
<c:if test="${product.prodNo != 0}">
	<input type="hidden" name="prodNo" 
			<%--<%=product.getProdNo() %>--%>
			value="${product.prodNo}"/>
</c:if>
<c:if test="${!empty product.prodNoList }">
	<input type="hidden" name="prodName" value="${prodName}">
	<input type="hidden" name="prodTotal" value="${totals }">
</c:if>

<input type="hidden" name="buyerId" 
						<%--<%=user.getUserId() %>--%>
						value="${user.userId}" />
	
<table width="600" border="0" cellspacing="0" cellpadding="0"	align="center" style="margin-top: 13px;">
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="300" class="ct_write">
			<c:if test="${product.prodNo != 0}">
				��ǰ��ȣ
			</c:if>
			<c:if test="${!empty product.prodNoList }">
				��ǰ��
			</c:if>
			<img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01" width="299">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="105">
					<%--<%=product.getProdNo() --%>
					<c:if test="${product.prodNo != 0}">
						${product.prodNo}
					</c:if>
					<c:if test="${!empty product.prodNoList }">
						${prodName }
					</c:if>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<c:if test="${product.prodNo != 0}">
	<tr>
		<td width="104" class="ct_write">
			��ǰ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
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
		<td width="104" class="ct_write">
			��ǰ������ <img	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		<%--<%=product.getProdDetail() --%>
		${product.prodDetail }
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">��������</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		<%--<%=product.getManuDate() --%>
		${product.manuDate }
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">����</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		<%--<%=product.getPrice() --%>
		${product.price }
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�������</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		<%--<%=product.getRegDate() --%>
		${product.regDate }
		
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	</c:if>
	<tr>
		<td width="104" class="ct_write">
			�����ھ��̵� <img 	src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle"/>
		</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
		<%--<%=user.getUserId() --%>
		${user.userId}
		</td>	
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">���Ź��</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<select name="paymentOption" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20">
				<option value="1" selected>���ݱ���</option>
				<option value="2">�ſ뱸��</option>
			</select>
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�������̸�</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="receiverName" 	class="ct_input_g" 	style="width: 100px; height: 19px" maxLength="20" 
					<%--<%=user.getUserName() != null ? user.getUserName() : "" %>--%>
					value="${ empty user.userName ? '' : user.userName }" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�����ڿ���ó</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="receiverPhone" class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20" 
									<%--<%=user.getPhone() != null ? user.getPhone() : "" %>--%>
									value="${ empty user.phone ? '' : user.phone  }" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">�������ּ�</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input 	type="text" name="divyAddr" class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20" 	
									<%--<%=user.getAddr()==null ? "" : user.getAddr() %>--%>
									value="${ empty user.addr || user.addr eq 'null' ? '' : user.addr }" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">���ſ�û����</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td class="ct_write01">
			<input type="text" name="divyRequest" class="ct_input_g" 
							value=""
							style="width: 100px; height: 19px" maxLength="20" />
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">����������</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<td width="200" class="ct_write01">
			<input 	type="text" readonly="readonly" name="divyDate" class="ct_input_g" 
							style="width: 100px; height: 19px" maxLength="20" value=""/>
			<!-- <img 	src="../images/ct_icon_date.gif" width="15" height="15"	
						onclick="show_calendar('document.addPurchase.divyDate', document.addPurchase.divyDate.value)"/> -->
		</td>
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	<tr>
		<td width="104" class="ct_write">���ż���</td>
		<td bgcolor="D6D6D6" width="1"></td>
		<c:if test="${product.prodNo != 0}">
			<td class="ct_write01">
				<!-- <input type="button" value='-' onclick='count("minus")'> -->
				<input type="button" value='-'>
				<input type="number" id='total' name="purchaseQuantity" value="1" style = "width:20px" >
				<!-- <input type="button" value='+' onclick='count("plus")'> -->
				<input type="button" value='+'>
			</td>
		</c:if>
		<c:if test="${!empty product.prodNoList }">
		<td class="ct_write01">
			${totals}				
		</td>
		</c:if>
		
	</tr>
	<tr>
		<td height="1" colspan="3" bgcolor="D6D6D6"></td>
	</tr>
	
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td width="53%"></td>
		<td align="center">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
				<c:if test="${!empty product.prodNoList }">
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<!-- <a href="javascript:fncAddCartPurchase();">����</a> -->
						<span id="cart">����</span>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</c:if>
				<c:if test="${empty product.prodNoList }">
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<!-- <a href="javascript:fncAddPurchase();">����</a> -->
						<span id="add">����</span>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23"/>
					</td>
				</c:if>
					<td width="30"></td>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
						<!-- <a href="javascript:history.go(-1)">���</a> -->
						<span>���</span>
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