<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<title>adminNav.jsp</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<style>
		html,body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
		/* Style the sidenav links and the dropdown button */
		.sidenav a, .dropdown-btn {
		  padding: 6px 8px 6px 16px;
		  text-decoration: none;
		  font-size: 17px;
		  color: black;
		  display: block;
		  border: none;
		  background: none;
		  width: 100%;
		  text-align: left;
		  cursor: pointer;
		  outline: none;
		}
		/* On mouse-over */
		.sidenav a:hover, .dropdown-btn:hover {
		  color:black;
		}
		/* Add an active class to the active dropdown button */
		.active {
		  background-color: skyblue;
		  color: black;
		}
		/* Dropdown container (hidden by default). Optional: add a lighter background color and some left padding to change the design of the dropdown content */
		.dropdown-container {
		  display: none;
		  background-color: #ddd;
		  padding-left: 8px;
		}
		.dropdown-container:hover {
			background-color: #ddd;
		}
		/* Optional: Style the caret down icon */
		.fa-caret-down {
		  float: right;
		  padding-right: 8px;
		}
		/* Some media queries for responsiveness */
		@media screen and (max-height: 450px) {
		  .sidenav {padding-top: 15px;}
		  .sidenav a {font-size: 18px;}
		}
		nav {
			margin-top: 30px;
		}
		#home:hover {
			color: white;
			text-decoration: none;
		}
	</style>
</head>
<body class="w3-light-grey">

<!-- Top container -->
<div class="w3-bar w3-top w3-black w3-large mb-5" style="z-index:4;">
  <button class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey" onclick="w3_open();"><i class="fa fa-bars"></i>  Menu</button>
  <span class="w3-bar-item w3-right"><a href="${ctp}/" id="home"><i class="fa fa-home" style="font-size:24px"></i> Munikund</a></span>
</div>
<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white w3-animate-left" style="z-index:3;width:300px;" id="mySidebar"><br>
  <div class="w3-container w3-row">
    <div class="w3-col s4">
      <img src="${ctp}/images/admin/avatar2.png" class="w3-circle w3-margin-right" style="width:46px">
    </div>
    <div class="w3-col s8 w3-bar">
      <span>관리자</span><br>
      <a href="#" class="w3-bar-item w3-button"><i class="fa fa-envelope"></i></a>
      <a href="#" class="w3-bar-item w3-button"><i class="fa fa-user"></i></a>
      <a href="#" class="w3-bar-item w3-button"><i class="fa fa-cog"></i></a>
    </div>
  </div>
  <hr>
  <div class="w3-container">
    <h4>관리자메뉴</h4>
  </div>
  <div class="sidenav">
	  <button class="dropdown-btn">회원관리 
	    <i class="fa fa-caret-down"></i>
	  </button>
	  <div class="dropdown-container">
	    <a href="${ctp}/admin/member/adminMemberList" class="w3-bar-item w3-button w3-padding">회원정보관리</a>
	    <a href="#" class="w3-bar-item w3-button w3-padding">회원탈퇴관리</a>
	  </div>
	  
	  <button class="dropdown-btn">상품관리 
	    <i class="fa fa-caret-down"></i>
	  </button>
	  <div class="dropdown-container">
	    <a href="${ctp}/product/category" class="w3-bar-item w3-button w3-padding">상품분류등록</a>
	    <a href="${ctp}/product/productInput" class="w3-bar-item w3-button w3-padding">상품등록관리</a>
	    <a href="${ctp}/product/adminProductList" class="w3-bar-item w3-button w3-padding">상품등록조회</a>
	    <a href="${ctp}/product/productOption" class="w3-bar-item w3-button w3-padding">옵션등록관리</a>
	  </div>
	  
	  <button class="dropdown-btn">주문관리 
	    <i class="fa fa-caret-down"></i>
	  </button>
	  <div class="dropdown-container">
	    <a href="${ctp}/product/adminOrderStatus" class="w3-bar-item w3-button w3-padding">주문조회</a>
	    <a href="#" class="w3-bar-item w3-button w3-padding">배송관리</a>
	    <a href="#" class="w3-bar-item w3-button w3-padding">교환/반품/취소 관리</a>
	  </div>
	  
	  <button class="dropdown-btn">문의관리 
	    <i class="fa fa-caret-down"></i>
	  </button>
	  <div class="dropdown-container">
	    <a href="${ctp}/qna/adminQnaList" class="w3-bar-item w3-button w3-padding">QnA 조회</a>
	    <a href="#" class="w3-bar-item w3-button w3-padding">1:1문의 조회</a>
	  </div>
	  
	  
	  <button class="dropdown-btn">신고관리 
	    <i class="fa fa-caret-down"></i>
	  </button>
	  <div class="dropdown-container">
	    <a href="${ctp}/complaint/complaintList" class="w3-bar-item w3-button w3-padding">신고조회</a>
	  </div>
	  
	  <button class="dropdown-btn">혜택관리 
	    <i class="fa fa-caret-down"></i>
	  </button>
	  <div class="dropdown-container">
	    <a href="#" class="w3-bar-item w3-button w3-padding">쿠폰등록/삭제</a>
	    <a href="#" class="w3-bar-item w3-button w3-padding">적립금등록/삭제</a>
	    <a href="#" class="w3-bar-item w3-button w3-padding">회원 보유쿠폰 조회</a>
	  </div>
	  
	  <button class="dropdown-btn">홈페이지관리 
	    <i class="fa fa-caret-down"></i>
	  </button>
	  <div class="dropdown-container">
	    <a href="#" class="w3-bar-item w3-button w3-padding">메인이미지 관리</a>
	  </div>
	  
	  <button class="dropdown-btn">기타관리 
	    <i class="fa fa-caret-down"></i>
	  </button>
	  <div class="dropdown-container">
	    <a href="#" class="w3-bar-item w3-button w3-padding">임시파일 관리</a>
	  </div>
	  
	</div>
</nav>


<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>


<script>
	// Get the Sidebar
	var mySidebar = document.getElementById("mySidebar");
	
	// Get the DIV with overlay effect
	var overlayBg = document.getElementById("myOverlay");
	
	// Toggle between showing and hiding the sidebar, and add overlay effect
	function w3_open() {
	  if (mySidebar.style.display === 'block') {
	    mySidebar.style.display = 'none';
	    overlayBg.style.display = "none";
	  } else {
	    mySidebar.style.display = 'block';
	    overlayBg.style.display = "block";
	  }
	}
	
	// Close the sidebar with the close button
	function w3_close() {
	  mySidebar.style.display = "none";
	  overlayBg.style.display = "none";
	}
</script>

<script>
	/* Loop through all dropdown buttons to toggle between hiding and showing its dropdown content - This allows the user to have multiple dropdowns without any conflict */
	var dropdown = document.getElementsByClassName("dropdown-btn");
	var i;
	
	for (i = 0; i < dropdown.length; i++) {
	  dropdown[i].addEventListener("click", function() {
	    this.classList.toggle("active");
	    var dropdownContent = this.nextElementSibling;
	    if (dropdownContent.style.display === "block") {
	      dropdownContent.style.display = "none";
	    } else {
	      dropdownContent.style.display = "block";
	    }
	  });
	}
</script>

</body>
</html>
