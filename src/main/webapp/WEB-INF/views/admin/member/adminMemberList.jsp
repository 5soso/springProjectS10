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
  <title>adminMemberList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
	
		function modalView(idx,mid,name,tel,email,address,birthday,strLevel,point,userCancel,visitCount,lastDate) {
			birthday = birthday.substring(0,10);
			lastDate = lastDate.substring(0,10);
			
    	$(".modal-title #mid").html(mid);
    	$(".modal-body #name").html(name);
    	$(".modal-body #tel").html(tel);
    	$(".modal-body #email").html(email);
    	$(".modal-body #address").html(address);
    	$(".modal-body #birthday").html(birthday);
    	$(".modal-body #level").html(strLevel);
    	$(".modal-body #point").html(point);
    	$(".modal-body #userCancel").html(userCancel);
    	$(".modal-body #visitCount").html(visitCount);
    	$(".modal-body #lastDate").html(lastDate);
		}
		
		// 회원 등급 수정
		function searchCheck(e) {
    	let ans = confirm("등급을 수정하시겠습니까?");
    	if(!ans) return false;
    	
    	let items = e.value.split("/");
    	
    	let query = {
    			idx : items[1],
    			level : items[0]
    	}
    	
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/admin/member/adminMemberLevel",
    		data  : query,
    		success:function(res) {
    			if(res == "1") alert("등급 수정완료!");
    			else alert("등급 수정실패~~");
    			location.reload();
    		},
    		error : function() {
    			alert("전송 오류~~");
    		}
    	});
    }
	</script>
	<style>
		h2, th, td {
			text-align: center;
		}
		.modalTable>tr>th {
			text-align: left;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/adminNav.jsp" />
<p><br/></p>
<div class="container w3-main" style="margin-left:400px;margin-top:40px;">
	<h2>회원 정보 조회</h2>
	<table class="table table-hover mt-5">
		<tr>
			<th>No.</th>
			<th>아이디</th>
			<th>성명</th>
			<th>연락처</th>
			<th>이메일</th>
			<th>최근방문일</th>
			<th>회원등급</th>
			<th>탈퇴신청유무</th>
			<th>상세보기</th>
		</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<c:if test="${vo.level == '0'}"><c:set var="strLevel" value="관리자" /></c:if>
		  <c:if test="${vo.level == '1'}"><c:set var="strLevel" value="VIP" /></c:if>
		  <c:if test="${vo.level == '2'}"><c:set var="strLevel" value="Sliver" /></c:if>
		  <c:if test="${vo.level == '3'}"><c:set var="strLevel" value="일반회원" /></c:if>
			<tr>
				<td>${st.count}</td>
				<td>${vo.mid}</td>
				<td>${vo.name}</td>
				<td>${vo.tel}</td>
				<td>${vo.email}</td>
				<c:set var="lastDate" value="${fn:substring(vo.lastDate,0,10)}" />
					<td>${lastDate}</td>
				<td>
					 <form name="levelForm">
            <select name="level" onchange="searchCheck(this)">
              <option value="0/${vo.idx}" <c:if test="${vo.level==0}">selected</c:if>>관리자</option>
              <option value="1/${vo.idx}" <c:if test="${vo.level==1}">selected</c:if>>VIP</option>
              <option value="2/${vo.idx}" <c:if test="${vo.level==2}">selected</c:if>>Sliver</option>
              <option value="3/${vo.idx}" <c:if test="${vo.level==3}">selected</c:if>>일반회원</option>
            </select>
          </form>
				</td>	
				<c:if test="${vo.userCancel=='OK'}">
					<td style="color: red; font-weight:bolder;">탈퇴신청</td>
				</c:if>
				<c:if test="${vo.userCancel!='OK'}">
					<td style="color: gray">미탈퇴</td>
				</c:if>
				<td>
					<a href="#" onclick="modalView('${vo.idx}','${vo.mid}','${vo.name}','${vo.tel}','${vo.email}','${vo.address}','${vo.birthday}','${strLevel}','${vo.point}','${vo.userCancel}','${vo.visitCount}','${vo.lastDate}')" data-target="#myModal" data-toggle="modal"><i class="fa fa-exclamation-circle" style="font-size:24px"></i></a>
				</td>
			</tr>
		</c:forEach>	
	</table>
</div>

<!-- The Modal -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
    
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title"><span id="mid"></span>님의 회원정보</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
      	<table class="modalTable table table-border">
      		<tr>
	      		<th>이름</th>
	      		<td><span id="name"></span></td>
	      	</tr>	
      		<tr>
	      		<th>연락처</th>
	      		<td><span id="tel"></span></td>
	      	</tr>	
      		<tr>
	      		<th>이메일</th>
	      		<td><span id="email"></span></td>
	      	</tr>	
      		<tr>
	      		<th>주소</th>
	      		<td><span id="address"></span></td>
	      	</tr>	
      		<tr>
	      		<th>반려동물생일</th>
	      		<td><span id="birthday"></span></td>
	      	</tr>	
      		<tr>
	      		<th>레벨</th>
	      		<td><span id="level"></span></td>
	      	</tr>	
      		<tr>
	      		<th>가용포인트</th>
	      		<td><span id="point"></span></td>
	      	</tr>	
      		<tr>
	      		<th>보유쿠폰</th>
	      		<td>쿠폰</td>
	      	</tr>	
      		<tr>
	      		<th>방문횟수</th>
	      		<td><span id="visitCount"></span></td>
	      	</tr>	
      		<tr>
	      		<th>최근접속일</th>
	      		<td><span id="lastDate"></span></td>
	      	</tr>	
      		<tr>
	      		<th>회원탈퇴신청여부</th>
	      		<td><span id="userCancel"></span></td>
	      	</tr>	
      	</table>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
      
    </div>
  </div>
</div>
<p><br/></p>
</body>
</html>