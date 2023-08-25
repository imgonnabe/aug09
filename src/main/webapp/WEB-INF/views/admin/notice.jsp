<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin || notice</title>
<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="../css/admin.css">
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<style type="text/css">
.notice-write-form {
	margin: 10px;
	width: 50%;
	height: auto;
}

table {
	width: 800px;
	float: left;
}

.content-view {
	width: calc(100% - 800px);
	height: 400px;
	float: right;
}

.title {
	width: 30%;
	height: 30px;
	margin: 10px;
}

.content {
	margin: 10px;
	padding: 10px;
}

input[type=file]::file-selector-button {
  width: 100px;
  height: 40px;
  background-color: #d9b0c3;
  margin: 10px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-weight: 600;
  &:hover {
    background-color: #d98baf;
    transition: 0.7s;
  }
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
<script type="text/javascript">
	$(function(){
		$(".ntitle").click(function(){
			// alert($(this).siblings(".nno").text());
			let nno = $(this).siblings(".nno").text();
			
			$.ajax({
				url : './noticeDetail',
				type : 'post',
				data : {nno : nno},
				dataType : 'json',
				success : function(data){
					// alert(data.result);
					$(".content-ncotent").text(data.ncontent);
					$(".content-ncotent").css('background-color','#fac1b8');
					$(".content-ncotent").css('display','inline-block');
					$(".content-ncotent").css('font-size','larger');
					$(".content-ncotent").css('font-weight','bolder');
				},
				error : function(data){
					alert('오류' + data);
				}
			});
		});
		
		$(document).on("click",".xi-eye, .xi-eye-off", function(){// 동적
			let nno = $(this).parent().siblings(".nno").text();
			let nnoTD = $(this).parent();
			// alert(nno);
			// alert(nnoTD.html());// →→→→→→→<i class="xi-eye-off"></i> 여기서 바꾸면 <i class="xi-eye"></i>
			$.ajax({
				url : './noticeHideShow',
				type : 'post',
				data : {nno : nno},
				dataType : 'json',
				success : function(data){
					// alert(data.result);
					if(nnoTD.html().indexOf("-off") != -1){
						nnoTD.html('<i class="xi-eye"></i>');
					} else {
						nnoTD.html('<i class="xi-eye-off"></i>');
					}
				},
				error : function(data){
					alert('오류' + data);
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
			<h1>공지사항</h1>
			<table border="1px">
				<tr>
					<td>번호</td>
					<td>제목</td>
					<td>게시일</td>
					<td>글쓴이</td>
					<td>삭제여부</td>
					<td>파일유무</td>
				</tr>
				<c:forEach items="${notice }" var="row">
					<tr>
						<td class="nno">${row.nno }</td>
						<td class="ntitle">${row.ntitle }</td>
						<td>${row.ndate }</td>
						<td>${row.m_id }</td>
						<td>
							<c:choose>
								<c:when test="${row.ndel eq 1 }"><i class="xi-eye"></i></c:when>
								<c:otherwise><i class="xi-eye-off"></i></c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:if test="${row.norifile ne null }"><i class="xi-file-check"></i></c:if>
						</td>
					</tr>
				</c:forEach>
			</table>
			<div class="content-view">
				<div class="content-ncotent"></div>
				<div class="content-nrealfile"></div>
			</div>
			<div class="notice-write-form">
				<form action="./noticeWrite" method="post" enctype="multipart/form-data">
					<input type="text" name="title" class="title"><br>
					<textarea name="content" cols="100px" rows="20px" class="content"></textarea><br>
					<input type="file" name="file" class="file"><br>
					<button type="submit" class="btn">글쓰기</button>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>