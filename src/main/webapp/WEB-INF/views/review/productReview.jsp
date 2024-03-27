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
  
  <title>productReview.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use strict';
  
  	function reviewSearch() {
  		let reviewSearch = $("#reviewSearch").val().trim();
  		
  		if(reviewSearch === "") {
  			alert("검색어를 입력하세요!");
  			return false;
  		}
  		
  		location.href='reviewSearch?reviewSearch='+reviewSearch;
  	}
  	
  	// 리뷰 정렬
  	function reviewChange() {
  		let reviewChange = $("#reviewChange").val();
  		location.href='productReview?reviewChange='+reviewChange;
  	}
  	
  	// 리뷰 신고창 띄우기
  	function reportReview(idx,content,mid) {
  		// document.getElementById('myModal').style.display = 'flex'; //toggle 사용하지 않을 때 모달창 여는법
			$(".modal-body #content").html(content);
			$(".modal-body #mid").html(mid);
			$(".modal-body #idx").val(idx);
  	}

  	
    // 신고시 '기타'텍스트항목 보여주기
    function etcShow() {
    	$("#complaintTxt").show();
    }
    
    // 리뷰 신고처리
    function complaintCheck() {
    	if (!$("input[type=radio][name=complaint]:checked").is(':checked')) {
        alert('신고항목을 선택하세요');
        return false;
      }
    	if($("input[type=radio][id=complaint7]:checked").val() == 'on' && $("#complaintTxt").val() == "") {
        alert("기타 사유를 입력해 주세요.");
        return false;
    	}
    	
    	let mid = '${sMid}';
    	let part = 'review';
    	let idx = $("#idx").val();
      let content = modalForm.complaint.value;
      if(content == '기타') content += "/" + $("#complaintTxt").val();
			
      $.ajax({
    	  url  : "${ctp}/complaint/reviewComplaintInput",
    	  type : "post",
    	  data : {
    		  mid : mid,
    		  idx : idx,
    		  part : part,
    		  complaint : content
    	  },
    	  success:function(res) {
    		  if(res == "1") {
    			  alert("신고 되었습니다.");
    			  location.reload();
    		  }
    		  else alert('신고 실패~~');
    	  },
    	  error : function() {
    		  alert('전송오류!');
    	  }
      });
    }
  </script>
  <style>
  	h2 {
  		text-align: center;
  	}
  	#reviewSearch {
  		background-color: #eee;
  		border: 1px solid #ddd;
  	}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container" style="margin-top: 130px;">
  <h2><a href="productReview">REVIEW</a></h2>
  <div class="mt-5 mb-3"><b>상품평수 : 총 ${reviewTotalCount}개</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="text" name="reviewSearch" id="reviewSearch" size="15" placeholder="검색어를 입력하세요." />
		<input type="button" value="검색" onclick="reviewSearch()" class="btn btn-secondary btn-sm"/>
		<select name="reSelect" id="reviewChange" class="w3-right" onchange="reviewChange()">
			<option value="recent" ${reviewChange == 'recent' ? 'selected':''}>최신순</option>
			<option value="star"   ${reviewChange == 'star' ? 'selected':''}>별점순</option>
			<%-- <option value="like"   ${reviewChange == 'like' ? 'selected':''}>추천순</option> --%>
		</select>
  </div>
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
	    						<c:if test="${!empty vo.reImage}">
			    					<td><img src="${ctp}/review/${vo.reImage}" width="80px" height="80px"/></td>
	    						</c:if>
		    				</tr>
		    				<tr>
		    					<td>
		    						<c:if test="${sMid != null}">
		    						  <%-- <c:set var="content" value="${fn:replace}"/> --%>
		    							<a href="#" onclick="reportReview('${vo.idx}','${vo.content}','${vo.mid}')" data-target="#myModal" data-toggle="modal" style="font-size: 8pt;"><i class="fa fa-warning" style="color: red;"></i> 신고</a>
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
</div>
<!-- 블록페이징처리 시작 -->
<div class="container" style="text-align:center;">
<c:if test="${pageVO.totPage == 0}"><p style="text-align:center"><font color="red"><b>자료가 없습니다.</b></font></p></c:if>
<c:if test="${pageVO.totPage != 0}">
  <ul class="pagination justify-content-center">
	  <c:set var="startPageNum" value="${pageVO.pag - (pageVO.pag-1)%pageVO.blockSize}"/>
	  <c:set var="startPageNum" value="${pageVO.pag - (pageVO.pag-1)%pageVO.blockSize}"/>
	  <c:if test="${pageVO.pag != 1}">
	    <li class="page-item"><a href="productReview?pag=1&pageSize=${pageVO.pageSize}&reviewChange=${reviewChange}" class="page-link" style="color:#666">◁◁</a></li>
	    <li class="page-item"><a href="productReview?pag=${pageVO.pag-1}&pageSize=${pageVO.pageSize}&reviewChange=${reviewChange}" class="page-link" style="color:#666">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="0" end="${pageVO.blockSize-1}">
	    <c:if test="${(startPageNum+i) <= pageVO.totPage}">
		  	<c:if test="${pageVO.pag == (startPageNum+i)}">
		  	  <li class="page-item active"><a href="productReview?pag=${startPageNum+i}&pageSize=${pageVO.pageSize}&reviewChange=${reviewChange}" class="page-link btn btn-secondary active" style="color:#666"><font color="#fff">${startPageNum+i}</font></a></li>
		  	</c:if>
		  	<c:if test="${pageVO.pag != (startPageNum+i)}">
		  	  <li class="page-item"><a href="productReview?pag=${startPageNum+i}&pageSize=${pageVO.pageSize}&reviewChange=${reviewChange}" class="page-link" style="color:#666">${startPageNum+i}</a></li>
		  	</c:if>
	  	</c:if>
	  </c:forEach>
	  <c:if test="${pageVO.pag != pageVO.totPage}">
	    <li class="page-item"><a href="productReview?pag=${pageVO.pag+1}&pageSize=${pageVO.pageSize}&reviewChange=${reviewChange}" class="page-link" style="color:#666">▶</a></li>
	    <li class="page-item"><a href="productReview?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}&reviewChange=${reviewChange}" class="page-link" style="color:#666">▷▷</a></li>
	  </c:if>
  </ul>
