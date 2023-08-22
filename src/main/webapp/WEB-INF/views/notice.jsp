<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> ❤ notice</title>
	<!-- Core theme CSS (includes Bootstrap)-->
    <link href="css/styles.css" rel="stylesheet" />
    <script src="./js/jquery-3.7.0.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.0/font/bootstrap-icons.css">
	<style type="text/css">
		
	</style>
	<script type="text/javascript">
	$(function(){
		
	});
	</script>
</head>
<body>
<%@ include file="menu.jsp" %>
 <!-- Masthead-->
        <header class="masthead">
            <div class="container">
	            <h1>공지</h1>
				<div id="notice">
					<table class="table table-dark table-hover table-striped">
						<thead>
							<tr class="row">
								<th class="col-1">번호</th>
								<th class="col-6">제목</th>
								<th class="col-2">글쓴이</th>
								<th class="col-2">날짜</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${list }" var="row">
							<tr class="row detail" onclick="location.href='./noticeDetail?nno=${row.nno}'">
								<td class="col-1">${row.nno }</td>
								<td class="col-6 title">
									<c:forTokens var="token" items="${row.nrealfile }" delims="." varStatus="status">
										<c:if test="${status.last }">
											<c:choose>
												<c:when test="${token eq 'png' || token eq 'jpg' || token eq 'jpeg' || token eq 'bmp' || token eq 'gif' }">
													<i class="bi bi-image"></i>
												</c:when>
												<c:otherwise>
													<i class="bi bi-file-text"></i>
												</c:otherwise>
											</c:choose>
										</c:if>
									</c:forTokens>
									${row.ntitle }
								</td>
								<td class="col-2">${row.m_id }</td>
								<td class="col-2">${row.ndate }</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
            </div>
        </header>

        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <!-- * *                               SB Forms JS                               * *-->
        <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>