<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board</title>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
</head>
<body>
	<!-- Navigation-->
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
		<div class="container">
			<a class="navbar-brand" href="./"><img
				src="assets/img/navbar-logo.svg" alt="..." /></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				Menu <i class="fas fa-bars ms-1"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav text-uppercase ms-auto py-4 py-lg-0">
					<li class="nav-item"><a class="nav-link" href="./board">게시판</a></li>
					<li class="nav-item"><a class="nav-link" href="#portfolio">Portfolio</a></li>
					<!-- 내부 id를 찾는다. -->
					<li class="nav-item"><a class="nav-link" href="#about">About</a></li>
					<li class="nav-item"><a class="nav-link" href="#team">Team</a></li>
					<li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Masthead-->
	<header class="masthead">
		<div class="container">
			<h1>게시판</h1>
			<table class="table table-dark table-hover table-striped">
				<thead>
					<tr class="row">
						<th class="col-1">번호</th>
						<th class="col-6">제목</th>
						<th class="col-2">날짜</th>
						<th class="col-2">글쓴이</th>
						<th class="col-1">조회수</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${list }" var="row">
					<tr class="row">
						<td class="col-1">${row.bno }</td>
						<td class="col-6">${row.btitle }</td>
						<td class="col-2">${row.bdate }</td>
						<td class="col-2">${row.m_name }</td>
						<td class="col-1">${row.blike }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<button type="button" class="btn btn-secondary">글쓰기</button>
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