<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>complaintList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  	h2 {
  		text-align: center;
  	}
  </style>
</head>
<jsp:include page="/WEB-INF/views/admin/adminNav.jsp" />
<p><br/></p>
<div class="container w3-main" style="margin-left:400px;margin-top:40px;">
	<h2>게시판 신고 목록</h2>
	<table class="table table-hover mt-5 text-center">
		<tr>
			<th>No.</th>
			<th>게시판</th>
			<th>신고글</th>
			<th>신고사유</th>
			<th>신고인</th>
			<th>비고</th>
		</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
		<tr>
			<td>${vo.idx}</td>
			<c:if test="${vo.part == 'review'}">			
				<td>리뷰 게시판</td>
			</c:if>
			<c:if test="${vo.part == 'QnA'}">			
				<td>QnA 게시판</td>
			</c:if>
			<td>글제목</td>
			<td>${vo.complaint}</td>
			<td>${vo.mid}</td>
			<td>
				<input type="button" value="비공개" onclick="complaintDelete()" class="btn btn-danger btn-sm" />
			</td>
		</tr>
		</c:forEach>
	</table>
</div>
<p><br/></p>
</body>
</html>