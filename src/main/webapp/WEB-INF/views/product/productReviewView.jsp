<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>productReviewView.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';
    
    function reviewCheck(count) {
    	//let star = $("#star"+count).val();
    	let reStar = reviewForm.star.value;
    	let content = $("#content"+count).val();
    	let productCode = $("#productCode"+count).val();
    	let productName = $("#productName"+count).val();
    	let orderIdx = $("#orderIdx"+count).val();
    	let dogSize = $("#dogSize"+count).val();
    	let dogWeight = $("#dogWeight"+count).val();
    	
    	if(reStar == "") {
    		alert("별점을 부여해 주세요");
    		return false;
    	}
    	else if(content == "") {
    		alert("리뷰를 작성해 주세요");
    		$("#content"+count).focus();
    		return false;    		
    	}
    	
    	let formData = new FormData();
    	formData.append("reImg", $("#reImage"+count)[0].files[0]);	// 업로드파일 변수명(reImg)과 vo의 필드명을 다르게 작성해야 한다.(중요)
      formData.append("mid", '${sMid}');
      formData.append("reStar", reStar);
      formData.append("content", content);
      formData.append("productCode", productCode);
      formData.append("productName", productName);
      formData.append("orderIdx", orderIdx);
      formData.append("dogSize", dogSize);
      formData.append("dogWeight", dogWeight);
    	/*
    	let query = {
    			mid     : '${sMid}',
    			star    : star,
    			content : content,
    			productCode: productCode,
    			productName: productName,
    			orderIdx: orderIdx
    	}
    	*/
    	
    	$.ajax({
    		url  : "${ctp}/product/productReviewView",
    		type : "post",
    		dataType: "text",
    		processData: false,
    		contentType:false,
    		//data : query,
    		data : formData,
    		success:function(res) {
    			if(res == "1") {
    				alert("리뷰가 등록되었습니다.");
    				location.reload();
    			}
    			else alert("리뷰 등록 실패~~");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
  </script>
  <style>
    th {
      background-color: #eee;
    }
    
    /* 별점 스타일 설정하기 */
    #starForm fieldset {
      direction: rtl;
    }
    #starForm input[type=radio] {
      display:none;
    }
    #starForm label {
      font-size: 1.6em;
      color: transparent;
      text-shadow: 0 0 0 #e0e0e0;
    }
    #starForm label:hover {
      text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
    }
    #starForm label:hover ~ label {
    	text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
    }
    #starForm input[type=radio]:checked ~ label {
    	text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
    }
  </style>
</head>
<body>
<p><br/></p>
<div class="container">
  <h3 class="text-center">리뷰 쓰기</h3>
  <hr/>
  <form name="reviewForm" method="post" enctype="multipart/form-data">
	  <c:forEach var="vo" items="${vos}" varStatus="st">
		  <div class="row">
			  <c:set var="productImg" value="${fn:split(vo.thumbImg, '/')}" />
			  <div class="col-2"><img src="${ctp}/product/${productImg[0]}" width="80px" height="80px"/></div>
			  <span class="col-10 pl-3">
			    <font size="4">${vo.categorySubName} - ${vo.productName}</font><br/>
			    <fmt:formatNumber value="${vo.mainPrice}"/>원
			  </span>
	  	</div>
	    <c:if test="${empty vo.reviewOk}">
		  	<div id="starForm">
		  		상품은 만족하셨나요?
		  	  <fieldset style="border:0px;">
		    	  <div class="text-left viewPoint m-0 b-0">
		    	    <input type="radio" name="star" value="5" id="star1${st.count}"><label for="star1${st.count}">★</label>
		    	    <input type="radio" name="star" value="4" id="star2${st.count}"><label for="star2${st.count}">★</label>
		    	    <input type="radio" name="star" value="3" id="star3${st.count}"><label for="star3${st.count}">★</label>
		    	    <input type="radio" name="star" value="2" id="star4${st.count}"><label for="star4${st.count}">★</label>
		    	    <input type="radio" name="star" value="1" id="star5${st.count}"><label for="star5${st.count}">★</label>
		    	  </div>
		  	  </fieldset>
		  	</div>
		  	<div class="input-group mb-3">
			  	<div class="input-group-prepend mr-3" style="font-size: 10pt;">(선택)평소 사이즈</div>
			      <select name="dogSize" class="form-control mr-4" id="dogSize${st.count}" style="font-size: 10pt;">
			      	<option>S</option>
			      	<option>M</option>
			      	<option>L</option>
			      	<option>2L</option>
			      	<option>3L</option>
			      	<option>4L</option>
			      	<option>5L</option>
			      	<option>6L</option>
			      </select>
		  	</div>
		  	<div class="mb-3" style="font-size: 10pt;">
		  		(선택)반려견 몸무게 
		  		<input type="number" name="dogWeight" id="dogWeight${st.count}" class="from-contorl mr-1" />kg
		  	</div>
		  	<div>
		  		<textarea rows="3" name="content" id="content${st.count}" class="form-control" placeholder="최소 10자이상 입력해주세요."></textarea> 
		  	</div>
		  	<br/>
		  	<input type="file" name="reImage1" id="reImage${st.count}" />
			  <input type="button" value="등록" onclick="reviewCheck(${st.count})" />
			  <input type="button" value="취소" onclick="window.close()" />
		  	<hr size="10px" class="border">
	  	</c:if>
	  	<c:if test="${!empty vo.reviewOk}">
	  	  <div class="text-center text-info">리뷰를 작성하셨습니다.</div>
	  	</c:if>
	  	<hr class="p-2"/>
	  	<input type="hidden" name="productCode" id="productCode${st.count}" value="${vo.productCode}"/>
	  	<input type="hidden" name="productName" id="productName${st.count}" value="${vo.productName}"/>
	  	<input type="hidden" name="orderIdx"    id="orderIdx${st.count}"    value="${vo.orderIdx}"/>
	  </c:forEach>
  </form>
  <div class="text-center m-0 p-0"><input type="button" value="창닫기" onclick="window.close()" class="btn btn-success"/></div>
</div>
<p><br/></p>
</body>
</html>