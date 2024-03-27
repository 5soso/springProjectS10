<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<style>
	/* shop menu */
	.w3-bar .w3-button {
	  padding: 16px;
	}
	.header_scroll_fixed {
		position: fixed;
		top: 0;
		background: rgba(255,255,255,0.95);
		transition: all 0.2s ease;
		-webkit-transition: all 0.2s ease;
		box-shadow: 0 3px 7px 1px rgba(0,0,0,0.05) !important;
		-webkit-box-shadow: 0 3px 7px 1px rgba(0,0,0,0.05) !important;
		width: 100%;
	}
	
	/* active css */
	#myNavbar.active {
		position: fixed;
		top: 0;
		background: rgba(255,255,255);
		transition: all 0.2s ease;
		-webkit-transition: all 0.2s ease;
		box-shadow: 0 3px 7px 1px rgba(0,0,0,0.05) !important;
		-webkit-box-shadow: 0 3px 7px 1px rgba(0,0,0,0.05) !important;
		width: 100%;
	}
	
	#myNavbar.active .logo ,#myNavbar.active {padding:15px 0; transition:.5s;}
	#myNavbar.active a {color:black;font-size:14px;}
	#myNavbar.active .logo {height:10px; margin-left: 20px; padding: 20px;}
	
	.dropdown {
	  position: relative;
	  display: inline-block;
	}
	
	.dropbtn {
		padding: 8px;
		margin: 2px;
		border: none;
		cursor: pointer;
		background: rgba(255,255,255,0.95);
		transition: all 0.2s ease;
	}
	
	.dropdown-content {
	  display: none;
	  position: absolute;
	  background-color: #f1f1f1;
	  min-width: 160px;
	  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); 
	  z-index: 1;
	}
	
	.dropdown-content a {
	  color: black;
	  padding: 12px 16px;
	  text-decoration: none;
	  display: block;
	}
	
	.dropdown-content a:hover {background-color: #ddd;}
	
	.dropdown:hover .dropdown-content {display: block;}
	
	.dropdown:hover .dropbtn {
		background-color: #3e8e41;
		background: rgba(255,255,255,0.95);
		transition: all 0.2s ease;	
	}	
	
	</style>

<!-- Navbar (sit on top) -->
<div class="w3-top">
  <div class="header_scroll_fixed" id="myNavbar">
    <a href="#top" class="logo w3-bar-item w3-button w3-wide">MUNIKUND</a>
    <!-- Right-sided navbar links -->
    <div class="dropdown w3-right w3-hide-small">
      <a href="#pricing" class="w3-bar-item w3-button">Q&A</a>
    </div>
    <div class="dropdown w3-right w3-hide-small">  
      <a href="#contact" class="w3-bar-item w3-button">STORES</a>
    </div>
    <div class="dropdown w3-right w3-hide-small">
      <a href="#work" class="w3-bar-item w3-button">REVIEW</a>
    </div>
    <div class="dropdown w3-right">
      <button onclick="location.href='#team';" class="dropbtn">SHOP</button>
      <div class="dropdown-content">
		    <a href="#">ALL</a>
		    <a href="#">CLOTHES</a>
		    <a href="#">WALK</a>
		    <a href="#">LIVING</a>
		    <a href="#">ACC.</a>
		    <a href="#">LAST PIECE</a>
		  </div>
    </div>
    <div class="dropdown w3-right">
      <button onclick="location.href='#about';" class="dropbtn">STORY</button>
      <div class="dropdown-content">
		    <a href="#">ABOUT</a>
		    <a href="#">NEWS</a>
		    <a href="#">CAMPAIGN</a>
		  </div>
    </div>
    <!-- Hide right-floated links on small screens and replace them with a menu icon -->

    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-right w3-hide-large w3-hide-medium" onclick="w3_open()">
      <i class="fa fa-bars"></i>
    </a>
  </div>
</div>


<!-- Sidebar on small screens when clicking the menu icon -->
<nav class="w3-sidebar w3-bar-block w3-black w3-card w3-animate-left w3-hide-medium w3-hide-large" style="display:none" id="mySidebar">
  <a href="javascript:void(0)" onclick="w3_close()" class="w3-bar-item w3-button w3-large w3-padding-16">Close ×</a>
  <a href="#about" onclick="w3_close()" class="w3-bar-item w3-button">ABOUT</a>
  <a href="#team" onclick="w3_close()" class="w3-bar-item w3-button">TEAM</a>
  <a href="#work" onclick="w3_close()" class="w3-bar-item w3-button">WORK</a>
  <a href="#pricing" onclick="w3_close()" class="w3-bar-item w3-button">PRICING</a>
  <a href="#contact" onclick="w3_close()" class="w3-bar-item w3-button">CONTACT</a>
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

// scrolltop 
$(window).on('scroll',function(){
	if($(window).scrollTop()){
		$('#myNavbar').removeClass('active');
  } else{
    $('#myNavbar').addClass('active');
  }
});

</script>