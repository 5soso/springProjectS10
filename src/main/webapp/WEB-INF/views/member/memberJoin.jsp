<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberJoin.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
  <script>
  	// 카카오로그인을 위한 자바스크립트 앱키 등록하기
	  window.Kakao.init("dad8f37ec6bdcb4a3aa33f4ec83986a8");
	  
		function kakaoLogin() {
			// 카카오에 인증요청 처리하기
			window.Kakao.Auth.login({
				scope: 'account_email,profile_nickname',
				success:function(autoObj) {
					console.log(Kakao.Auth.getAccessToken(), '정상 토큰 발급됨');
					window.Kakao.API.request({
						url : "/v2/user/me",
						success:function(res) {
							const kakao_account = res.kakao_account;
							console.log(kakao_account);
							location.href = "${ctp}/member/kakaoLogin?nickName="+kakao_account.profile.nickname+"&email="+kakao_account.email+"&accessToken="+Kakao.Auth.getAccessToken();
						}
					});
				}
			});
		}
  </script>
  <script>
    'use strict';
    
    // 아이디,연락처 중복버튼 클릭확인 변수
    let idCheckSw = 0;
    let telCheckSw = 0;
    //이메일 인증버튼 클릭확인 변수
    let emailCheckSw = 0;
    //이메일 인증번호 확인 변수
    let emailCheckOkSw = 0;
    
    function fCheck() {
    	let regMid = /^[a-zA-Z0-9_]{4,20}$/;
    	let regPwd = /(?=.*[0-9a-zA-Z]).{6,20}$/;
      let regName = /^[가-힣a-zA-Z]+$/;
      let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
    	let regTel = /\d{3}-\d{3,4}-\d{4}$/g;
    	
    	let mid = myform.mid.value.trim();
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
    	if(!regMid.test(mid)) {
    		alert("아이디는 4~20자리의 영문 소/대문자와 숫자, 언더바(_)만 사용가능합니다.");
    		myform.mid.focus();
    		return false;
    	}
    	else if(!regPwd.test(pwd)) {
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
  		
			// 이용약관동의 체크 여부확인
    	if (!$("input:checked[id='check1']").is(":checked") || !$("input:checked[id='check2']").is(":checked")){ 
    		alert("이용약관에 동의하세요.");
    		myform.allCheck.focus();
				return false;    		
    	} else {
    			submitFlag = 1;
    	}
						
    	// 전송전에 모든 체크가 끝나면 submitFlag가 1로 되게된다. 이때 값들을 서버로 전송처리한다.
    	if(submitFlag == 1) {
    		if(idCheckSw == 0) {
    			alert("아이디 중복체크버튼을 눌러주세요!");
    			document.getElementById("midBtn").focus();
    		}
    		else if(telCheckSw == 0) {
    			alert("휴대전화 확인 버튼을 눌러주세요!");
    			document.getElementById("telBtn").focus();
    		}
    		
    		else if(emailCheckSw == 0) {
    			alert("메일 인증하기 버튼을 눌러주세요!");
    			document.getElementById("mailBtn").focus();
    			return false;
    		}
    	 	else if(emailCheckOkSw == 0) {
    			alert("메일 인증을 완료하세요!")
    			document.getElementById("mailCheckOk").focus();
    			return false;
    		} 
    		else {
	    		myform.email.value = email;
	    		myform.tel.value = tel;
	    		//alert("email:"+email);
	    		
		    	myform.submit();
    		}
    	}
    	else {
    		alert("회원가입에 실패하였습니다. 가입 형식을 확인해주세요.");
    	}
    }
    
  // 문제점1. fCheck 함수안에 해당 클릭 이벤트 함수가 들어가 있었음.
  // 문제점2. $(function(){}) 을 적지 않고 사용
  // 문제점3. $("input:checked[id='check2']").prop("checked", true);
  // ->$("#check1 , #check2").prop
  // 참고 : $().prop("checked") : 상태확인
  // + if문으로 할필요없이 결과로 바로 변경하면 된다.
  
	// 이용약관 전체 체크하기
	$(function() {
		$('#allCheck').click(function(){
			$("#check1 , #check2").prop("checked", $("#allCheck").prop('checked'));
		});
	})
  
	// 아이디 중복체크
	function idCheck() {
		let mid = myform.mid.value;
		
		if(mid.trim() == "" || mid.length < 4 || mid.length > 20) {
			alert("아이디 형식을 확인하세요.\n-영문 대소문자 \n-숫자 \n-언더바( _ ) \n-4~20자리 이내로 사용 가능");
			myform.mid.focus();
			return false;
		}
		
		$.ajax({
			type  : "post",
			url   : "${ctp}/member/memberIdCheck",
			data  : {mid : mid},
			success:function(res) {
				if(res == "1") {
					//alert("이미 사용중인 아이디 입니다. 다시 입력하세요.");
					idCheckSw = 0;
					let str="";
					
				  str += '<div class="alert alert-danger">';
				  str += '<strong>이미 사용중인 아이디 입니다. 다시 입력하세요.</strong>';
				  str += '</div>';
				  $("#midDemo").html(str);
				  
					$("#mid").focus();
				}
				else {
					//alert("사용 가능한 아이디 입니다.");
					idCheckSw = 1;
	    		
					let str="";
				  str += '<div class="alert alert-success">';
				  str += '<strong>사용 가능한 아이디입니다.</strong>';
				  str += '</div>';
				  $("#midDemo").html(str);
				  
					myform.mid.readOnly = true;
	    		$("#pwd").focus();
				}
			},
			error : function() {
				alert("전송오류!");
			}
		});
	}
  
  // 연락처 중복체크
  function telCheck() {
	  let tel1 = myform.tel1.value;
  	let tel2 = myform.tel2.value.trim();
  	let tel3 = myform.tel3.value.trim();
  	let tel = tel1 + "-" + tel2 + "-" + tel3; 
  	
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
 
  // 메일인증 버튼 확인/인증번호 보내기
  function mailBtnCheck() {
	  // 메일인증하기 버튼 누를 때 비어있으면 오류 메세지 띄우기
	  let email1 = myform.email1.value.trim();
  	let email2 = myform.email2.value;
  	let email = email1 + "@" + email2;
  	let str = "";
  	
  	if(email1 == "") {
  		str += '<div class="alert alert-danger">';
		  str += '<strong>이메일 주소를 입력하세요.</strong>';
		  str += '</div>';
		  
		  $("#emailDemo").html(str);
  	}
  	else {
  		//올바른 이메일형식을 입력했다면 이메일 넘기기
		  emailCheckSw = 1;
  		
  		$.ajax({
  			type : 'post',
  			url : '${ctp}/member/memberMailCheck',
  			data : {email : email},
  			success : function() {
  				console.log("이메일 전송 성공");
  			},
  			error : function() {
  				alert("이메일 전송실패");
  			}
  		});
		  
		  str = "";
		  
		  str += "<div class='input-group'>";
		  str += "<div class='input-group-prepend'>";
		  str += "<form method='post'>";
		  str += "<input type='text' name='mailCheck' id='mailCheck' />";
		  str += "</div>";
		  str += "<div class='input-group-append'>";
		  str += "<input type='button' onclick='mailCheckOk()' value='확인' class='btn btn-info btn-sm' />"; 
		  str += "</form>";
		  str += "</div>";
		  str += "</div>";
		  
		  $("#emailDemo").html(str);
  	}
  }
  
	// 메일 인증번호 비교 체크
	function mailCheckOk() {
		
		let mailCheck = document.getElementById("mailCheck").value;
		
		// 메일로 보낸 인증번호를 세션에 저장시킨다.. 세션에 저장된 인증번호와 회원이 입력한 인증번호가 같으면 회원가입 시킨다.
		$.ajax({
			type : 'post',			
			url : '${ctp}/member/memberMailCheckOk',
			data : {mailCheckNum : mailCheck},
			success : function(res) {
				if(res == "1") {
					emailCheckOkSw = 1;
					alert("인증이 완료되었습니다.");
					myform.email1.readOnly = true;
					
					$("#emailDemo").hide();
					myform.tel2.focus();
				}
				else {
					emailCheckOkSw = 0;
					alert("인증번호가 틀립니다.");
					return false;
				}
			},
			error : function() {
				alert("전송실패");
			}
		});
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
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container" style="margin-top: 130px; width: 40%">
  <form name="myform" method="post" class="was-validated">
    <h2 style="text-align: center" class="mb-5">회 원 가 입</h2>
    <div>
    	<p>아이디와 비밀번호 입력하기 귀찮으시죠?<br/>
			1초 회원가입으로 입력없이 간편하게 로그인 하세요.</p>
    	<a href="javascript:kakaoLogin()"><img src="${ctp}/images/kakao_login_medium_narrow.png"></a>
    </div>
    <hr/>
    <h3>기본 정보</h3>
    <div class="form-group mt-4">
      <label for="mid">아이디 (영문 대소문자/숫자/_ , 4~20자리) &nbsp; &nbsp;<input type="button" value="아이디 중복체크" id="midBtn" class="btn btn-secondary btn-sm" onclick="idCheck()"/></label>
      <input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력하세요." required autofocus/>
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
      <input type="text" class="form-control" name="name" id="name" placeholder="성명을 입력하세요." required />
    </div>
    <div class="form-group">
      <label for="email1">이메일 &nbsp; <input type="button" value="메일 인증하기" id="mailBtn" class="btn btn-secondary btn-sm" onclick="mailBtnCheck()"/></label>
        <div class="input-group mb-3">
          <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required />
          <div class="input-group-append">
            <select name="email2" class="custom-select">
              <option value="naver.com" selected>naver.com</option>
              <option value="daum.net">daum.net</option>
              <option value="kakao.com">kakao.com</option>
              <option value="gmail.com">gmail.com</option>
              <option value="hanmail.net">hanmail.net</option>
              <option value="hotmail.com">hotmail.com</option>
              <option value="nate.com">nate.com</option>
              <option value="yahoo.com">yahoo.com</option>
            </select>
          </div>
        </div>
    </div>
    <div id="emailDemo" class="mb-3"></div>
    <div class="form-group">
      <div class="input-group mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text">휴대전화</span> &nbsp;&nbsp;
            <select name="tel1" class="custom-select" required>
              <option value="010" selected>010</option>
              <option value="011">011</option>
              <option value="016">016</option>
              <option value="017">017</option>
              <option value="018">018</option>
              <option value="019">019</option>
            </select>-
        </div>
        <input type="text" name="tel2" size=2 maxlength=4 class="form-control" required />-
        <input type="text" name="tel3" size=2 maxlength=4 class="form-control" required />
        <input type="button" value="확인" id="telBtn" class="btn btn-secondary btn-sm ml-2 " onclick="telCheck()"/>
      </div>
      <div id="telDemo"></div>
    </div>
    <div class="form-group">
      <label for="sample6_postcode">주소</label>
      <div class="input-group mb-1">
        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control" required>
        <div class="input-group-append">
          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
        </div>
      </div>
      <input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1" required>
      <div class="input-group mb-1">
        <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="상세주소" class="form-control" required>
        <div class="input-group-append">
	        <input type="text" name="detailAddress" id="sample6_detailAddress"  placeholder="참고항목" class="form-control"> &nbsp;&nbsp;
        </div>
      </div>
    </div>
    <hr/>
    <div class="form-group mt-5">
	    <h3 class="mb-3">추가 정보 (선택)</h3>
      <label for="birthday">반려동물 생일</label>
      <input type="date" name="birthday" id="birthday" value="<%=java.time.LocalDate.now() %>" class="form-control"/>
    </div>
    
    <hr/>
    <div class="mt-5">
    	<h3 class="mb-3">전체 동의</h3>
    	<div class="mb-3">
    		<label for="allCheck" >
    			<input type="checkbox" name="allCheck" id="allCheck" required /><b style="font-size: 13pt;"> 이용약관 및 개인정보수집 및 이용에 모두 동의합니다.</b>
    		</label>
    	</div>
	    <button class="accordion">[필수] 이용약관 동의</button>
			<div class="panel" style="overflow: auto">
				<jsp:include page="/WEB-INF/views/include/joinAgree1.jsp" />
			</div>
			<div> 이용약관에 동의하십니까? <input type="checkbox" id="check1" required /> 동의함</div><br/>
			
			<button class="accordion">[필수] 개인정보 수집 및 이용 동의</button>
			<div class="panel">
			 <jsp:include page="/WEB-INF/views/include/joinAgree2.jsp" />
			</div>
			<div>개인정보 수집 및 이용에 동의하십니까? <input type="checkbox" id="check2" required /> 동의함</div><br/>
    </div>
    <div class="w3-center" style="margin-top: 50px; margin-bottom: 30px;">
	    <button type="button" class="btn btn-secondary" onclick="location.reload();" >다시작성</button> &nbsp;
	    <button type="button" class="btn btn-secondary" onclick="fCheck()">회원가입</button> &nbsp;
	    <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/';">홈으로</button>
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