</c:if>
</div>
<!-- 블록페이징처리 끝 -->

<!-- The Modal -->
<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title"><b>사용자 신고</b></h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
      	<div class="card p-2 mb-2" style="background-color: #ddd">
      		<div id="mid"></div>
	        <div id="content"></div>
	        <!-- <div style="display: none;" id="idx"></div> -->
        </div>
        
        <div class="mt-3" style="font-size: 12pt;">
        	<p style="font-size: 12pt; font-weight: bold;">신고하시는 사유가 무엇인가요?<span style="color: gray;"> (필수)</span></p>
        	<form name="modalForm">
	          <div class="form-check"><input type="radio" name="complaint" id="complaint1" value="욕설/비방/차별/혐오" class="form-check-input"/>욕설/비방/차별/혐오</div>
	          <div class="form-check"><input type="radio" name="complaint" id="complaint2" value="홍보/영리목적" class="form-check-input"/>홍보/영리목적</div>
	          <div class="form-check"><input type="radio" name="complaint" id="complaint3" value="불법정보" class="form-check-input"/>불법정보</div>
	          <div class="form-check"><input type="radio" name="complaint" id="complaint4" value="음란/청소년유해" class="form-check-input"/>음란/청소년유해</div>
	          <div class="form-check"><input type="radio" name="complaint" id="complaint5" value="개인정보노출/유포/거래" class="form-check-input"/>개인정보노출/유포/거래</div>
	          <div class="form-check"><input type="radio" name="complaint" id="complaint6" value="도배/스팸" class="form-check-input"/>도배/스팸</div>
	          <div class="form-check"><input type="radio" name="complaint" id="complaint7" value="기타" class="form-check-input" onclick="etcShow()"/>기타</div>
	          <div id="etc"><textarea rows="2" name="complaintTxt" id="complaintTxt" class="form-control" style="display:none;"></textarea></div>
		       <input type="button" onclick="complaintCheck()" value="신고하기" class="btn btn-danger form-control mt-3" />
           <%-- <input type="hidden" name="mid" id="mid" value="${sMid}" /> --%><!--신고자아이디 -->
           <!-- <input type="hidden" name="part" id="part" value="review" /> -->
           <input type="hidden" name="idx" id="idx" />
        	</form>
        </div>
        
        <div class="text-center">
      	</div>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
			<!--  <button type="button" class="btn btn-danger" onclick="document.getElementById('myModal').style.display = 'none';" data-dismiss="modal">Close</button> -->
         <button type="button" class="btn btn-danger" data-dismiss="modal" style="background-color: black; border: black;">취소</button>
      </div>
      
    </div>
  </div>
</div>

<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>