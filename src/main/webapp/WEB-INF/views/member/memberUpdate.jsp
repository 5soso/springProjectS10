<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberUpdate.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
    'use strict';
    
    // 아이디,연락처 중복버튼 클릭확인 변수
    let telCheckSw = 0;
    
    function fCheck() {
    	let regPwd = /(?=.*[0-9a-zA-Z]).{6,20}$/;
      let regName = /^[가-힣a-zA-Z]+$/;
      let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
    	let regTel = /\d{3}-\d{3,4}-\d{4}$/g;
    	
    	let pwd = myform.pwd.value;
    	let pwd2 = myform.pwd2.value;
    	let name = myform.name.value;
    	let email1 = myform.email1.value.trim();
    	let email2 = myform.email2.value;
    	let email = email1 + "@" + email2;
    	let tel1 = myform.tel1.value;
    	let tel2 = myform.tel2.value.trim();
    	let tel3 = myform.tel3.value.trim();
    	let tel = tel1 + "-" + tel2 + "-" + tel3;
    	let postcode = myform.postcode.value.trim();
    	let roadAddress = myform.roadAddress.value.trim();
    	let detailAddress = myform.detailAddress.value.trim();
    	
    	let submitFlag = 0;
    	
    	
    	// 앞의 정규식으로 정의된 부분에 대한 유효성체크
    	if(!regPwd.test(pwd)) {
        alert("비밀번호는 1개이상의 문자와 특수문자 조합의 6~20 자리로 작성해주세요.");
        myform.pwd.focus();
        return false;
      }
    	else if(pwd2.trim() != pwd.trim()){
    		alert("입력한 비밀번호가 같지 않습니다. 다시 확인하세요.");
    		myform.pwd2.focus();
    		return false;
    	}
      else if(!regName.test(name)) {
        alert("성명은 한글 또는 영문대소문자만 사용가능합니다.");
        myform.name.focus();
        return false;
      }
      else if(!regEmail.test(email)) {
        alert("이메일 형식에 맞지않습니다.");
        myform.email1.focus();
        return false;
      }
      else if(tel2.trim() == "" || tel3.trim() == "") {
    	  alert("휴대전화는 필수입력 사항입니다.");
    	  myfrom.tel2.focus();
    	  return false;
      }
      else if(postcode.trim()=="" || roadAddress.trim()=="") {
    	  alert("주소는 필수입력 사항입니다.");
    	  myform.postcode.focus();
    	  return false;
      }
    	
      if(tel2 != "" && tel3 != "") {
    	  if(!regTel.test(tel)) {
	    		alert("휴대전화 형식을 확인하세요.(010-1234-5678)");
	    		myform.tel2.focus();
	    		return false;
    	  }
    	  else {
    		  submitFlag = 1;
    	  }
    	}
    	else {		// 전화번호를 입력하지 않을시 DB에는 '010- - '의 형태로 저장하고자 한다.
    		tel2 = " ";
    		tel3 = " ";
    		tel = tel1 + "-" + tel2 + "-" + tel3;
    		submitFlag = 1;
    	}
    	
    	// 전송전에 '주소'를 하나로 묶어서 전송처리 준비한다.
    	postcode = myform.postcode.value + " ";
    	roadAddress = myform.roadAddress.value + " ";
    	detailAddress = myform.detailAddress.value + " ";
    	let extraAddress = myform.extraAddress.value + " ";
  		myform.address.value = postcode + "/" + roadAddress + "/" + extraAddress + "/" +  detailAddress + "/";
  		submitFlag = 1;
  		
    	// 전송전에 모든 체크가 끝나면 submitFlag가 1로 되게된다. 이때 값들을 서버로 전송처리한다.
    	if(submitFlag == 1) {
    		if(telCheckSw == 0) {
    			alert("휴대전화 확인 버튼을 눌러주세요!");
    			document.getElementById("telBtn").focus();
    		}
    		
    		else {
	    		myform.email.value = email;
	    		myform.tel.value = tel;
	    		//alert("email:"+email);
	    		
		    	myform.submit();
    		}
    	}
    	else {
    		alert("정보수정에 실패하였습니다. 수정 형식을 확인해주세요.");
    	}
    }
	
  // 연락처 중복체크
  function telCheck() {
	  let tempTel = '${vo.tel}';
	  let tel1 = myform.tel1.value;
  	let tel2 = myform.tel2.value.trim();
  	let tel3 = myform.tel3.value.trim();
  	let tel = tel1 + "-" + tel2 + "-" + tel3; 
  	
  	if(tempTel==tel) {
  		let str="";
		  str += '<div class="alert alert-success">';
		  str += '<strong>사용 가능한 번호입니다.</strong>';
		  str += '</div>';
		  $("#telDemo").html(str);
  		
  		telCheckSw = 1;
  		return false;
  	}
  	
  	$.ajax({
	  	type  : "post",
			url   : "${ctp}/member/memberTelCheck",
			data  : {tel : tel},
			success:function(res) {
				if(res == "1") {
					alert("이미 가입된 번호입니다. 다시 입력하세요.");
					myform.tel2.focus();
					telCheckSw = 0;
					return false;
				}
				else if(tel.trim() == "" || tel2.length < 3 || tel3.length < 4) {
					//alert("휴대전화 가입 형식을 확인하세요.(010-1234-5678)");
					
					let str="";
				  str += '<div class="alert alert-danger">';
				  str += '<strong>휴대전화 형식을 확인하세요(010-1234-5678) </strong>';
				  str += '</div>';
				  $("#telDemo").html(str);
					
					telCheckSw = 0;
					myform.tel2.focus();
					return false;
				}
				else {
					telCheckSw = 1;
					
					let str="";
				  str += '<div class="alert alert-success">';
				  str += '<strong>사용 가능한 번호입니다.</strong>';
				  str += '</div>';
				  $("#telDemo").html(str);
					
	    		myform.postcode.focus();
				}
			},
			error : function() {
				alert("전송오류!");
			}
  	});
  } 
  
  function memberDelete() {
	  let res = confirm("회원탈퇴하시겠습니까? \n탈퇴후 적립금과 쿠폰은 소멸됩니다.");
	  
	  if(!res) return false;
	  
	  location.href='memberDelete';
  }
  </script>
  <style>
  	#allCheck {font-size: 14pt;}
		.accordion {
		  background-color: #eee;
		  color: #444;
		  cursor: pointer;
		  padding: 18px;
		  width: 100%;
		  border: none;
		  text-align: left;
		  outline: none;
		  font-size: 15px;
		  transition: 0.4s;
		  font-weight: bold;
		}
		.active, .accordion:hover {
		  background-color: #ccc; 
		}
		.panel {
		  padding: 0 18px;
		  display: none;
		  background-color: white;
		  height: 200px;
		  overflow: auto;
		  font-size: 9pt;
		}
		span {
			font-weight: bolder;
		}
		td {
			text-align: center;
		}
		#levelInfo {
			line-height: 70px;
			font-size: 14pt;
		}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container" style="margin-top: 130px;">
  <form name="myform" method="post" class="was-validated">
    <h2 style="text-align: center" class="mb-5">회원 정보 수정</h2>
    <div>
			<table class="table table-bordered">
				<tr>
					<td style="width: 10%;"><img src="${ctp}/member/img_member_default.gif" /></td>
					<td id="levelInfo">저희 쇼핑몰을 이용해주셔서 감사합니다. <span>${vo.name}</span>님은 <span>[${strLevel}]</span>회원입니다.</td>
				</tr>
			</table>
		</div>
		<br/>
    <h3>기본 정보</h3>
    <div class="form-group mt-4">
      <p>아이디</p>
      <input type="text" class="form-control" name="mid" id="mid" value="${vo.mid}" readonly />
    </div>
    <div id="midDemo"></div>
    <div class="form-group">
      <label for="pwd">비밀번호 (영문 대소문자/숫자/특수기호, 6~20자리)</label>
      <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" required />
    </div>
    <div class="form-group">
      <label for="pwd">비밀번호 확인</label>
      <input type="password" class="form-control" id="pwd2" name="pwd2" placeholder="비밀번호를 입력하세요." required />
    </div>
    <div class="form-group">
      <label for="name">성명</label>
      <input type="text" class="form-control" name="name" id="name" value="${vo.name}" placeholder="성명을 입력하세요." required />
    </div>
    <div class="form-group">
        <div class="input-group mb-3">
          <c:set var="email" value="${fn:split(vo.email,'@')}" /> 
          <input type="text" class="form-control" value="${email[0]}" id="email1" name="email1" required />
          <div class="input-group-append">
            <select name="email2" class="custom-select">
              <option value="naver.com"   ${email[1]=='naver.com' ? 'selected' : ''}>naver.com</option>
              <option value="daum.net"    ${email[1]=='daum.net' ? 'selected' : ''}>daum.net</option>
              <option value="kakao.com"   ${email[1]=='kakao.com' ? 'selected' : ''}>kakao.com</option>
              <option value="gmail.com"   ${email[1]=='gmail.com' ? 'selected' : ''}>gmail.com</option>
              <option value="hanmail.net" ${email[1]=='hanmail.net' ? 'selected' : ''}>hanmail.net</option>
              <option value="hotmail.com" ${email[1]=='hotmail.com' ? 'selected' : ''}>hotmail.com</option>
              <option value="nate.com"    ${email[1]=='nate.com' ? 'selected' : ''}>nate.com</option>
              <option value="yahoo.com"   ${email[1]=='yahoo.com' ? 'selected' : ''}>yahoo.com</option>
            </select>
          </div>
        </div>
    </div>
    <div id="emailDemo" class="mb-3"></div>
    <div class="form-group">
      <div class="input-group mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text">휴대전화</span> &nbsp;&nbsp;
            <c:set var="tel" value="${fn:split(vo.tel,'-')}" />
            <select name="tel1" class="custom-select" required>
              <option value="010" ${tel[0]=='010' ? 'selected' : ''}>010</option>
              <option value="011" ${tel[0]=='011' ? 'selected' : ''}>011</option>
              <option value="016" ${tel[0]=='016' ? 'selected' : ''}>016</option>
              <option value="017" ${tel[0]=='017' ? 'selected' : ''}>017</option>
              <option value="018" ${tel[0]=='018' ? 'selected' : ''}>018</option>
              <option value="019" ${tel[0]=='019' ? 'selected' : ''}>019</option>
            </select>-
        </div>
        <input type="text" name="tel2" value="${tel[1]}" size=2 maxlength=4 class="form-control" required />-
        <input type="text" name="tel3" value="${tel[2]}" size=2 maxlength=4 class="form-control" required />
        <input type="button" value="확인" id="telBtn" class="btn btn-secondary btn-sm ml-2 " onclick="telCheck()"/>
      </div>
      <div id="telDemo"></div>
    </div>
    <div class="form-group">
      <label for="sample6_postcode">주소</label>
      <c:set var="address" value="${fn:split(vo.address, '/')}" />
      <div class="input-group mb-1">
        <input type="text" name="postcode" id="sample6_postcode" value="${fn:trim(address[0])}" class="form-control" required>
        <div class="input-group-append">
          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
        </div>
      </div>
      <input type="text" name="roadAddress" id="sample6_address" size="50" value="${fn:trim(address[1])}" class="form-control mb-1" required>
      <div class="input-group mb-1">
        <input type="text" name="extraAddress" id="sample6_extraAddress" value="${fn:trim(address[2])}" class="form-control" required>
        <div class="input-group-append">
	        <input type="text" name="detailAddress" id="sample6_detailAddress" value="${fn:trim(address[3])}" class="form-control"> &nbsp;&nbsp;
        </div>
      </div>
    </div>
    <hr/>
    <div class="form-group mt-5">
	    <h4 class="mb-3">추가 정보</h4>
      <label for="birthday">반려동물 생일</label>
      <input type="date" name="birthday" id="birthday" value="${fn:substring(vo.birthday,0,10)}" class="form-control"/>
    </div>
    
    <hr/>
  
    <div class="w3-center" style="margin-top: 50px; margin-bottom: 30px;">
	    <button type="button" class="btn btn-secondary" onclick="fCheck()">회원정보수정</button> &nbsp;
	    <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/';">취소</button>
	    <button type="button" class="btn btn-danger w3-right" onclick="memberDelete()">회원탈퇴</button>
    </div>
  <input type="hidden" name="email" />
  <input type="hidden" name="tel" />
  <input type="hidden" name="address" />
	</form>
</div>

<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
	var acc = document.getElementsByClassName("accordion");
	var i;
	
	for (i = 0; i < acc.length; i++) {
	  acc[i].addEventListener("click", function() {
	    this.classList.toggle("active");
	    var panel = this.nextElementSibling;
	    if (panel.style.display === "block") {
	      panel.style.display = "none";
	    } else {
	      panel.style.display = "block";
	    }
	  });
	}
</script>
</body>
</html>