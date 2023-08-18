<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 정보</title>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<script src="./js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
	$(function() {

	});
</script>
</head>
<body>
	<%@ include file="menu.jsp"%>
	<!-- Masthead-->
	<header class="masthead">
		<div class="container">
			<h1>사용자 정보 보기</h1>
			<div id="myinfo">
			
				<div id="m_no" style="visibility: hidden;">${myInfo.m_no }</div>
				<div id="m_id">아이디 : ${myInfo.m_id }</div>
				<div id="m_name">이름 : ${myInfo.m_name }</div>
				<div id="m_joindate">가입일자 : ${myInfo.m_joindate }</div>
				<div id="m_addr">주소 : ${myInfo.m_addr }</div>
				<div id="m_birth">생일 : ${myInfo.m_birth }</div>
				<div id="m_grade">등급 : ${myInfo.m_grade }</div>
				<div id="m_mbti">mbti : ${myInfo.m_mbti }</div>
				<div id="m_gender">
				성별 : 
					<c:choose>
						<c:when test="${myInfo.m_gender == 1 }">남</c:when>
						<c:otherwise>여</c:otherwise>
					</c:choose>
				</div>
			
			</div>
		</div>
	</header>

	<!-- 다 로딩된 후에 js 띄운다 -->
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="js/scripts.js"></script>
	<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
	<!-- * *                               SB Forms JS                               * *-->
	<!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
	<!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>