<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<title>home.jsp</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- 
	<script>
		'use strict';
		//let $topBtn = document.querySelector(".moveTopBtn");
		let moveTopLink = document.getElementById("#moveTopLink").value;
		// 버튼 클릭 시 맨 위로 이동
		moveTopLink.onclick = () => {
		  window.scrollTo({ top: 0, behavior: "smooth" });  
		}
		
		//let $bottomBtn = document.querySelector(".moveBottomBtn");
		let moveBottomLink = document.getElementById("#moveBottomLink").value;
		// 버튼 클릭 시 페이지 하단으로 이동
		moveBottomLink.onclick = () => {
		  window.scrollTo({ 
		    top: document.body.scrollHeight, // <- 페이지 총 Height
		    behavior: "smooth" 
		  });
		};
	</script>
	 -->
	 <script>
		// 천단위마다 콤마를 표시해 주는 함수
    function numberWithCommas(x) {
      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
	 </script>
	<style>
		body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", sans-serif}
		
		h1 {font-weight: bold;}
		
		body, html {
		  height: 100%;
		  line-height: 1.8;
		}
		
		.w3-bar .w3-button {padding: 16px;}
		
		.scroll_wrap {overflow: hidden;}
		.scroll_on {padding:0px; margin:10px; text-align: center;opacity: 0;transition: all 1s;}
		.scroll_on.active {opacity: 1 !important;transform: translate(0, 0) !important;}
		.scroll_on.type_top {transform: translate(0, -50px);}
		.scroll_on.type_bottom {transform: translate(0, 50px);}
		.scroll_on.type_left {transform: translate(-50px, 0);}
		.scroll_on.type_right {transform: translate(50px, 0);}
		
		.ment {background-color: white;}
		#ment {background-color: white; font-size: 30pt; font-weight: bolder;}
		#lastMent {background-color: white; color: gray; margin-top: 50px;};
		
		#productInfo {
			color: gray;
		}
		
		.price {font-weight: bolder; font-size: 12pt;}
		#price {font-weight: bolder; font-size: 12pt;}
		
		#snsIcon {
		  position: -webkit-sticky; /* safari 지원 */
		  position: fixed;
		  bottom: 120px;
		  right: 10px;
		  width: 60px;
		  background-color:transparent;
		}
		
		#scrollIcon {
			position: -webkit-sticky; /* safari 지원 */
		  position: fixed;
		  bottom: 20px;
		  right: 10px;
		  width: 60px;
		  background-color:transparent;
		}
 	
		#mainImg:hover {
			transform: scale(1.1); /* 확대 비율 조정 가능 */
  		transition: transform 0.3s ease;
		}
		
		.bannerInfo {
			color: #A4A4A4;
			font-weight: bold;
		}
		
		.mainFooter {
			background-image: url("${ctp}/images/main/main_about.jpg");
			background-attachment: fixed;
		}
		
		.readBtn:hover {
			text-decoration: none;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/header.jsp" />

<!-- banner Section -->
<div class="w3-container scroll_wrap" style="padding:128px 16px" id="banner">
	<p class="ment scroll_on type_left" style="background-color: white; font-size: 12pt;">2024 SPECIAL F/W COLLECTION</p>
  <p class="ment scroll_on type_right" id="ment">눈에 보이지 않는, 상상속에 존재하는<br/>INVISIBLE FRIENDS 시리즈!</p>
  <p class="scroll_on" id="lastMent">우리의 상상 속에 숨어 있는 인비져블 프렌즈를 함께 찾으러 가요!</p>
  <div class="w3-row w3-center" style="margin-top:80px" >
    <div class="w3-third w3-container">
    	<div class="scroll_on type_top">
    		<a href="${ctp}/product/productContentShop?idx=3"><img src="${ctp}/images/main/banner/banner1.jpg" /></a>
    	</div>
      <p class="w3-large"><h4><b>Thermal Up Padding</b></h4></p>
      <p class="bannerInfo">
	  		쉽게 입히는 초경량 발열패딩<br/>
	  	  써멀업 패딩을 만나보세요
	  	</p>
    </div>
    <div class="w3-third w3-container">
    	<div class="scroll_on">
    		<a href="${ctp}/product/productContentShop?idx=20"><img src="${ctp}/images/main/banner/banner2.jpg" /></a>
    	</div>
      <p class="w3-large"><h4><b>Water-Block Leash</b></h4></p>
      <p class="bannerInfo">
        강력한 방수력을 지닌<br/>
      	뮤니쿤트 워터블록 리쉬와 함께 하세요
     	</p>
    </div>
    <div class="w3-third w3-container">
    	<div class="scroll_on type_top">
    		<a href="${ctp}/product/productContentShop?idx=22"><img src="${ctp}/images/main/banner/banner3.jpg" /></a>
    	</div>
      <p class="w3-large"><h4><b>Water-Block Silicon Bed</b></h4></p>
      <p class="bannerInfo">
      	편안한 쿠션감과 간편한 관리가 가능한<br/>
      	워터블록 실리콘 배드를 만나보세요.
      </p>
    </div>
  </div>
</div>

<!-- BestItems Section -->
<div class="w3-container" style="padding:80px 16px; margin-top: 0px;" id="bestItems">
  <h3 class="w3-center scroll_on type_left" style="background-color: white;">BEST ITEMS</h3>
	<hr class="w3-border-black scroll_on type_left" style="margin:auto;width:5%;border-width: 4px">
  <div class="w3-row-padding" style="margin-top:100px">
  	<c:forEach var="vo" items="${vos}">
	    <div class="w3-col l3 m6 w3-center">
				<c:set var="productImg" value="${fn:split(vo.thumbImg, '/')}" />
        <img src="${ctp}/product/${productImg[0]}" style="width:60%" onclick="onClick(this)" class="w3-hover-opacity" />
	      <div><h5>${vo.categorySubName} - ${vo.productName}</h5></div>
	      <hr style="margin: 4px;"/>
	      <div class="productInfo" id="productInfo" style="color:#A4A4A4;">${vo.detail}</div>
	      <div class="price mt-1" id="price"><fmt:formatNumber value="${vo.mainPrice}" pattern="#,###"/>원</div>
	    </div>
    </c:forEach>
  </div>
</div>

<!-- 메인 하단 about -->
<div style="margin-top: 200px;">
	<div class="mainFooter" style="height: 300px;">
		<h3 class="w3-center scroll_on type_left" style="line-height: 300px; color: white;">ABOUT</h3>
	</div>
	<div class="" style="padding:auto; margin: 0px;">
	  <div class="w3-row-padding">
	    <div class="w3-col m6">
	      <img class="w3-image" src="${ctp}/images/main/mainFooter.jpg" width="900" height="394">
	    </div>
	    <div class="w3-col m6 pl-3" style="padding-left: 0px;">
	      <h3 style="margin-top: 50px;"><b>도시의 강아지들을 위한 디자인</b></h3>
	      <br/><p></p>
	      <p style="font-size: 16pt;">뮤니쿤트는 munich와 hund의 합성어로 '뮌헨의 개'를 의미합니다. <br/>
	      아이들이 자유롭게 뛰어놀던 뮌헨의 아름다운 모습에 영감을 받은 뮤니쿤트는 도시에서 생활하는 반려견을 위한 배려를 담은 디자인으로 사람과 반려견의 행복한 라이프 스타일을 제안합니다.
	      </p>
	      <br/>
	      <p><a href="${ctp}/story/about" class="w3-button w3-black readBtn">Read more</a></p>
	    </div>
	  </div>
	</div>
	<div class="news" style="background-color: white; height: 400px;">
		<h3 class="w3-center" style="background-color: #F2F2F2; line-height: 400px;">NEWS</h3>
	</div>
</div>

<!-- Modal for full size images on click-->
<div id="modal01" class="w3-modal w3-black" onclick="this.style.display='none'">
  <span class="w3-button w3-xxlarge w3-black w3-padding-large w3-display-topright" title="Close Modal Image">×</span>
  <div class="w3-modal-content w3-animate-zoom w3-center w3-transparent w3-padding-64">
    <img id="img01" class="w3-image">
    <p id="caption" class="w3-opacity w3-large"></p>
  </div>
</div>

<jsp:include page="/WEB-INF/views/include/footer.jsp" /> 

<!-- 하단영역  -->
<div id="snsIcon">
	<p><img class="sticky" id="kakao" src="${ctp}/images/main/kakao.png" alt="kakao" width="50px"></p>
<%-- 	<p><img class="sticky" id="naver" src="${ctp}/images/main/naver.png" alt="naver" width="50px"></p> --%>
</div>
<div id="scrollIcon">
  <div class="moveTopLink"><a href="#" id="moveTopLink"><img class="sticky" id="scroll" src="${ctp}/images/main/scroll_icon_01.png" alt="moveTopLink" width="50px"></a></div>
  <div class="moveBottomLink"><a href="#" id="moveBottomLink"><img class="sticky" id="scroll" src="${ctp}/images/main/scroll_icon_02.png" alt="moveBottomLink" width="50px"></a></div>
</div>


<script>
	// Modal Image Gallery
	function onClick(element) {
	  document.getElementById("img01").src = element.src;
	  document.getElementById("modal01").style.display = "block";
	  var captionText = document.getElementById("caption");
	  captionText.innerHTML = element.alt;
	}
</script>
<script>
	$(document).ready(function() {
		// 클래스가 "scroll_on"인 모든 요소를 선택합니다.
		const $counters = $(".scroll_on");
		
		// 노출 비율(%)과 애니메이션 반복 여부(true/false)를 설정합니다.
		const exposurePercentage = 100; // ex) 스크롤 했을 때 $counters 컨텐츠가 화면에 100% 노출되면 숫자가 올라갑니다.
		const loop = true; // 애니메이션 반복 여부를 설정합니다. (true로 설정할 경우, 요소가 화면에서 사라질 때 다시 숨겨집니다.)
		
		// 윈도우의 스크롤 이벤트를 모니터링합니다.
		$(window).on('scroll', function() {
		  // 각 "scroll_on" 클래스를 가진 요소에 대해 반복합니다.
		  $counters.each(function() {
		    const $el = $(this);
		
		    // 요소의 위치 정보를 가져옵니다.
		    const rect = $el[0].getBoundingClientRect();
		    const winHeight = window.innerHeight; // 현재 브라우저 창의 높이
		    const contentHeight = rect.bottom - rect.top; // 요소의 높이
		    
		    // 요소가 화면에 특정 비율만큼 노출될 때 처리합니다.
		    if (rect.top <= winHeight - (contentHeight * exposurePercentage / 100) && rect.bottom >= (contentHeight * exposurePercentage / 100)) {
		    	$el.addClass('active');
		    }
		    // 요소가 화면에서 완전히 사라졌을 때 처리합니다.
		    if (loop && (rect.bottom <= 0 || rect.top >= window.innerHeight)) {
		    	$el.removeClass('active');
		    }
		  });
		}).scroll();
	});
</script>
</body>
</html>
