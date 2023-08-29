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
<script src="../js/jquery-3.7.0.min.js"></script>
<style type="text/css">
table {
	margin: 20px;
	border: 3px solid black;
	width: 900px;
	border-collapse: collapse;
}

tr {
	border-bottom: 1px solid black;
	text-align: center;
}

th {
	font-size: large;
	font-weight: bolder;
	border-bottom: 2px solid black;
	border-collapse: collapse;
	background-color: #f2808a;
}

.mbtitle:hover {
	cursor: pointer;
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

/* .mbcontentDiv{
   clear:both;float 속성 취소
   width: 800px;
   height: auto;
   background-color: #f2808a;
} */
</style>
<script type="text/javascript">
$(function(){
	$('.mbtitle').click(function(){
		let mbno = $(this).siblings('.mbno').text();
		// alert(mbno);
		let td = $(this).parent().next();
		// let parent = $(this).parent();
		
		$.ajax({
			url: './mbcontent',
			type: 'post',
			data: {mbno:mbno},
			dataType:'json',
			success:function(data){
				td.html('<td colspan="7" class="mbcontentDiv">' + data.mbcontent + '</td>');
				// let div = "<div class='row'><div class='div-cell div_content'></div></div>";
			    // parent.after(div);
			},
			error:function(error){
				alert('에러');
			}
		});
	});
});
</script>
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
			<table>
				<thead>
					<tr>
						<th>번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>글쓴이</th>
						<th>날짜</th>
						<th>조회수</th>
						<th>삭제여부</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list }" var="row">
						<tr class="row <c:if test="${row.mbdel eq 0}">gray</c:if>"  >
							<td class="mbno">${row.mbno }</td>
							<td>${row.b_catename }</td>
							<td class="mbtitle">${row.mbtitle }</td>
							<td>${row.m_name }(${row.m_id })</td>
							<td>${row.mbdate}</td>
							<td>${row.mbread }</td>
							<td>${row.mbdel}</td>
						</tr>
						<tr></tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>
</html>