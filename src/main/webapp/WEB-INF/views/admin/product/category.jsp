<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>category.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';

    // 중분류 등록하기
    function categoryMiddleCheck() {
    	let categoryMiddleCode = categoryMiddleForm.categoryMiddleCode.value;
    	let categoryMiddleName = categoryMiddleForm.categoryMiddleName.value;
    	if(categoryMiddleCode.trim() == "" || categoryMiddleName.trim() == "") {
    		alert("중분류명(코드)를 입력하세요");
    		categoryMiddleForm.categoryMiddleName.focus();
    		return false;
    	}
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/product/categoryMiddleInput",
    		data : {
    			categoryMiddleCode : categoryMiddleCode,
    			categoryMiddleName : categoryMiddleName
    		},
    		success:function(res) {
    			if(res == "0") alert("같은 상품이 등록되어 있습니다.\n확인하시고 다시 입력하세요");
    			else {
    				alert("중분류가 등록되었습니다.");
    				location.reload();
    			}
    		},
  			error: function() {
  				alert("전송오류!");
  			}
    	});
    }
    
    // 소분류 등록하기
    function categorySubCheck() {
    	let categoryMiddleCode = categorySubForm.categoryMiddleCode.value;
    	let categorySubCode = categorySubForm.categorySubCode.value;
    	let categorySubName = categorySubForm.categorySubName.value;
    	if(categoryMiddleCode.trim() == "" || categorySubCode.trim() == "" || categorySubName.trim() == "") {
    		alert("소분류명(코드)를 입력하세요");
    		categorySubForm.categorySubName.focus();
    		return false;
    	}
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/product/categorySubInput",
    		data : {
    			categoryMiddleCode : categoryMiddleCode,
    			categorySubCode : categorySubCode,
    			categorySubName : categorySubName
    		},
    		success:function(res) {
    			if(res == "0") alert("같은 상품이 등록되어 있습니다.\n확인하시고 다시 입력하세요");
    			else {
    				alert("소분류가 등록되었습니다.");
    				location.reload();
    			}
    		},
  			error: function() {
  				alert("전송오류!");
  			}
    	});
    }
    
    // 중분류 삭제하기
    function categoryMiddleDelete(categoryMiddleCode) {
    	let ans = confirm("중분류항목을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/product/categoryMiddleDelete",
    		data : {categoryMiddleCode : categoryMiddleCode},
    		success:function(res) {
    			if(res == "0") {
    				alert("하위항목이 있기에 삭제할수 없습니다.\n하위항목을 먼저 삭제해 주세요.");
    			}
    			else {
    				alert("중분류 항목이 삭제 되었습니다.");
    				location.reload();
    			}
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 소분류 삭제하기
    function categorySubDelete(categoryMiddleCode, categorySubCode) {
    	let ans = confirm("소분류항목을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/product/categorySubDelete",
    		data : {
    			categoryMiddleCode : categoryMiddleCode,
    			categorySubCode : categorySubCode
    		},
    		success:function(res) {
    			if(res == "0") {
    				alert("하위항목이 있기에 삭제할수 없습니다.\n하위항목을 먼저 삭제해 주세요.");
    			}
    			else {
    				alert("소분류 항목이 삭제 되었습니다.");
    				location.reload();
    			}
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/adminNav.jsp" />
<p><br/></p>
<div class="container w3-main" style="margin-left:300px;margin-top:43px;">
  <h3>상품 분류 등록하기 - 중분류/소분류</h3>
  <hr/>
	<div class="text-center">
	  <form name="categoryMiddleForm">
	    <h4><b>중분류(상품분류) 관리(문자 1자리)</b></h4>
	    중분류코드(A,B,C...)
	    <input type="text" name="categoryMiddleCode" size="2" maxlength="1"/>, &nbsp;
	    중분류명
	    <input type="text" name="categoryMiddleName" size="8"/> &nbsp;
	    <input type="button" value="중분류등록" onclick="categoryMiddleCheck()" class="btn btn-success btn-sm" />
	    <table class="table table-hover m-3">
	      <tr class="table-dark text-dark text-center">
	        <th>중분류코드</th>
	        <th>중분류명</th>
	        <th>삭제</th>
	      </tr>
	      <c:forEach var="middleVO" items="${middleVOS}">
	        <tr class="text-center">
	          <td>${middleVO.categoryMiddleCode}</td>
	          <td>${middleVO.categoryMiddleName}</td>
	          <td><input type="button" value="삭제" onclick="categoryMiddleDelete('${middleVO.categoryMiddleCode}')" class="btn btn-danger btn-sm"/></td>
	        </tr>
	      </c:forEach>
	      <tr><td colspan="3" class="m-0 p-0"></td></tr>
	    </table>
	  </form>
	  <hr/><br/>
	  <form name="categorySubForm">
	    <h4><b>소분류(상품군) 관리(코드는 숫자 2자리)</b></h4>
	    중분류선택
	    <select name="categoryMiddleCode" id="categoryMiddleCode">
	      <option value="">중분류명</option>
	      <c:forEach var="middleVO" items="${middleVOS}">
	      	<option value="${middleVO.categoryMiddleCode}">${middleVO.categoryMiddleName}</option>
	      </c:forEach>
	    </select> &nbsp;
	    소분류코드(01,02,03,...)
	    <input type="text" name="categorySubCode" size="2" maxlength="2"/>, &nbsp;
	    소분류명
	    <input type="text" name="categorySubName" size="8"/> &nbsp;
	    <input type="button" value="소분류등록" onclick="categorySubCheck()" class="btn btn-success btn-sm" />
	    <table class="table table-hover m-3">
	      <tr class="table-dark text-dark text-center">
	        <th>소분류코드</th>
	        <th>소분류명</th>
	        <th>중분류명</th>
	        <th>삭제</th>
	      </tr>
	      <c:forEach var="subVO" items="${subVOS}">
	        <tr class="text-center">
	          <td>${subVO.categorySubCode}</td>
	          <td>${subVO.categorySubName}</td>
	          <td>${subVO.categoryMiddleName}</td>
	          <td><input type="button" value="삭제" onclick="categorySubDelete('${subVO.categoryMiddleCode}','${subVO.categorySubCode}')" class="btn btn-danger btn-sm"/></td>
	        </tr>
	      </c:forEach>
	      <tr><td colspan="4" class="m-0 p-0"></td></tr>
	    </table>
	  </form>
  </div>
</div>
<p><br/></p>
</body>
</html>