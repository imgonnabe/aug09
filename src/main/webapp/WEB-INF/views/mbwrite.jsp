<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<script src="./js/jquery-3.7.0.min.js"></script>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />

<style type="text/css">
	.write-form {
		background-color: white;
		padding: 10px;
		text-align: left;
		color: black;
	}
	.write-form textarea {
		wid
	}
}
</style>
<script type="text/javascript">
$(function(){
	$(".writeBtn").click(function(){
		let id = $("#title").val();
		if(id == null || id == ""){
			alert("제목을 입력하세요.");
			$("#title").focus();
			return false;
		}
		
		let summernote = $("#summernote").val();
		if(summernote == null || summernote == ""){
			alert("내용을 입력하세요.");
			$("#summernote").focus();
			return false;
		}
		//두 검사가 성공 > form전송
		$("#form").submit();
		
	});
});
</script>
</head>
<body>
	<%@ include file="menu.jsp"%>
	<!-- Masthead-->
	<header class="masthead">
		<div class="container">
			<div class="rounded-3 write-form">
			<form action="./mbwrite" method="post">
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">제목</span>
					</div>
					<input type="text" class="form-control" id="title" name="title">
				</div>
				<div class="input-group mb-3">
					<div class="input-group-prepend">
						<span class="input-group-text">내용</span>
					</div>
					<textarea id="summernote" class="form-control" name="content"></textarea>
				</div>
				<input type="hidden" name="board" value="${board }">
				<button type="submit" class="btn btn-primary writeBtn">저장</button>
			</form>
			</div>
		</div>
	</header>
<script type="text/javascript">
	$(function() {
		$('#summernote').summernote({height: 400});
	});
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/scripts.js"></script>
<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>

</body>
</html>