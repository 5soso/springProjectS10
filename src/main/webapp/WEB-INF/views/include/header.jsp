<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <script>
  	$(“.carousel-indicators”).carousel({ interval:2500 });
  </script>
  <style>
  /* Make the image fully responsive */
  .carousel-inner img {
    width: 100%;
    height: 100%;
  }
  
  .numbertext {
		  color: gray;
		  font-size: 15px;
		  position: absolute;
		  margin-left:20px;
		  top: 80px;
		  text-align: right;
	}
  </style>
</head>
<body>

<div id="demo" class="carousel slide" data-ride="carousel" style="margin-top: 80px;">

  <!-- Indicators -->
  <ul class="carousel-indicators">
    <li data-target="#demo" data-slide-to="0" class="active"></li>
    <li data-target="#demo" data-slide-to="1" ></li>
    <li data-target="#demo" data-slide-to="2"></li>
    <li data-target="#demo" data-slide-to="3"></li>
    <li data-target="#demo" data-slide-to="4"></li>
    <li data-target="#demo" data-slide-to="5"></li>
    <li data-target="#demo" data-slide-to="6"></li>
    <li data-target="#demo" data-slide-to="7"></li>
    <li data-target="#demo" data-slide-to="8"></li>
    <li data-target="#demo" data-slide-to="9"></li>
    <li data-target="#demo" data-slide-to="10"></li>
    <li data-target="#demo" data-slide-to="11"></li>
  </ul>
  
  <!-- The slideshow -->
  <div class="carousel-inner">
    <div class="carousel-item active">
    	<div class="numbertext">1 / 11</div>
      <img src="${ctp}/images/main/main1.jpg" width="1100" height="500">
    </div>
    <div class="carousel-item">
    	<div class="numbertext">2 / 11</div>
      <img src="${ctp}/images/main/main2.jpg"  width="1100" height="500">
    </div>
    <div class="carousel-item">
    	<div class="numbertext">3 / 11</div>
      <img src="${ctp}/images/main/main3.jpg"  width="1100" height="500">
    </div>
    <div class="carousel-item">
    	<div class="numbertext">4 / 11</div>
      <img src="${ctp}/images/main/main4.jpg"  width="1100" height="500">
    </div>
    <div class="carousel-item">
    	<div class="numbertext">5 / 11</div>
      <img src="${ctp}/images/main/main5.jpg"  width="1100" height="500">
    </div>
    <div class="carousel-item">
    	<div class="numbertext">6 / 11</div>
      <img src="${ctp}/images/main/main6.jpg"  width="1100" height="500">
    </div>
    <div class="carousel-item">
    	<div class="numbertext">7 / 11</div>
      <img src="${ctp}/images/main/main7.jpg"  width="1100" height="500">
    </div>
    <div class="carousel-item">
    	<div class="numbertext">8 / 11</div>
      <img src="${ctp}/images/main/main8.jpg"  width="1100" height="500">
    </div>
    <div class="carousel-item">
    	<div class="numbertext">9 / 11</div>
      <img src="${ctp}/images/main/main9.jpg"  width="1100" height="500">
    </div>
    <div class="carousel-item">
    	<div class="numbertext">10 / 11</div>
      <img src="${ctp}/images/main/main10.jpg"  width="1100" height="500">
    </div>
    <div class="carousel-item">
    	<div class="numbertext">11 / 11</div>
      <img src="${ctp}/images/main/main11.jpg"  width="1100" height="500">
    </div>
  </div>
  
  <!-- Left and right controls -->
  <a class="carousel-control-prev" href="#demo" data-slide="prev">
    <span class="carousel-control-prev-icon"></span>
  </a>
  <a class="carousel-control-next" href="#demo" data-slide="next">
    <span class="carousel-control-next-icon"></span>
  </a>
</div>

</body>
</html>