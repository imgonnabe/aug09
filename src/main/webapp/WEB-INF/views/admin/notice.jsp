<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin || main</title>
<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="../css/admin.css">
<style type="text/css">

</style>
</head>
<body>
<div class="container">
	<%@ include file="menu.jsp" %>
	<div class="main">
		<div class="article">
			<h1>메인화면</h1>
			<div class="box" onclick="url('mutiboard')">
				게시판 관리
				<div id="comment">게시판을 관리합니다.</div>
			</div>
			<div class="box"onclick="url('post')">
				게시글 관리
				<div id="comment">게시글을 관리합니다.</div>
			</div>
			<div class="box"onclick="url('member')">
				회원 관리
				<div id="comment">회원을 관리합니다.</div>
			</div>
			<div class="box" onclick="url('comment')">
				댓글 관리
				<div id="comment">댓글을 관리합니다.</div>
			</div>
			<div class="box" onclick="url('mail')">
				메일 보내기
				<div id="comment">메일을 보내고 관리합니다.</div>
			</div>
			<div class="box" onclick="url('notice')">
				공지사항
				<div id="comment">공지사항을 쓰고 관리합니다.</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>