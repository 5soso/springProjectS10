<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>wishList.jsp</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  	
  	function wishDelete(idx) {
  		let res = confirm("해당 상품을 위시리스트에서 삭제할까요?");
  		if(!res) return false;
  		
  		location.href="wishDeleteOk?idx="+idx;
  	}
  	
  	function order(idx) {
			location.href="wishOrder?idx="+idx;  		
  	}
  </script>
  <style>
  	.proName {
  		font-weight: bold;
  		margin-bottom: 10px;
  	}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container" style="margin-top: 130px;">
	<h2 style="text-align: center;">WISH LIST</h2>
  <br/>
  <form name="wishForm" method="post">
	  <table class="table table-hover">
	  	<tr>
	  		<th>이미지</th>
	  		<th>상품정보</th>
	  		<th>판매가</th>
	  		<th>배송비</th>
	  		<th>합계</th>
	  		<th>선택</th>
	  	</tr>
	  	<c:forEach var="vo" items="${vos}" varStatus="st">
		  	<tr>
		  		<c:set var="imgs" value="${fn:split(vo.FSName,'/')}" />
		  		<td>
		  			<a href='${ctp}/product/productContentShop?idx=${vo.productIdx}'><img src="${ctp}/product/${imgs[0]}" width="100px"/></a>
		  		</td>
		  		<td>
			  		<a href='${ctp}/product/productContentShop?idx=${vo.productIdx}'>
			  			<span class="proName">${vo.categorySubName} - ${vo.productName}</span>
			  		</a>
			  		<br/><br/>
			  		<c:set var="options" value="${fn:split(vo.options,'/')}" />
							· 선택옵션 (사이즈,수량,가격)<br/>
				  	<c:forEach var="option" items="${options}" varStatus="st"> 
				  		<c:set var="op" value="${fn:replace(option,':',' / ')}" /> 	
							&nbsp;&nbsp;${op}원<br/>	  			
						</c:forEach> 	
		  		</td>
		  		<td>${vo.totalPrice}</td>
		  		<c:if test="${vo.totalPrice<60000}">
		  		  <c:set var="beasong" value="3000" />
		  		  <c:set var="price" value="${vo.totalPrice+beasong}" />
		  		</c:if>
		  		<c:if test="${vo.totalPrice>=60000}">
		  		  <c:set var="beasong" value="0" />
		  		  <c:set var="price" value="${vo.totalPrice+beasong}" />
		  		</c:if>
		  		<td>${beasong}</td>
		  		<td>${price}</td>
		  		<td>
		  		  <a href="javascript:order(${vo.idx})" class="badge badge-secondary">주문하기</a><br/>
		  		  <a href="javascript:wishDelete(${vo.idx})"  class="badge badge-danger">X 삭제</a>
		  		</td>
		  	</tr>
	  	</c:forEach>
	  	<tr><td colspan="6 m-0 p-0"></td></tr>
	  </table>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>