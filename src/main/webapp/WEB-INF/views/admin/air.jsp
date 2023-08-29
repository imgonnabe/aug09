<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin || air</title>
<link rel="stylesheet"
   href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="../css/admin.css">
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
   google.charts.load('current', {'packages' : [ 'line' ]});
   google.charts.setOnLoadCallback(drawChart);

   function drawChart() {

      var data = new google.visualization.DataTable();
      data.addColumn('date', '날짜');
      data.addColumn('number', '미세먼지');
      data.addColumn('number', '초미세먼지');

      data.addRows([
         <c:forEach items="${list }" var="a">
            [ new Date('${a.msurDt}'), ${a.pm10Value}, ${a.pm25Value} ],
         </c:forEach>
            ]);

      var options = {
         chart : {
            title : '강남구 대기질',
            subtitle : '2023년'
         },
         width : 1000,
         height : 500
      };

      var chart = new google.charts.Line(document.getElementById('linechart_material'));

      chart.draw(data, google.charts.Line.convertOptions(options));
   }
</script>
<script type="text/javascript">
<!-- progress bar 만들기 -->
	$(function(){
		window.onscroll = function(){
			scrollFunction();
		}
		
		function scrollFunction(){
			let windowScroll = document.body.scrollTop || document.documentElement.scrollTop;
			let height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
			let scrolled = (windowScroll / height) * 100;
			document.getElementById('addScrollBar').style.width = scrolled + '%';
			// scrollTop : 원글 맨 처음부터 ~ 현재 화면에 보이는 부분 위까지의 길이
			// scrollHeight : 전체 글의 길이
			// clientHeight : 현재 화면에서 보이는 길이 (스크롤 사이즈, 보더 사이즈는 포함 X)
		}
	});
</script>
<style type="text/css">
.progress-container {
	position: fixed;
	width: 100%;
	height: 5px;
	z-index: 10;/* 창을 순서대로 배치, 숫자가 높을수록 눈에 가깝게 배치, position 속성이 있어야 사용 가능 */
}

.progress-bar {
	width: 0%;
	height: 10px;
	background-color: pink;
}
</style>
</head>
<body>
<!-- progress bar -->
<div class="progress-container">
	<div class="progress-bar" id="addScrollBar"></div>
</div>
   <div class="container">
      <%@ include file="menu.jsp"%>
      <div class="main">
         <div class="article">
            <h1>강남구 공기질</h1>
            <div id="linechart_material"></div>
            <table border="1">
               <tr>
                  <td>날짜</td>
                  <td>이산화질소</td>
                  <td>미세먼지</td>
                  <td>초미세먼지</td>
                  <td>일산화탄소</td>
                  <td>아황산 가스</td>
               </tr>
               <c:forEach items="${list }" var="a">
                  <tr>
                     <td>${a.msurDt }</td>
                     <td>${a.no2Value}</td>
                     <td>${a.pm10Value}</td>
                     <td>${a.pm25Value}</td>
                     <td>${a.coValue}</td>
                     <td>${a.so2Value}</td>
                  </tr>
               </c:forEach>
            </table>
            <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
         </div>
      </div>
   </div>
</body>
</html>