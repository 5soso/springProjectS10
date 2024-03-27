<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberMyPage.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  	h2 {
  		text-align: center;
  	}
  	.thumbnail {
  		hei
  	}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container" style="margin-top: 130px;">
	<h2>MY PAGE</h2>
	<table class="information" style="height:450px;">
		<tr>
			<td class="thumbnail" style="padding:20px;"><img src="${ctp}/images/member/thumbnail.gif" /></td>
			<td>
				<p>저희 쇼핑몰을 이용해 주셔서 감사합니다. 오소정 님은 <strong>[웰컴]</strong> 회원이십니다.</p>
				<p>마지막 접속일 : <strong>${fn:substring(vo.lastDate,0,10)}</strong></p>
				<p>현재 누적포인트 : <strong><fmt:formatNumber value="${vo.point}" />점</strong></p>
				<p><strong>[실버]</strong> 까지 남은 구매금액은 <strong><fmt:formatNumber value="${100000 - vo.point}" />원</strong> 입니다. (최근 3개월 동안 구매금액 : <strong><fmt:formatNumber value="${gumaeInfor}"/>원</strong>)</p>
				<p>승급 기준에 따른 예상 금액이므로 총주문 금액과 다를 수 있습니다.</p>
				<hr/>
				<div>
				  <table class="borderless text-center">
				    <tr>
				      <td style="padding:0px 20px;">
				        <a href="${ctp}/product/wishList"><img src="${ctp}/images/wishlist.jpg" width="100px" height="55px"/><br/><strong>WISHLIST</strong></a>
				      </td>
				      <td style="padding:0px 20px;">
				        <a href="${ctp}/product/productCartList?mid=${sMid}"><img src="${ctp}/images/bag.jpg" width="100px" height="55px"/><br/><strong>BAG</strong></a>
				      </td>
				      <td style="padding:0px 20px;">
				        <a href="${ctp}/product/productMyOrder"><img src="${ctp}/images/order.jpg" width="100px" height="55px"/><br/><strong>ORDER</strong></a>
				      </td>
				    </tr>
				  </table>
				</div>
				<hr/>
			<td>
		</tr>
	</table>
	
	
	
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>