<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin || main</title>
<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="../css/admin.css">
<style type="text/css">
.table {
	display: table;
	border: 3px solid black;
	width: 1000px;
	border-collapse: collapse;
}

.heading {
	display: table-header-group;
	background-color: #d9c5ce;
	font-weight: bold;
	text-align: center;
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

.gray {
	background-color: gray;
}

.pink {
	background-color: #f2808a;
}
</style>
<script type="text/javascript">
function gradeChange(no, name, value){
	// let select = document.getElementsByClassName("grade");
	// for(var i = 0; i < select.length; i++){
	//	let selectName = select[i].options[select[i].selectedIndex].text;
	//	let selectValue = select[i].options[select[i].selectedIndex].value;
	// }
	//	alert(selectName + selectValue);
	if(confirm(name + "님의 등급을 변경하시겠습니까?")){
		location.href="./gradeChange?m_no=" + no + "&grade=" + value;
	}
}
</script>
</head>
<body>
<div class="container">
	<%@ include file="menu.jsp" %>
	<div class="main">
		<div class="article">
			<h1>회원관리</h1>
			<div class="table">
				<div class="heading">
					<div class="row">
						<div class="head">번호</div>
						<div class="head">아이디</div>
						<div class="head">이름</div>
						<div class="head">가입날짜</div>
						<div class="head">주소</div>
						<div class="head">생일</div>
						<div class="head">mbti</div>
						<div class="head">성별</div>
						<div class="head">등급</div>
					</div>
				</div>
				<div class="body">
					<c:forEach items="${list }" var="row">
						<div class="row <c:if test="${row.m_grade le 2}">gray</c:if> <c:if test="${row.m_grade ge 6}">pink</c:if>" >
							<div class="cell">${row.m_no }</div>
							<div class="cell">${row.m_id }</div>
							<div class="cell">${row.m_name }</div>
							<div class="cell">${row.m_joindate }</div>
							<div class="cell">${row.m_addr }</div>
							<div class="cell">${row.m_birth }</div>
							<div class="cell">${row.m_mbti }</div>
							<div class="cell">
								<c:choose>
									<c:when test="${row.m_gender eq 1}">♂</c:when>
									<c:otherwise>♀</c:otherwise>
								</c:choose>
							</div>
							<div class="cell grade">
							<!-- String은 따옴표로 감싸준다. -->
								<select class="grade" id="grade" onchange="gradeChange(${row.m_no}, '${row.m_name}', this.value )">
									<optgroup label="로그인불가">
										<option value="0" <c:if test="${row.m_grade eq 0}">selected="selected"</c:if> >강퇴</option>
										<option value="1" <c:if test="${row.m_grade eq 1}">selected="selected"</c:if> >탈퇴</option>
										<option value="2" <c:if test="${row.m_grade eq 2}">selected="selected"</c:if> >징계</option>
									</optgroup>
									<optgroup label="로그인가능">
										<option value="3" <c:if test="${row.m_grade eq 3}">selected="selected"</c:if> >탈퇴복귀</option>
										<option value="4" <c:if test="${row.m_grade eq 4}">selected="selected"</c:if> >징계복귀</option>
										<option value="5" <c:if test="${row.m_grade eq 5}">selected="selected"</c:if>  >평민</option>
									</optgroup>
									<optgroup label="관리자">
										<option value="6" <c:if test="${row.m_grade eq 6}">selected="selected"</c:if> >일반관리자</option>
										<option value="7" <c:if test="${row.m_grade eq 7}">selected="selected"</c:if> >게시판관리자</option>
										<option value="8" <c:if test="${row.m_grade eq 8}">selected="selected"</c:if> >가입관리자</option>
										<option value="9" <c:if test="${row.m_grade eq 9}">selected="selected"</c:if> >최고관리자</option>
									</optgroup>
								</select>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>