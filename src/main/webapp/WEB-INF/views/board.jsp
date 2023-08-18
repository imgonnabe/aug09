<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board</title>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<script src="./js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
$(function(){
	$(document).on("click", ".del", function(){
		let bno = $(".bno").val();
		let uuid = $(".uuid").val();
		alert(uuid);
		// 가상 form 만들어서 전송
		let form = $('<form></form>');
		form.attr('action', './delete');
		form.attr('method', 'post');
		
		form.append($("<input>", {type:'hidden', name:'bno', value:bno}));/* json */
		form.append($("<input>", {type:'hidden', name:'uuid', value:uuid}));
		
		form.appendTo("body");
		
		form.submit();
	});
	
	$(".detail").click(function(){
		let bno = $(this).children("td").eq(0).html();
		let title = $(this).children("td").eq(1).text();
		let name = $(this).children("td").eq(2).html();
		let date = $(this).children("td").eq(3).html();
		let read = Number($(this).children("td").eq(4).html());
		let comment = $(this).children("td").eq(1).children(".bg-secondary").text().length;
		
		if(comment > 0){
			title = title.slice(0, -comment);// 끝에서 comment만큼 빠짐, 한줄로 써야 작동
		}
		
		$.ajax({
			url : "./detail",
			type : "post",
			data : {bno : bno},
			dataType : "json",
			success:function(data){
				// alert(data.content);
				$(".modal-title").text(title);
				name += '<img src="./img/update2.png"><img src="./img/delete2.png" class="del">';
				name += '<input type="hidden" class="bno" value="'+bno+'">';
				name += '<input type="hidden" class="uuid" value="'+data.uuid+'">';
				
				$(".detail-name").html(name);
				$(".detail-date").text(date);
				$(".detail-read").text(data.ip + " / " + read);
				$(".detail-content").html(data.content);
				$("#exampleModal").modal("show");
			},
			error:function(error){
				alert("에러");
			}
		});
		
	});
	
});
</script>
</head>
<body>
	<%@ include file="menu.jsp" %>
	<!-- Masthead-->
	<header class="masthead">
		<div class="container">
			<h1>게시판</h1>
			<table class="table table-dark table-hover table-striped">
				<thead>
					<tr class="row">
						<th class="col-1">번호</th>
						<th class="col-6">제목</th>
						<th class="col-2">글쓴이</th>
						<th class="col-2">날짜</th>
						<th class="col-1">조회수</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${list }" var="row">
					<tr class="row detail">
						<td class="col-1">${row.bno }</td>
						<td class="col-6 title">${row.btitle }<c:if test="${row.commentcount ne 0 }">&nbsp;<span class="badge bg-secondary">${row.commentcount }</span></c:if></td>
						<td class="col-2">${row.m_name }</td>
						<td class="col-2">${row.bdate }</td>
						<td class="col-1">${row.blike }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<button type="button" class="btn btn-secondary" onclick="location.href='./write'">글쓰기</button>
			<!-- Button trigger modal -->
			<button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal">
			  모달
			</button>
			<!-- 부트스트랩에서 사용, data-toggle 옵션은 항상 필요하며
			<a>태그의 경우에만 data-target 대신 href 를 사용할 수 있다. href="#myModal"
			만약 배경을 클릭해도 모달이 닫히지 않게 하려면 data-backdrop="static" 같은 옵션을 이 때 써도 된다. -->
			<button type="button" class="modalOpen btn btn-light">모달열기</button>
		</div>
	</header>
	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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