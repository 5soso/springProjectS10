<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberLogin.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link href="https://cdn.jsdelivr.net/npm/remixicon@4.0.0/fonts/remixicon.css" rel="stylesheet"/>
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

  <script>
  	'use strict';
  
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
		
		// 회원 로그인 버튼
		function memberLogin() {
			let mid = myform.mid.value.trim();
			let pwd = myform.pwd.value.trim();
			let idSave = myform.idSave.value.trim();
			let str = "";
			if(mid == "" || pwd == "") {
				str += '<span class="alert alert-danger form-control" style="height:45px;">';
			  str += '<strong>아이디와 비밀번호를 입력하세요.</strong>';
			  str += '</span>';
				$("#demo").html(str);
			}
			
			else {
				$("#demo").hide();
				myform.submit();
			}
		}

		/* ================ */
		
		$(function() {
	    	$("#searchMid").hide();
	    	$("#searchPassword").hide();
	    });
	    
	    // 아이디 찾기 폼 보기
	    function midSearch() {
	    	$("#searchPassword").hide();
	    	$("#searchMid").show();
	    }
	    
	    // 이메일 검색처리
	    function emailFind() {
	    	let email = $("#emailSearch").val().trim();
	    	let str = "";
	    	if(email == "") {
	    		
		    	str += '<div class="alert alert-danger">';
					str += '<strong>이메일을 입력하세요.</strong>';
					str += '</div>';
					midShow.innerHTML = str;
					
	    		$("#emailSearch").focus();
	    		return false;
	    	}
	    	
	    	$.ajax({
	    		url  : "${ctp}/member/memberEmailSearch",
	    		type : "POST",
	    		data : {email : email},
	    		success:function(res) {
		    		if(res != 0){
		    			let temp = res.split("/");
		    			console.log("temp :", temp);
		    			let str = '검색결과 : <br/><font color=blue><b>';
		    			for(let i=0; i<temp.length; i++) {
		    				let jump = Math.floor((Math.random()*(4-2)) + 2);
		    				let tempMid = temp[i].substring(0,1);
		    				console.log("tempMid",tempMid,", jump",jump);
		    				for(let j=1; j<temp[i].length; j++) {
		    					if(j % jump == 0) tempMid += "*";
		    					else tempMid += temp[i].substring(j,j+1);
		    				}
			    			str += tempMid;
			    			
			    			str += "<br/>";
		    			}
		    			str += '</b></font>';
		    			midShow.innerHTML = str;
		    		}
		    		else {
		    			alert("등록된 아이디가 없습니다.");
		    		}
	    		},
	    		error : function() {
	    			alert("전송 오류!");
	    		}
	    	});
	    		console.log("email",email);
	    }
	    
	    // 비밀번호 검색폼 보여주기
	    function pwdSearch() {
	    	$("#searchMid").hide();
	    	$("#searchPassword").show();
	    }
	    
	    // 비밀번호 검색처리
	    function passwordFind() {
	    	let mid = $("#midSearch").val().trim();
	    	let email = $("#emailSearch2").val().trim();
	    	let str = "";
	    	if(mid == "" || email == "") {
	    		
	    		str += '<div class="alert alert-danger">';
					str += '<strong>가입시 등록한 아이디와 메일주소를 입력하세요.</strong>';
					str += '</div>';
					pwdShow.innerHTML = str;
	    		
	    		$("#midSearch").focus();
	    		return false;
	    	}
	    	
	    	let query = {
	    			mid   : mid,
	    			email : email
	    	}
	    	
	    	$.ajax({
	    		url  : "${ctp}/member/memberPasswordSearch",
	    		type : "post",
	    		data : query,
	    		success:function(res) {
	    			if(res == "1") {
	    				//alert("새로운 비밀번호가 회원님 메일로 발송 되었습니다.");
	    				str += '<div class="alert alert-success">';
							str += '<strong>새 비밀번호가 회원님의 메일로 발송되었습니다.</strong>';
							str += '</div>';
							pwdShow.innerHTML = str;
	    			}
	    			else {
	    				alert("등록하신 정보가 잘못되었습니다. 확인후 다시 전송하세요.");
	    			}
	    		},
	    		error : function() {
	    			alert("전송오류!");
	    		}
	    	});
	    }
  </script>
  
  <style>
		table {
			margin-left: auto;
			margin-right: auto;
		}
  	#logo {
  		margin-top:100px;
  	}
  	b {
  		font-size: 17pt;
  	}
  	a:hover {
  		text-decoration: none;
  		color: black;
  	}
  	#findID, #findPWD {
  		color: gray;
  	}
  	#join {
			font-weight: bold;
		}
		.btn {
			background-color: #eee; 
			font-size: 13pt;
			font-weight: bold;
			border-radius: 10px;
		}
		.btn:hover {
			background-color: black;
			color:white; 
			font-size: 13pt;
			font-weight: bold;
		}
		.btn:active {
			border:none;
		 	outline: none;
		 	box-shadow: none;
		}
		.switch {
		  position: relative;
		  display: inline-block;
		  width: 50px;
		  height: 22px;
		}
		
		.switch input { 
		  opacity: 0;
		  width: 0;
		  height: 0;
		}
		
		.slider {
		  position: absolute;
		  cursor: pointer;
		  top: 0;
		  left: 0;
		  right: 0;
		  bottom: 0;
		  background-color: #ccc;
		  -webkit-transition: .4s;
		  transition: .4s;
		}
		
		.slider:before {
		  position: absolute;
		  content: "";
		  height: 17px;
		  width: 17px;
		  left: 3px;
		  bottom: 3px;
		  background-color: white;
		  -webkit-transition: .4s;
		  transition: .4s;
		}
		
		input:checked + .slider {
		  background-color: black;
		}
		
		input:focus + .slider {
		  box-shadow: 0 0 1px #2196F3;
		}
		
		input:checked + .slider:before {
		  -webkit-transform: translateX(26px);
		  -ms-transform: translateX(26px);
		  transform: translateX(26px);
		}
		
		/* Rounded sliders */
		.slider.round {
		  border-radius: 34px;
		}
		
		.slider.round:before {
		  border-radius: 50%;
		}
		
		.midText, .pwdText, .idCheck {
			text-align: left;
			border: none;
		}
		.switch {
			text-align: left;
		}
		
		.infoSearch a {
			text-decoration: none;
		}

  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<br/>
