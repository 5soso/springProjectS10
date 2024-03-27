<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>about.jsp</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  	.scroll_wrap {overflow: hidden;}
		.scroll_on {padding:0px; margin:10px; text-align: center;opacity: 0;transition: all 1s;}
		.scroll_on.active {opacity: 1 !important;transform: translate(0, 0) !important;}
  	.scroll_on.type_top {transform: translate(0, -50px);}
		.scroll_on.type_bottom {transform: translate(0, 50px);}
		.scroll_on.type_left {transform: translate(-50px, 0);}
		.scroll_on.type_right {transform: translate(50px, 0);}
		.pattern {margin-top: 150px;}
		.Design {margin-top: 130px;}
  </style>
  <script>
	  // 화살표클릭시 화면 처음으로 부드럽게 이동시키기
	  $(window).scroll(function(){
	  	if($(this).scrollTop() > 100) {
	  		$("#topBtn").addClass("on");
	  	}
	  	else {
	  		$("#topBtn").removeClass("on");
	  	}
	  	
	  	$("#topBtn").click(function(){
	  		window.scrollTo({top:0, behavior: "smooth"});	// 현재 페이지에서 특정 위치로 스크로이동시키는 명령어(window.scrollTo)
	  	});
	  });
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container" style="margin-top: 130px;">

	<!-- First Grid: About -->
	<div class="w3-row text-center">
		<div class="w3-container">
		  <h2 class="w3-text-grey">ABOUT</h2>
		</div>
		
		<div class="w3-container w3-xlarge w3-text-black mt-5">
		  <p class="w3-xxxlarge mb-5">
			  Gear for city dogs <br/>
				Hund Everywhere
			</p>
			<br/>
		  <p class="w3-large mt-3">
			  <h3>MUNIKUND is a compound word of Munich and hund which means 'Dogs in Münichen'.<br/>
				Munikund is a co-lifestyle brand for human and pets in a modern days offering essential products.<br/>
				We propose an adapted design with a consideration for pets living in the city.<br/>
				Your dog's happiness makes you happy.
				</h3>
			</p>
		</div>
	</div>
	
	<!-- Second Grid: Resent -->
	<div class="w3-row" style="margin-top: 100px;">
		<div class="w3-container">
		  <img src="${ctp}/main/main_about.jpg" style="width:100%">
		</div>
		<div class="w3-center mt-5 mb-5 w3-large">
			<p>
				뮤니쿤트는 munich와 hund의 합성어로 '뮌헨의 개'를 의미합니다.<br/>
				도시에서 생활하는 개들을 위한 배려를 담은 어댑티브 디자인과 사람과 반려견의 행복한 라이프스타일을 제안합니다.
				<br/><br/>
				반려견의 행복은 당신을 행복하게 만듭니다.
			</p>
		</div>
	</div>
	<div class="w3-row w3-section" style="margin-top: 50px;">
	  <div class="w3-third" >
	    <a href="#pattern"><img src="${ctp}/main/story/aboutImg1.jpg" width="95%"/></a>
	  </div>
	  <div class="w3-third" >
	    <a href="#Design"><img src="${ctp}/main/story/aboutImg2.jpg" width="95%" /></a>
	  </div>
	  <div class="w3-third" >
	    <a href="#Meterials"><img src="${ctp}/main/story/aboutImg3.jpg" width="95%"/></a>
	  </div>
	</div>

	<!-- pattern -->
	<div class="pattern" id="pattern">
		<span style="font-size: 16pt;">Pattern</span>
		<hr style="border-width: 3px; border-color: black; margin-top: 0px;">
		<div class="w3-container w3-xxlarge mb-5 mt-5">
			CHOOSE A CLOTHES <br/>
			FITS YOUR PET
		</div>
		<div class="w3-row">
			<div class="w3-half w3-container">
				<img src="${ctp}/main/story/patternImg1.jpg" style="width:100%">
				<img src="${ctp}/main/story/patternImg2.jpg" style="width:100%">
			</div>
			<div class="w3-half w3-container mb-5">
			  <p style="font-size: 13pt;">
			 		&#xbba4;&#xb2c8;&#xcfe4;&#xd2b8;&#xb294; &#xbc18;&#xb824;&#xb3d9;&#xbb3c;&#xc758; &#xc6c0;&#xc9c1;&#xc784;&#xacfc; &#xbab8;&#xc758; &#xae30;&#xb2a5;&#xc744; &#xc218;&#xd589;&#xd558;&#xb294; &#xac83;&#xc744; &#xb3d5;&#xae30; &#xc704;&#xd55c; &#xd2b9;&#xbcc4;&#xd55c; &#xc124;&#xacc4;&#xacfc;&#xc815;&#xc744; &#xc804; &#xc81c;&#xd488;&#xc5d0; &#xc801;&#xc6a9;&#xd569;&#xb2c8;&#xb2e4;. &#xc218;&#xd559;&#xc801;&#xc778; &#xbc29;&#xc2dd;&#xc744; &#xc0ac;&#xc6a9;&#xd558;&#xba70; &#xacb0;&#xacfc;&#xc5d0;&#xc11c; &#xac70;&#xafb8;&#xb85c; &#xc5f0;&#xc5ed;&#xc801;&#xc73c;&#xb85c; &#xc811;&#xadfc;&#xd558;&#xb294; &#xbc29;&#xc2dd;&#xc744; &#xc0ac;&#xc6a9;&#xd558;&#xc5ec; &#xc644;&#xc81c;&#xd488;&#xc774; &#xc218;&#xd589;&#xd574;&#xb0b4;&#xc57c; &#xd560; &#xae30;&#xb2a5;&#xc744; &#xc5bb;&#xae30; &#xc704;&#xd574;&#xc11c;&#xb294; &#xc5b4;&#xb5a4; &#xc544;&#xc774;&#xb514;&#xc5b4;&#xac00; &#xc801;&#xc6a9;&#xb418;&#xc5b4;&#xc57c; &#xd558;&#xb294;&#xc9c0; &#xcd94;&#xb860;&#xd558;&#xc5ec; &#xd574;&#xacb0;&#xcc45;&#xc744; &#xbaa8;&#xc0c9;&#xd558;&#xb824;&#xace0; &#xb178;&#xb825;&#xd569;&#xb2c8;&#xb2e4;.<br/><br/>&#xb2e4;&#xc591;&#xd55c; &#xacac;&#xc885;&#xc774; &#xac00;&#xc9c4; &#xd06c;&#xae30;&#xc640; &#xbab8;&#xc758; &#xad6c;&#xc870;&#xbd80;&#xd130; &#xaf2c;&#xb9ac;&#xb098; &#xb2e4;&#xb9ac;&#xbf08;&#xc758; &#xac01;&#xb3c4;&#xc640; &#xac19;&#xc740; &#xc0ac;&#xc18c;&#xd55c; &#xbd80;&#xbd84;&#xae4c;&#xc9c0; &#xc138;&#xc2ec;&#xd558;&#xac8c; &#xc0b4;&#xd53c;&#xba70; &#xc81c;&#xd488;&#xc758; &#xd54f;, &#xb290;&#xb08c;, &#xc131;&#xb2a5;&#xc744; &#xc644;&#xbcbd;&#xd558;&#xac8c; &#xd558;&#xae30; &#xc704;&#xd574; &#xb9ce;&#xc740; &#xb178;&#xb825;&#xc744; &#xae30;&#xc6b8;&#xc774;&#xace0; &#xc788;&#xc2b5;&#xb2c8;&#xb2e4;. &#xc774; &#xc810;&#xc740; &#xb108;&#xbb34; &#xb514;&#xd14c;&#xc77c;&#xd558;&#xc5ec; &#xb300;&#xbd80;&#xbd84;&#xc758; &#xacbd;&#xc6b0;&#xc5d0;&#xb294; &#xc54c;&#xc544;&#xcc28;&#xb9ac;&#xae30; &#xc5b4;&#xb835;&#xc9c0;&#xb9cc; &#xbc18;&#xb824;&#xb3d9;&#xbb3c;&#xc758; &#xc6c0;&#xc9c1;&#xc784;&#xc774;&#xb098; &#xb2e4;&#xc591;&#xd55c; &#xd65c;&#xb3d9;&#xc5d0;&#xc11c; &#xd3b8;&#xc548;&#xd568;&#xc744; &#xc904; &#xac83;&#xc774;&#xb77c; &#xd655;&#xc2e0;&#xd569;&#xb2c8;&#xb2e4;.<br/><br/>&#xb610;&#xd55c;, &#xc6b0;&#xb9ac;&#xb294; &#xc0c8;&#xb85c;&#xc6b4; &#xc2dc;&#xc98c;&#xc774; &#xc2dc;&#xc791;&#xb428;&#xc5d0; &#xb530;&#xb77c; &#xb514;&#xd14c;&#xc77c;&#xc744; &#xc870;&#xae08;&#xc529; &#xd601;&#xc2e0;&#xd558;&#xace0; &#xac1c;&#xc120;&#xd558;&#xb824;&#xace0; &#xb178;&#xb825;&#xd569;&#xb2c8;&#xb2e4;. &#xb610;&#xd55c; &#xb2e4;&#xc591;&#xd55c; &#xc870;&#xd569;&#xc744; &#xd1b5;&#xd574; &#xc0c8;&#xb85c;&#xc6b4; &#xc544;&#xc774;&#xb514;&#xc5b4;&#xb97c; &#xad6c;&#xcd95;&#xd569;&#xb2c8;&#xb2e4;.
			 	</p>
			</div>
		</div>
		<div class="w3-container w3-xxlarge w3-center" style="margin-top: 80px;">
			<b>We approach the design process<br/>
			scientifically. It’s almost like math.</b>
		</div>
	</div>

	<!-- Design -->
	<div class="Design" id="Design">
		<span style="font-size: 16pt;">Design</span>
		<hr style="border-width: 3px; border-color: black; margin-top: 0px;">
		<div class="w3-container w3-xxlarge mb-5 mt-5 text-center">
			WE DESIGN PRODUCTS <br/>
			FOR DOGS IN THE CITY
		</div>
		<div class="">
			<div class="w3-container text-center">
				<img src="${ctp}/main/story/design1.jpg" style="width:35%">
				<img src="${ctp}/main/story/design2.jpg" style="width:35%">
			</div>
			<div class="w3-container mb-5 text-center" style="margin-top: 70px;">
			  <p style="font-size: 13pt;">
			 		&#xbba4;&#xb2c8;&#xcfe4;&#xd2b8;&#xb294; &#xbc18;&#xb824;&#xb3d9;&#xbb3c;&#xc758; &#xc885;&#xc774;&#xb098; &#xc554;&#xc218; &#xad6c;&#xbd84;&#xc758; &#xacbd;&#xacc4;&#xac00; &#xc5c6;&#xb294; &#xacf5;&#xc6a9;&#xc758; &#xb514;&#xc790;&#xc778;&#xc744; &#xc81c;&#xc548;&#xd569;&#xb2c8;&#xb2e4;.<br/>&#xc774; &#xc810;&#xc740; &#xc6b0;&#xb9ac;&#xac00; &#xc81c;&#xd488;&#xc744; &#xb514;&#xc790;&#xc778;&#xd560; &#xb54c; &#xc911;&#xc694;&#xd558;&#xac8c; &#xace0;&#xb824;&#xd558;&#xb294; &#xad00;&#xc810;&#xc774;&#xba70;<br/>&#xc5ec;&#xb7ec; &#xb9c8;&#xb9ac;&#xc758; &#xbc18;&#xb824;&#xb3d9;&#xbb3c;&#xc744; &#xd568;&#xaed8; &#xae30;&#xb974;&#xb294; &#xacfc;&#xc815;&#xc5d0;&#xc11c;&#xb3c4; &#xd569;&#xb9ac;&#xc801;&#xc73c;&#xb85c; &#xc791;&#xc6a9;&#xd569;&#xb2c8;&#xb2e4;.<br/><br/>&#xc81c;&#xd488;&#xc774; &#xc2dc;&#xac04;&#xc774; &#xc9c0;&#xb0a8;&#xc5d0; &#xb530;&#xb77c; &#xc2e4;&#xc81c;&#xb85c; &#xc9c0;&#xc18d;&#xb418;&#xae30; &#xc704;&#xd574;&#xc11c;&#xb294; &#xd488;&#xc9c8;&#xacfc; &#xb514;&#xc790;&#xc778;&#xc774; &#xbaa8;&#xb450; &#xc9c0;&#xc18d; &#xac00;&#xb2a5;&#xd574;&#xc57c; &#xd558;&#xbbc0;&#xb85c;<br/>&#xb514;&#xc790;&#xc778;&#xc740; &#xd604;&#xb300;&#xc801;&#xc774;&#xace0; &#xbbf8;&#xd559;&#xc801;&#xc778; &#xad00;&#xc810;&#xc5d0; &#xbd80;&#xd569;&#xd558;&#xba74;&#xc11c;&#xb3c4; &#xc77c;&#xc0c1;&#xc758; &#xbca0;&#xc774;&#xc9c1;&#xd55c; &#xbc94;&#xc8fc;&#xc5d0;&#xc11c; &#xd06c;&#xac8c; &#xbc97;&#xc5b4;&#xb098;&#xc9c0; &#xc54a;&#xc544;&#xc57c; &#xd569;&#xb2c8;&#xb2e4;.<br/><br/>&#xc6b0;&#xb9ac;&#xb294; &#xc9e7;&#xc740; &#xd2b8;&#xb80c;&#xb4dc; &#xc8fc;&#xae30;&#xb97c; &#xbc97;&#xc5b4;&#xb098; &#xb2e4;&#xc591;&#xd55c; &#xbaa8;&#xc2b5;&#xc758; &#xbc18;&#xb824;&#xb3d9;&#xbb3c;&#xb4e4;&#xc5d0;&#xac8c; &#xace0;&#xc815;&#xad00;&#xb150;&#xc744; &#xc8fc;&#xc9c0;&#xc54a;&#xace0;,<br/>&#xc790;&#xc5f0;&#xc2a4;&#xb7ec;&#xc6c0;&#xc744; &#xcc3e;&#xc544;&#xc904; &#xc218; &#xc788;&#xb294; &#xc624;&#xb7ab;&#xb3d9;&#xc548; &#xc9c8;&#xb9ac;&#xc9c0; &#xc54a;&#xc744; &#xb514;&#xc790;&#xc778;&#xc744; &#xc81c;&#xc548;&#xd569;&#xb2c8;&#xb2e4;.
			 	</p>
			</div>
		</div>
	</div>

	<!-- Meterials -->
	<div class="Meterials" id="Meterials" style="margin-top: 100px;">
		<span style="font-size: 16pt;">Meterials</span>
		<hr style="border-width: 3px; border-color: black; margin-top: 0px;">
		<div class="w3-container w3-xxlarge mb-5 mt-5 text-center">
			WE DESIGN PRODUCTS <br/>
			FOR DOGS IN THE CITY
		</div>
		<div class="">
			<div class="w3-container text-center m-0 p-0">
				<img src="${ctp}/main/story/Meterials1.jpg" style="width:60%">
				<img src="${ctp}/main/story/Meterials2.jpg" style="width:35%">
			</div>
			<div class="w3-container mb-5" style="margin-top: 70px;">
			  <p style="font-size: 13pt;">
			 		&#xbba4;&#xb2c8;&#xcfe4;&#xd2b8;&#xb294; &#xc0ac;&#xacc4;&#xc808; &#xb0b4;&#xb0b4; &#xcf8c;&#xc801;&#xd558;&#xac8c; &#xcc29;&#xc6a9;&#xd560; &#xc218; &#xc788;&#xace0; &#x2018;&#xc9c0;&#xc18d; &#xac00;&#xb2a5;&#xd55c;&#x2019; &#xc77c;&#xc0c1;&#xbcf5;&#xc744; &#xc81c;&#xc548;&#xd558;&#xc5ec; &#xbe60;&#xb978; &#xd15c;&#xd3ec;&#xc758; &#xd2b8;&#xb80c;&#xb4dc; &#xbcc0;&#xd654;&#xb85c; &#xc778;&#xd574; &#xc18c;&#xbaa8;&#xb418;&#xae30;&#xbcf4;&#xb2e4;&#xb294; &#xc5f0;&#xc911; &#xb300;&#xbd80;&#xbd84;&#xc758; &#xae30;&#xac04;&#xb3d9;&#xc548; &#xcc29;&#xc6a9;&#xd560; &#xc218; &#xc788;&#xb294; &#xc77c;&#xc0c1;&#xc758; &#xae30;&#xbcf8;&#xc774; &#xb418;&#xb294; &#xc81c;&#xd488;&#xc744; &#xb9cc;&#xb4e4;&#xace0; &#xc788;&#xc2b5;&#xb2c8;&#xb2e4;.<br/><br/>&#xb610;&#xd55c; &#xbb34;&#xc5c7;&#xbcf4;&#xb2e4;&#xb3c4; &#xc544;&#xc774;&#xb4e4;&#xc758; &#xc77c;&#xc0c1; &#xd65c;&#xb3d9;&#xc73c;&#xb85c; &#xc778;&#xd55c; &#xb9c8;&#xbaa8;&#xb97c; &#xacac;&#xb38c;&#xb0b4;&#xba70; &#xc2e4;&#xc6a9;&#xc801;&#xc774;&#xc5b4;&#xc57c; &#xd558;&#xbbc0;&#xb85c; &#xc774;&#xb97c; &#xace0;&#xb824;&#xd55c; &#xc18c;&#xc7ac;&#xb85c; &#xc81c;&#xd488;&#xc744; &#xc81c;&#xc791;&#xd569;&#xb2c8;&#xb2e4;. &#xbba4;&#xb2c8;&#xcfe4;&#xd2b8;&#xb294; &#xceec;&#xb809;&#xc158;&#xc758; &#xc57d; 97% &#xc774;&#xc0c1;&#xc744; &#xc9c0;&#xc18d; &#xac00;&#xb2a5;&#xd55c; &#xc790;&#xc6d0;&#xc744; &#xd65c;&#xc6a9;&#xd558;&#xb294; &#xac83;&#xc744; &#xbaa9;&#xd45c;&#xb85c; &#xd558;&#xace0; &#xc720;&#xae30;&#xb18d;, &#xc7ac;&#xd65c;&#xc6a9; &#xc12c;&#xc720; &#xadf8;&#xb9ac;&#xace0; &#xd654;&#xd559; &#xcc98;&#xb9ac;&#xac00; &#xb418;&#xc9c0; &#xc54a;&#xc740; &#xc18c;&#xc7ac;&#xb4e4;&#xc744; &#xc0dd;&#xac01;&#xd569;&#xb2c8;&#xb2e4;.<br/><br/>&#xc81c;&#xd488; &#xd328;&#xd0a4;&#xc9c0;&#xc758; &#xb300;&#xbd80;&#xbd84;&#xc744; 2020&#xb144;&#xbd80;&#xd130; &#xac00;&#xb2a5;&#xd55c; &#xc885;&#xc774;&#xb85c; &#xb300;&#xccb4;&#xd558;&#xc600;&#xc73c;&#xba70;, &#xba87; &#xb144; &#xc548;&#xc5d0;&#xb294; &#xc544;&#xc9c1; &#xb300;&#xccb4;&#xb418;&#xc9c0; &#xc54a;&#xc740; &#xbd80;&#xbd84;&#xb3c4; &#xc9c0;&#xc18d;&#xac00;&#xb2a5;&#xd55c; &#xc18c;&#xc7ac;&#xb85c; &#xb300;&#xccb4;&#xd558;&#xb824;&#xace0; &#xb178;&#xb825;&#xd569;&#xb2c8;&#xb2e4;.
			 	</p>
			</div>
		</div>
	</div>

<h6 id="topBtn" class="text-right mr-3" style="cursor:pointer"><img src="${ctp}/images/arrowTop.gif"/><br/>Top</h6>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</html>
