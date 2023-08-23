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
.article{
	margin: 0 auto;
	padding: 10px;
	width: 800px;
	height: 750px;
	box-sizing: border-box;
	background-color: #d9c5ce;	
}
input{
	width: 100%;
	height: 30px;
	margin-bottom: 5px;
	box-sizing: border-box;
}
textarea {
	width: 100%;
	height: 500px;
	padding: 10px;
	box-sizing: border-box;
}
button {
	height: 40px;
    border: none;
    margin-top: 10px;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    font-weight: 600;
    transition: 0.25s;
    background-color: #d98baf;
    &:hover {
    background-color: #bf567d;
    transition: 0.7s;
    }
}
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