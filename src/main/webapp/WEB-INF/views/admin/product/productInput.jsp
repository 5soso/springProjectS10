<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>productInput.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <script>
  'use strict';
  
  // 상품 등록하기전에 체크후 전송...
  function fCheck() {
  	let categoryMiddleCode = myform.categoryMiddleCode.value;
  	let categorySubCode = myform.categorySubCode.value;
  	let productName = myform.productName.value;
		let mainPrice = myform.mainPrice.value;
		let detail = myform.detail.value;
		let file = myform.file.value;	
		let ext = file.substring(file.lastIndexOf(".")+1);
		let uExt = ext.toUpperCase();
		let regExpPrice = /^[0-9|_]*$/;
		
		if(categorySubCode == "") {
			alert("상품 소분류(세분류)를 입력하세요!");
			return false;
		}
		else if(product == "") {
			alert("상품명(모델명)을 입력하세요!");
			return false;
		}
		else if(file == "") {
			alert("상품 메인 이미지를 등록하세요");
			return false;
		}
		else if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG") {
			alert("업로드 가능한 파일이 아닙니다.");
			return false;
		}
		else if(mainPrice == "" || !regExpPrice.test(mainPrice)) {
			alert("상품금액은 숫자로 입력하세요.");
			return false;
		}
		else if(detail == "") {
			alert("상품의 초기 설명을 입력하세요.");
			return false;
		}
		else if(document.getElementById("file").value != "") {
			var maxSize = 1024 * 1024 * 10;  // 10MByte까지 허용
			var fileSize = document.getElementById("file").files[0].size;
			if(fileSize > maxSize) {
				alert("첨부파일의 크기는 10MB 이내로 등록하세요");
				return false;
			}
			else {
				myform.submit();
			}
		}
  }
   
  // 중분류 선택시 소분류항목 가져오기
  function categoryMiddleChange() {
    	var categoryMiddleCode = myform.categoryMiddleCode.value;
			$.ajax({
				type : "post",
				url  : "${ctp}/product/categorySubName",
				data : {
					categoryMiddleCode : categoryMiddleCode
				},
				success:function(data) {
					var str = "";
					str += "<option value=''>소분류명을 선택하세요.</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].categorySubCode+"'>"+data[i].categorySubName+"</option>";
					}
					$("#categorySubCode").html(str);
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
<div class="container w3-main" style="margin-left:500px;margin-top:43px;">
  <h2>상품 등록하기</h2>
  <div id="product">
    <form name="myform" method="post" enctype="multipart/form-data">
      <div class="form-group">
	      <label for="categoryMiddleCode">중분류</label>
	      <select name="categoryMiddleCode" id="categoryMiddleCode" class="form-control" onchange="categoryMiddleChange()">
		      <option value="">중분류명을 선택하세요.</option>
		      <c:forEach var="middleVO" items="${middleVOS}">
		      	<option value="${middleVO.categoryMiddleCode}">${middleVO.categoryMiddleName}</option>
		      </c:forEach>
		    </select>
      </div>
      <div class="form-group">
        <label for="categorySubCode">소분류</label>
        <select id="categorySubCode" name="categorySubCode" class="form-control">
          <option value="">중분류명을 선택하세요.</option>
        </select>
      </div>
      <div class="form-group">
        <label for="productName">상품명(색상)</label>
        <input type="text" name="productName" id="productName" class="form-control" placeholder="상품 모델명을 입력하세요." required />
      </div>
      <div class="form-group">
        <label for="file">메인이미지</label>
        <input type="file" name="file" id="file" multiple class="form-control-file border" accept=".jpg,.gif,.png,.jpeg" required />
        (업로드 가능파일:jpg, jpeg, gif, png)
      </div>
      <div class="form-group">
      	<label for="mainPrice">상품 기본 가격</label>
      	<input type="text" name="mainPrice" id="mainPrice" class="form-control" required />
      </div>
      <div class="form-group">
      	<label for="detail">상품 기본 설명</label>
      	<input type="text" name="detail" id="detail" class="form-control" required />
      </div>
      <div class="form-group">
      	<label for="CKEDITOR">상품 상세 설명</label>
      	<textarea rows="5" name="content" id="CKEDITOR" class="form-control" required></textarea>
      </div>
      <script>
		    CKEDITOR.replace("content",{
		    	uploadUrl:"${ctp}/product/imageUpload",
		    	filebrowserUploadUrl: "${ctp}/product/imageUpload",
		    	height:460
		    });
		  </script>
		  <input type="button" value="상품등록" onclick="fCheck()" class="btn btn-secondary"/> &nbsp;
    </form>
  </div>
</div>
<p><br/></p>
</body>
</html>