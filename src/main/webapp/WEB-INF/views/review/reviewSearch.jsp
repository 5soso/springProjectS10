<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>reviewSearch.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  
  	function reviewSearch() {
  		let reviewSearch = $("#reviewSearch").val().trim();
  		
  		if(reviewSearch === "") {
  			alert("검색어를 입력하세요!");
  			return false;
  		}
  		
  		location.href='reviewSearch';
  	}
  </script>
  <style>
  	h2 {
  		text-align: center;
  	}
  	#reviewSearch {
  		background-color: #eee;
  		border: 1px solid #ddd;
  		background-image: url('');
  	}
  	.backPage {
  		
  	}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container" style="margin-top: 130px;">
  <h2><a href="${ctp}/review/productReview">REVIEW</a></h2>
  <div class="mt-5 mb-3"><b>상품평수</b> ${fn:length(vos)}개 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="text" name="reviewSearch" id="reviewSearch" size="15" placeholder="검색어를 입력하세요." />
		<input type="button" value="검색" onclick="reviewSearch()" class="btn btn-secondary btn-sm"/>
		<select name="reSelect" class="w3-right">
			<option value="" selected>최신순</option>
			<option>별점순</option>
			<option>추천순</option>
		</select>
  </div>
  <c:if test="${!empty vos}">
	  <!-- 사용자 리뷰 -->
	  <div>
		  <div class="row">
			  <c:forEach var="vo" items="${vos}" varStatus="st">
			    <table class="table table-hover">
			    	<tr>
			    		<td width="20%">
			    			<c:set var="productImg" value="${fn:split(vo.FSName, '/')}" />
							  <div class="col-2 ml-4"><img src="${ctp}/product/${productImg[0]}" width="80px" height="80px"/></div>
							  <div class="col-10 pl-3 text-center" style="font-size: 10pt;">
							  	<c:set var="productName" value="${vo.categorySubName}-${vo.productName}" />
							    <font>${fn:substring(productName,0,15)}...</font>
							    <br/>
							    <div class="text-center"><fmt:formatNumber value="${vo.mainPrice}"/>원</div>
							  </div>
			    		</td>
			    		<td width="80%">
			    			<table>
			    				<tr>
			    					<td>
			    						<c:forEach var="i" begin="1" end="${vo.reStar}">
			    							<font color="orange">★</font>
			    						</c:forEach>
			    						&nbsp;&nbsp;&nbsp;
			    						<c:set var="mid" value="${vo.mid}" />
			    						<font color="gray">⊙ ${fn:substring(mid,0,2)}**
			    						&nbsp;&nbsp;&nbsp;
			    						${fn:substring(vo.reDate,0,10)}</font>
			    					</td>
			    				</tr>
			    				<tr>
			    					<td>
			    						<b>평소 사이즈</b><font color="gray"> ${vo.dogSize}</font> &nbsp;&nbsp;&nbsp;
			    						<b>몸무게</b><font color="gray"> ~${vo.dogWeight}kg</font>
			    					</td>
			    				</tr>
			    				<tr>
			    					<td>
			    						${fn:replace(vo.content,newLine,"<br/>")}
			    					</td>
			    				</tr>
			    				<tr>
			    					<td>
			    						<c:if test="${!empty vo.reImage}">
			    							<img src="${ctp}/review/${vo.reImage}" width="80px" height="80px"/>
			    						</c:if>
			    					</td>
			    				</tr>
			    			</table>
			    		</td>
						</tr>
				  </table>
				  <hr/>
			  </c:forEach>
			</div>
	  
	  </div>
  </c:if>
  <c:if test="${empty vos}">
  	<hr/>
  	<h5 class="text-center" style="font-weight: bold">검색된 리뷰가 없습니다.</h5><br/>
  	<%-- <div class="backPage text-center mt-5"><a href="${ctp}/review/productReview">이전으로</a></div> --%>
  	<div class="w3-center"><input type="button" value="이전으로" onclick="location.href='productReview';" class="btn btn-secondary mt-5 mb-0" /></div>
  </c:if>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>