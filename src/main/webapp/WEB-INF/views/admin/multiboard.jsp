<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin || multiboard</title>
<link rel="stylesheet"
	href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="../css/admin.css">
<style type="text/css">
.table {
	display: table;
	border: 3px solid black;
	width: 800px;
	border-collapse: collapse;
}

.heading {
	display: table-header-group;
	background-color: #d9c5ce;
	font-weight: bold;
}

.body {
	display: table-row-group;
}

.row {
	display: table-row;
	border: 1px solid black;
}

.head, .cell {
	display: table-cell;
	padding: 3px;
}
</style>
</head>
<body>
	<div class="container">
		<%@ include file="menu.jsp"%>
		<div class="main">
			<div class="article">
				<h1>멀티보드</h1>

				<div class="table">
					<div class="heading">
						<div class="row">
							<div class="head">번호</div>
							<div class="head">카테고리</div>
							<div class="head">이름</div>
							<div class="head">url</div>
							<div class="head">참고</div>
						</div>
					</div>
					<div class="body">
						<c:forEach items="${list }" var="row">
							<div class="row">
								<div class="cell">${row.b_no }</div>
								<div class="cell">${row.mb_cate }</div>
								<div class="cell">${row.b_catename }</div>
								<div class="cell">${row.b_url }</div>
								<div class="cell">${row.b_comment }</div>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="" style="margin: 10px">
					<form action="./multiboard" method="post">
						<input type="number" name="cateNum" required="required" placeholder="게시판 번호 입력">
						<input type="text" name="name" required="required" placeholder="게시판 이름 입력">
						<input type="text" name="comment" required="required" placeholder="참고">
						<button type="submit" class="btn">저장</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>