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
  <title>adminProductList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/adminNav.jsp" />
<p><br/></p>
<div class="container w3-main" style="margin-left:300px;margin-top:43px;">
  <span>[<a href="${ctp}/product/adminProductList">전체보기</a>]</span> /
  <c:forEach var="subTitle" items="${subTitleVOS}" varStatus="st">
  	<span>[<a href="${ctp}/product/adminProductList?part=${subTitle.categorySubName}">${subTitle.categorySubName}</a>]</span>
	  <c:if test="${!st.last}"> / </c:if>
  </c:forEach>  
 	<hr/>
  <div class="row">
    <div class="col">
	    <h4>상품 리스트 : <font color="brown"><b>${part}</b></font></h4>
    </div>
    <div class="col text-right">
		  <button type="button" class="btn btn-primary" onclick="location.href='${ctp}/product/productInput';">상품등록하러가기</button>
    </div>
  </div>
  <hr/>
  <c:set var="cnt" value="0"/>
  <div class="row mt-4">
    <c:forEach var="vo" items="${productVOS}">
      <div class="col-md-4">
        <div style="text-align:center" class="mt-1">
          <a href="${ctp}/product/productContent?idx=${vo.idx}">
            <c:set var="productImg" value="${fn:split(vo.FSName, '/')}" />
            <img src="${ctp}/product/${productImg[0]}" width="200px" height="180px"/>
            <div><font size="2">${vo.categorySubName} - ${vo.productName}</font></div>
            <div><font size="2" color="orange"><fmt:formatNumber value="${vo.mainPrice}" pattern="#,###"/>원</font></div>
            <div><font size="2">${vo.detail}</font></div>
          </a>
        </div>
      </div>
      <c:set var="cnt" value="${cnt+1}"/>
      <c:if test="${cnt % 3 == 0}">
        </div>
        <div class="row mt-5">
      </c:if>
    </c:forEach>
    <div class="container">
      <c:if test="${fn:length(productVOS) == 0}"><h3>제품 준비 중입니다.</h3></c:if>
    </div>
  </div>
  <hr/>
  <div class="text-right">
	  <button type="button" class="btn btn-primary" onclick="location.href='${ctp}/product/productInput';">상품등록하러가기</button>
  </div>
</div>
<p><br/></p>
</body>
</html>