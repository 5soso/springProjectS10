<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adminMain.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script type="text/javascript">
	  google.charts.load('current', {'packages':['bar']});
	  google.charts.setOnLoadCallback(drawChart);
	
	  function drawChart() {
	    var data = google.visualization.arrayToDataTable([
	      ['판매 상품명(색상)', '판매수량'],
	      ['${productNames[0]}', ${count[0]}],
	      ['${productNames[1]}', ${count[1]}],
	      ['${productNames[2]}', ${count[2]}],
	      ['${productNames[3]}', ${count[3]}],
	      ['${productNames[4]}', ${count[4]}]
	    ]);
	
	    var options = {
	      chart: {
	        title: '상품 판매순',
	        subtitle: '2024 상반기',
	      }
	    };
	
	    var chart = new google.charts.Bar(document.getElementById('columnchart_material'));
	
	    chart.draw(data, google.charts.Bar.convertOptions(options));
	  }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/admin/adminNav.jsp" />
<p><br/></p>
<div class="container w3-main" style="margin-left:500px;margin-top:43px;">
  <h2>베스트 상품 (5품목)=${sLevel}=</h2>
  <div id="columnchart_material" style="width: 900px; height: 500px;"></div>
</div>
<p><br/></p>
</body>
</html>