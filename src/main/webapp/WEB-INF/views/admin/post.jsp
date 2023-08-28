<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin || post</title>
<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
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
	text-align: center;
}

.gray{
	background-color: gray;
}

.btn {
	height: 40px;
    border: none;
    margin: 10px;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    font-weight: 600;
    transition: 0.25s;
    background-color: #d9b0c3;
    &:hover {
    background-color: #d98baf;
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
			<h1>게시글 관리 : ${list[0].count }개의 글이 있음</h1>
			<div class="boardlist">
				<button class="btn" onclick="location.href='./post?cate=0'">전체보기</button>
				<c:forEach items="${boardlist }" var="row">
					<button class="btn" onclick="location.href='./post?cate=${row.mb_cate}'">${row.b_catename }</button>
				</c:forEach>
				<div style="margin: 10px;">
					<form action="./post" method="get">
						<select name="searchN">
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="nick">글쓴이</option>
							<option value="id">ID</option>
						</select>
						<input type="text" name="searchV" required="required">
						<input type="hidden" name="cate" value="${param.cate }">
						<button type="submit">검색</button>
					</form>
				</div>
			</div>
			<div class="table">
				<div class="heading">
					<div class="row">
						<div class="head">번호</div>
						<div class="head">카테고리</div>
						<div class="head">제목</div>
						<div class="head">글쓴이</div>
						<div class="head">날짜</div>
						<div class="head">조회수</div>
						<div class="head">삭제여부</div>
					</div>
				</div>
				<div class="body">
					<c:forEach items="${list }" var="row">
						<div class="row <c:if test="${row.mbdel eq 0}">gray</c:if>"  >
							<div class="cell">${row.mbno }</div>
							<div class="cell">${row.b_catename }</div>
							<div class="cell">${row.mbtitle }</div>
							<div class="cell">${row.m_name }(${row.m_id })</div>
							<div class="cell">${row.mbdate}</div>
							<div class="cell">${row.mbread }</div>
							<div class="cell">${row.mbdel}</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>