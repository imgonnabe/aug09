<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>write</title>
<script src="./js/jquery-3.7.0.min.js"></script>
<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<style type="text/css">
.write-form{
	background-color: white;
	padding: 5px;
	text-align: left;
	color: black;
}
</style>
</head>
<script type="text/javascript">
	$(function() {
		$('#summernote').summernote({height:400});
	});
</script>
<body>
	<%@ include file="menu.jsp"%>
	<!-- Masthead-->
	<header class="masthead">
		<div class="container">
		<div class="rounded-3 write-form">
			<form action="./write" method="post">
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">제목</span>
					</div>
					<input type="text" class="form-control" name="title">
				</div>

				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">내용</span>
					</div>
					<textarea id="summernote" class="form-control" name="content"></textarea>
				</div>
				<button type="button" class="btn btn-primary">저장</button>
			</form>
			</div>
		</div>
	</header>
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="detail">
						<div class="detail-name">이름</div>
						<div class="detail-date-read">
							<div class="detail-date">날짜</div>
							<div class="detail-read">조회수</div>
						</div>
						<div class="detail-content">본문내용</div>
					</div>
				</div>
			</div>
		</div>
	</div>

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