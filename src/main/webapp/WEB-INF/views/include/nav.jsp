<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<!-- 카카오 큐알 로그인 사용할시 javascript:kakaoLogout() 부르기  -->
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script>
	  window.Kakao.init("dad8f37ec6bdcb4a3aa33f4ec83986a8");
		function kakaoLogout() {
			  const accessToken = Kakao.Auth.getAccessToken();
			  if(accessToken) {
				  Kakao.Auth.logout(function() {
					  window.location.href = "https://kauth.kakao.com/oauth/logout?client_id=dad8f37ec6bdcb4a3aa33f4ec83986a8&logout_redirect_uri=http://localhost:9090/javaProjectS10/member/memberLogout";
				  });
			  }
		}
	</script>
	<style>
	/* shop menu */
	#firstNav a:hover {
		text-decoration: none;
		color: white;
	}
	#firstNav.w3-button {
		background-color: black;
	}
	
	#myNavbar a:hover {
		text-decoration: none;
		color: black;
	}
	
	.w3-bar .w3-button {
	  padding: 16px;
	}
	
	#firstNav.active {
		display: none;
	}
	
	.myNavbar2 {
		font-weight: bold;
	}
	
	.header_scroll_fixed {
		position: fixed;
		top: 0px;
		background: white;
		/*
		background: rgba(255,255,255,0.95);
		transition: all 0.2s ease;
		-webkit-transition: all 0.2s ease;
		box-shadow: 0 3px 7px 1px rgba(0,0,0,0.05) !important;
		-webkit-box-shadow: 0 3px 7px 1px rgba(0,0,0,0.05) !important;
		*/
		width: 100%;
		float: left;
	}
	
	/* active css */
	#myNavbar.active {
		position: fixed;
		top:55px;
		background: white;
		/*
		background: rgba(255,255,255,0.95);
		transition: all 0.2s ease;
		-webkit-transition: all 0.2s ease;
		box-shadow: 0 3px 7px 1px rgba(0,0,0,0.05) !important;
		-webkit-box-shadow: 0 3px 7px 1px rgba(0,0,0,0.05) !important;
		*/
		width: 100%;
	}
	
	#myNavbar.active .logo, #myNavbar.active {padding:0px; height:60px; transition:.5s;}
	#myNavbar.active a {font-size:14px; padding-top: 4px; font-weight: bold;}
	#myNavbar.active .logo {height:40px; margin-left:80px; margin-bottom:10px; margin-top:5px; float: left;}
	
	.dropdown {
	  position: relative;
	  display: inline-block;
	  background: rgba(255,255,255,0.95);
	  transition: all 0.2s ease;
	}
	
	.dropbtn {
		padding: 6px;
		margin: 5px;
		border: none;
		cursor: pointer;
		background: rgba(255,255,255,0.95);
		transition: all 0.2s ease;
		font-weight: bold;
	}
	
	.dropdown-content {
	  display: none;
	  position: absolute;
	  background-color: #f1f1f1;
	  min-width: 160px;
	  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); 
	  z-index: 1;
	  text-align: left;
	}
	
	.dropdown-content a {
	  color: black;
	  padding: 12px 16px;
	  text-decoration: none;
	  display: block;
	}
	
	.dropdown-content a:hover {background-color: #ddd;}
	
	.dropdown:hover .dropdown-content {display: block; color: white;}
  </style>
	
<!-- 최상단 메뉴바 -->
<div class="firstNav w3-top w3-bar w3-black w3-right w3-hide-small" id="firstNav"> 
  <c:if test="${!empty sMid}"><a href="${ctp}/member/memberMyPage" class="w3-bar-item w3-button w3-right">MY PAGE</a></c:if>
  <c:if test="${empty sMid}"><a href="${ctp}/member/memberLogin" class="w3-bar-item w3-button w3-right">MY PAGE</a></c:if>
  <c:if test="${!empty sMid}"><a href="${ctp}/product/productMyOrder" class="w3-bar-item w3-button w3-right">ORDER</a></c:if>
  <c:if test="${empty sMid}"><a href="${ctp}/member/memberLogin" class="w3-bar-item w3-button w3-right">ORDER</a></c:if>
 	<c:if test="${!empty sMid}"><a href="${ctp}/product/productCartList?mid=${sMid}" class="w3-bar-item w3-button w3-right">BAG()</a></c:if>
 	<c:if test="${empty sMid}"><a href="${ctp}/member/memberLogin" class="w3-bar-item w3-button w3-right">BAG()</a></c:if>
 	<c:if test="${!empty sMid}"><a href="${ctp}/product/wishList" class="w3-bar-item w3-button w3-right">WISHLIST</a></c:if>
  <c:if test="${!empty sMid}"><a href="${ctp}/member/memberUpdate" class="w3-bar-item w3-button w3-right">MODIFY</a></c:if>
  <c:if test="${!empty sMid}"><a href="${ctp}/member/memberLogout" class="w3-bar-item w3-button w3-right">LOGOUT</a></c:if>
  <c:if test="${empty sMid}">
	  <a href="${ctp}/member/memberJoin" class="w3-bar-item w3-button w3-right">JOIN</a>
	  <a href="${ctp}/member/memberLogin" class="w3-bar-item w3-button w3-right">LOGIN</a>
  </c:if>
  <c:if test="${sMid == 'admin' || sMid == 'sojung8497'}"><a href="${ctp}/admin/adminMain" class="w3-bar-item w3-button w3-right">관리자 메뉴 <i class="fa fa-gear"></i></a></c:if>
</div>

<!-- Navbar -->
<div class="w3-top">
  <div class="header_scroll_fixed w3-center" id="myNavbar">
    <a href="${ctp}/" class="logo w3-bar-item w3-button w3-wide" style="float: left;">MUNIKUND</a>
    <div class="dropdown w3-center">
      <button onclick="location.href='#about';" class="dropbtn">STORY</button>
      <div class="dropdown-content">
		    <a href="${ctp}/story/about">ABOUT</a>
		    <a href="#">NEWS</a>
		  </div>
    </div>
    <div class="dropdown w3-center">
      <button onclick="location.href='${ctp}/product/productList';" class="dropbtn">SHOP</button>
      <div class="dropdown-content">
		    <a href="${ctp}/product/productList">ALL</a>
		    <a href="${ctp}/product/productList?part=A">CLOTHES</a>
		    <a href="${ctp}/product/productList?part=B">WALK</a>
		    <a href="${ctp}/product/productList?part=C">LIVING</a>
		    <a href="${ctp}/product/productList?part=D">ACC.</a>
		    <a href="${ctp}/product/productList?part=E">LAST PIECE</a>
		  </div>
    </div>
    <div class="dropdown w3-center w3-hide-small">
      <a href="${ctp}/review/productReview" class="w3-bar-item w3-button myNavbar2">REVIEW</a>
    </div>
    <div class="dropdown w3-center w3-hide-small myNavbar2">
      <a href="${ctp}/qna/qnaList" class="w3-bar-item w3-button">Q&A</a>
    </div>
    <div class="dropdown w3-center w3-hide-small myNavbar2">  
      <a href="${ctp}/qna/stores" class="w3-bar-item w3-button">STORES</a>
    </div>
    <!-- Hide right-floated links on small screens and replace them with a menu icon -->

    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-right w3-hide-large w3-hide-medium" onclick="w3_open()">
      <i class="fa fa-bars"></i>
    </a>
  </div>
</div>


<!-- Sidebar on small screens when clicking the menu icon -->
<nav class="w3-sidebar w3-bar-block w3-black w3-card w3-animate-left w3-hide-medium w3-hide-large" style="display:none" id="mySidebar">
  <c:if test="${!empty sMid}"><a href="${ctp}/member/memberMyPage" class="w3-bar-item w3-button">MY PAGE</a></c:if>
  <c:if test="${empty sMid}"><a href="${ctp}/member/memberLogin" class="w3-bar-item w3-button">MY PAGE</a></c:if>
  <c:if test="${!empty sMid}"><a href="${ctp}/product/productMyOrder" class="w3-bar-item w3-button">ORDER</a></c:if>
  <c:if test="${empty sMid}"><a href="${ctp}/member/memberLogin" class="w3-bar-item w3-button">ORDER</a></c:if>
 	<c:if test="${!empty sMid}"><a href="${ctp}/product/productCartList?mid=${sMid}" class="w3-bar-item w3-button">BAG()</a></c:if>
 	<c:if test="${empty sMid}"><a href="${ctp}/member/memberLogin" class="w3-bar-item w3-button">BAG()</a></c:if>
 	<c:if test="${!empty sMid}"><a href="${ctp}/product/wishList" class="w3-bar-item w3-button">WISHLIST</a></c:if>
  <c:if test="${!empty sMid}"><a href="${ctp}/member/memberUpdate" class="w3-bar-item w3-button">MODIFY</a></c:if>
  <c:if test="${!empty sMid}"><a href="${ctp}/member/memberLogout" class="w3-bar-item w3-button">LOGOUT</a></c:if>
  <c:if test="${empty sMid}">
	  <a href="${ctp}/member/memberJoin" class="w3-bar-item w3-button w3-right">JOIN</a>
	  <a href="${ctp}/member/memberLogin" class="w3-bar-item w3-button w3-right">LOGIN</a>
  </c:if>
  <c:if test="${sMid == 'admin' || sMid == 'sojung8497'}"><a href="${ctp}/admin/adminMain" class="w3-bar-item w3-button w3-right">관리자 메뉴 <i class="fa fa-gear"></i></a></c:if>
</nav>


<script>
	//Toggle between showing and hiding the sidebar when clicking the menu icon
	var mySidebar = document.getElementById("mySidebar");
	
	function w3_open() {
	  if (mySidebar.style.display === 'block') {
	    mySidebar.style.display = 'none';
	  } else {
	    mySidebar.style.display = 'block';
	  }
	}

	// Close the sidebar with the close button
	function w3_close() {
		mySidebar.style.display = "none";
	}

	// scrolltop - navbar 작아지고 상단에 고정 
	$(window).on('scroll',function(){
		if($(window).scrollTop()){
			$('#myNavbar').removeClass('active');
	  } else{
	    $('#myNavbar').addClass('active');
	  }
	});

	// scrolltop - 최상단메뉴바 스크롤시 감추기 
	$(window).on('scroll',function(){
		if($(window).scrollTop()){
			$('#firstNav').addClass('active');
	  } else{
	    $('#firstNav').removeClass('active');
	  }
	});

</script>