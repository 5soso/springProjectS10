<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>productContent.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <style>
  	#content img{
  		width: 300px;
  		height: auto !important; 
  	}
  </style>
  <script>
  	'use strict';
    
  	// 천단위마다 콤마를 표시해 주는 함수
    function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
  </script>
</head>
<body>  
<jsp:include page="/WEB-INF/views/admin/adminNav.jsp" />
<p><br/></p>
<div class="container w3-main" style="margin-left:400px;margin-top:43px;">
  <table class="table table-borderless m-0 p-0">
  	<tr>
  	  <td class="m-0 p-0">
	  	  <div style="width:120px;height:500px; overflow:auto; border:1px solid gray">
		  	  <!-- 상품 이미지 여러장 -->
			    <c:set var="firstImgs" value="${fn:split(productVO.FSName, '/')}" />
		  	  <c:forEach var="i" begin="0" end="${fn:length(firstImgs)-1}" varStatus="st">
		  	  	<div>
		  	  		<%-- <img src="${ctp}/product/${firstImgs[i]}" width="100px"/> --%>
		  	  		
		  	  		<img src="${ctp}/product/${firstImgs[i]}" width="100px" 
					      onmouseover="document.getElementById('img').innerHTML='<img src=${ctp}/product/${firstImgs[i]} width=500px>'"/>
		  	  	</div>
		  	  </c:forEach>
	  	  </div>
  	  </td>
  		<td class="m-0 p-0">
		    <div class="col-5" style="border:1px solid #ccc">
				  <!-- 상품메인 이미지 -->
				  <div id="img"><img src="${ctp}/product/${firstImgs[0]}" id="img1" width="500px"/>
				    <%-- <img src="${ctp}/product/${firstImgs[0]}" width="100%"/> --%> <!-- 메인이미지 여러장.. 0번째=썸네일이미지 -->
				  </div>
				</div>
			</td>
			<td class="m-0 p-0 text-right">
				<!-- <div class="col-6 p-3 text-right"> -->
				  <!-- 상품 기본정보 -->
				  <div id="iteminfor">
				    <h3>${productVO.detail}</h3>
				    <h3><font color="orange"><fmt:formatNumber value="${productVO.mainPrice}"/>원</font></h3>
				    <h4>${productVO.productName}</h4>
				  </div>
				  <!-- 상품주문을 위한 옵션정보 출력 -->
				  <div class="form-group">
				    <form name="optionForm">  <!-- 옵션의 정보를 보여주기위한 form -->
				      <select size="1" class="form-control" id="selectOption">
				        <option value="" disabled selected>상품옵션선택</option>
				        <option value="0:기본품목_${productVO.mainPrice}">기본품목</option>
				        <c:forEach var="vo" items="${optionVOS}">
				          <option value="${vo.idx}:${vo.optionName}_${vo.optionPrice}">${vo.optionName} (+<fmt:formatNumber value="${vo.optionPrice}" />원)</option>
				        </c:forEach>
				      </select>
				    </form>
				  </div>
				  <br/>
				  <div class="text-right p-2">
				    <input type="button" value="옵션등록" onclick="location.href='${ctp}/product/productOption?productName=${productVO.productName}';" class="btn w3-black"/>
				  </div>
			  <!-- </div> -->
			</td>
		</tr>
  </table>
  <br/><br/>
  <div class="w3-right mt-3 mb-5">
  	<input type="button" value="삭제하기" onclick="location.href='${ctp}/product/productDelete?idx=${productVO.idx}';" class="btn w3-black mr-2" /> 
		<input type="button" value="돌아가기" onclick="location.href='${ctp}/product/adminProductList';" class="btn btn-warning"/>
	</div>
  <!-- 상품 상세설명 보여주기 -->
  <div id="content" class="text-center"><br/>
    ${productVO.content}
  </div>
</div>
<p><br/></p>
</body>
</html>