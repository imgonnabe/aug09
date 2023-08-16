<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
					<li class="nav-item"><a class="nav-link" href="./board">board</a></li>
					<li class="nav-item"><a class="nav-link" href="./multiboard?board=1">multi board</a></li>
					<!-- 내부 id를 찾는다. -->
					<li class="nav-item"><a class="nav-link" href="./notice">notice</a></li>
					<li class="nav-item"><a class="nav-link" href="./about">about</a></li>
					
					<c:choose>
						<c:when test="${sessionScope.m_id ne null }">
							<li class="nav-item"><a class="nav-link" href="./myInfo@${sessionScope.m_id }">myInfo</a></li>
							<li class="nav-item"><a class="nav-link" onclick="logout()">logout</a></li>
						</c:when>
						<c:otherwise>
							<li class="nav-item"><a class="nav-link" href="./login">login</a></li>
						</c:otherwise>
					</c:choose>
					
				</ul>
			</div>
		</div>
	</nav>
	<script>
		function logout(){
			if(confirm("로그아웃하시겠습니까?")){
				location.href="./logout";
			}
		}
	</script>