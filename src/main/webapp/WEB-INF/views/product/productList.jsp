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
  <title>productList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
		h2, p {
			text-align: center;
		}
		.menu a {
			font-size : 13px;
			padding : 3px 13px;
			border : 0.5px solid #ddd;
			color : gray;
		}
		.menu a:hover {
			text-decoration: none;
			background-color : black;
			color: white;
		}
		.button {
		  background-color: #04AA6D;
		  border: #e7e7e7;;
		  color: white;
		  padding: 5px 11px 5px 11px;
		  text-decoration: none;
		  display: inline-block;
		  font-size: 16px;
		  margin: 0px 2px;
		  transition-duration: 0.4s;
		  cursor: pointer;
		  border-radius: 5px;
		}
		.button4 {
		  background-color: white;
		  color: black;
		  border: 2px solid black;
		}
		.button4:hover {
			background-color: black;
			color: white;
			border: 2px solid black;
		}
		
		.list a:hover {
		 	text-decoration: none;
		 	color:black;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container" style="margin-top: 130px;">
	<h2>SHOP</h2>
	<div class="menu mt-5">
		<c:set var="middleTitle" value="${middleTitleVOS}" />
	  <p>
	    <a href="${ctp}/product/productList">ALL</a> &nbsp;
    	<a href="${ctp}/product/productList?part=${middleTitleVOS[0].categoryMiddleCode}">CLOTHES</a> &nbsp;
	    <a href="${ctp}/product/productList?part=${middleTitleVOS[1].categoryMiddleCode}">WALK</a> &nbsp;
	    <a href="${ctp}/product/productList?part=${middleTitleVOS[2].categoryMiddleCode}">LIVING</a> &nbsp;
	    <a href="${ctp}/product/productList?part=${middleTitleVOS[3].categoryMiddleCode}">ACC.</a> &nbsp;
	    <a href="${ctp}/product/productList?part=${middleTitleVOS[4].categoryMiddleCode}">LAST PIECE</a>
	  </p>
  </div>
  
  <c:set var="cnt" value="0"/>
  <div class="row mt-4">
    <c:forEach var="vo" items="${productVOS}">
      <div class="list col-md-3">
        <div style="text-align:center" class="mt-1">
          <a href="${ctp}/product/productContentShop?idx=${vo.idx}">
            <c:set var="productImg" value="${fn:split(vo.FSName, '/')}" />
            <img src="${ctp}/product/${productImg[0]}" width="200px" height="180px"/>
            <div><font size="2">${vo.categorySubName} - ${vo.productName}</font></div>
            <hr style="margin: 3px;" />
            <div><font size="2" color="gray">${vo.detail}</font></div>
            <div class="mt-1"><font size="2" color="black"><b><fmt:formatNumber value="${vo.mainPrice}" pattern="#,###"/>원</b></font></div>
          </a>
        </div>
      </div>
      <c:set var="cnt" value="${cnt+1}"/>
      <c:if test="${cnt % 4 == 0}">
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
	  <button type="button" class="button button4" onclick="location.href='${ctp}/product/productCartList';">장바구니보러 가기</button>
  </div>
</div>

<!-- 블록페이징처리 시작 -->
<div class="container" style="text-align:center;">
<c:if test="${pageVO.totPage == 0}"><p style="text-align:center"><font color="red"><b>자료가 없습니다.</b></font></p></c:if>
<c:if test="${pageVO.totPage != 0}">
  <ul class="pagination justify-content-center">
	  <c:set var="startPageNum" value="${pageVO.pag - (pageVO.pag-1)%pageVO.blockSize}"/>
	  <c:if test="${pageVO.pag != 1}">
	    <li class="page-item"><a href="productList?pag=1&pageSize=${pageVO.pageSize}&part=${pageVO.part}" class="page-link" style="color:#666">◁◁</a></li>
	    <li class="page-item"><a href="productList?pag=${pageVO.pag-1}&pageSize=${pageVO.pageSize}&part=${pageVO.part}" class="page-link" style="color:#666">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="0" end="${pageVO.blockSize-1}">
	    <c:if test="${(startPageNum+i) <= pageVO.totPage}">
		  	<c:if test="${pageVO.pag == (startPageNum+i)}">
		  	  <li class="page-item active"><a href="productList?pag=${startPageNum+i}&pageSize=${pageVO.pageSize}&part=${pageVO.part}" class="page-link btn btn-secondary active" style="color:#666"><font color="#fff">${startPageNum+i}</font></a></li>
		  	</c:if>
		  	<c:if test="${pageVO.pag != (startPageNum+i)}">
		  	  <li class="page-item"><a href="productList?pag=${startPageNum+i}&pageSize=${pageVO.pageSize}&part=${pageVO.part}" class="page-link" style="color:#666">${startPageNum+i}</a></li>
		  	</c:if>
	  	</c:if>
	  </c:forEach>
	  <c:if test="${pageVO.pag != pageVO.totPage}">
	    <li class="page-item"><a href="productList?pag=${pageVO.pag+1}&pageSize=${pageVO.pageSize}&part=${pageVO.part}" class="page-link" style="color:#666">▶</a></li>
	    <li class="page-item"><a href="productList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}&part=${pageVO.part}" class="page-link" style="color:#666">▷▷</a></li>
	  </c:if>
  </ul>
</c:if>
</div>
<!-- 블록페이징처리 끝 -->

<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>