<div class="container">
  <div id="logo" class="text-center mb-5">
  	<a href="${ctp}/"><img src="${ctp}/login/logo2.jpg" width="250px;" class="mt-4 mr-3"/></a>
  </div>
  <div class="text-center">
	  <div class="kakaoLogin mt-3">
	  	<p style="text-align: ">
	  		1초 회원가입으로 입력없이 간편하게 로그인 하세요.
	  	</p>
			<a href="javascript:kakaoLogin()"><img src="${ctp}/login/kakaoLogin.jpg" style="width: 380px;"></a>
	  </div>
	  <div>
			<img src="${ctp}/login/loginBenefit.png" style="width:400px; margin-top: 20px;" />
	  </div>
	  
	  <hr/>
	  <form name="myform" method="post"> 
		  <div class="mb-5"><b>기 존 회 원</b></div>
		  <table style="width: 40%">
				<tr>
					<td class="midText form-control">아이디</td>
					<td><input type="text" name="mid" id="mid" value="${mid}" class="form-control mb-2" required /></td>
				</tr>	  
				<tr>
					<td class="pwdText form-control">비밀번호</td>
					<td><input type="password" name="pwd" id="pwd" class="form-control mb-3" required /></td>
				</tr>	 
				<tr><td colspan="2" id="demo"></td></tr> 
				<tr>
					<td class="idCheck form-control" colspan="2">
						<label class="switch">
							<input type="checkbox" class="mb-2" name="idSave" checked><span class="slider round"></span>
						</label> 아이디저장
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="button" value="회원 로그인" onclick="memberLogin()" class="btn mt-3 mb-4 form-control" />
					</td>
				</tr>
		  </table>
	  </form>
	</div>
	<div>
		<table style="width: 40%" class="infoSearch">
			<tr>
				<td style="text-align: left;">
					<a href="javascript:midSearch()" id="findID"  >아이디 찾기 |</a>
					<a href="javascript:pwdSearch()" id="findPWD" >비밀번호 찾기</a>
				</td>
				<td style="text-align: right;">
					<span id="join"><a href="${ctp}/member/memberJoin" style="color: black">회원가입</a></span> 
				</td>
			</tr>
		</table>
		
		<form name="searchForm" method="post">
	  <div id="searchMid">
	  	<table class="table table-borderless p-0 text-center mt-3" style="width: 40%">
	  	  <tr>
	  	    <td>
	  	      <div class="input-group">
	  	        <input type="text" name="eamilSearch" id="emailSearch" class="form-control" placeholder="가입시 입력한 이메일 주소를 입력하세요."/>
	  	        <div class="input-group-append">
	  	          <input type="button" value="이메일검색" onclick="emailFind()" class="btn btn-info" />
	  	        </div>
	  	      </div>
	  	    </td>
	  	  </tr>
	  	  <tr>
	  	    <td><div id="midShow"></div></td>
	  	  </tr>
	  	</table>
  	</div>
  	<div id="searchPassword">
	  	<table class="table table-borderless p-0 text-center mt-3" style="width: 40%">
	  	  <tr>
	  	    <th class="form-control">아이디</th>
	  	    <td><input type="text" name="midSearch" id="midSearch" class="form-control" placeholder="가입시 입력한 아이디를 입력하세요."/></td>
	  	  </tr>
	  	  <tr>
	  	    <th class="form-control">이메일</th>
	  	    <td><input type="text" name="emailSearch2" id="emailSearch2" class="form-control" placeholder="가입시 입력한 메일주소를 입력하세요."/></td>
	  	  </tr>
	  	  <tr>
	  	    <td colspan="2"><div id="pwdShow"></div></td>
	  	  </tr>
	  	  <tr>
	  	    <td colspan="2">
	  	      <input type="button" value="새비밀번호발급" onclick="passwordFind()" class="from-control btn btn-info mr-2" />
	  	    </td>
	  	  </tr>
	  	</table>
  	</div>
	</form>
	</div>
</div>

<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>