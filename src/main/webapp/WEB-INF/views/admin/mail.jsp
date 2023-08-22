<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin || mail</title>
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
			<h1>메일 보내기</h1>
			<form action="./mail" method="post">
				<input type="text" name="title" placeholder="제목을 적어주세요.">
				<input type="text" name="to" placeholder="받는 사람 email주소를 적어주세요.">
				<textarea rows="" cols="" name="content"></textarea>
				<button type="submit">메일 보내기</button>
			</form>
		</div>
	</div>
</div>
</body>
</html>