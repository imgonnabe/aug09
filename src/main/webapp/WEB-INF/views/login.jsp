<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> ❤ login</title>
<link href="css/styles.css" rel="stylesheet" />
<script src="./js/jquery-3.7.0.min.js"></script>
<style type="text/css">
	.login-form{
		margin: 0 auto;
		padding: 10px;
		width: 400px;
		height: auto;
		background-color: rgba(240, 255, 240, 0.3);
	}
</style>
<script type="text/javascript">
	function loginCheck() {
		let id = document.querySelector("#id");/* jQuery : let id = $("#id").val(); */
		let pw = document.querySelector("#pw");
		let checkItems = [ id, pw ];// [object, object]
		//alert(id.value + " / " + pw.value);
		let flag = checkItems.every(function(item) {
			if (item.value === null || item.value === "") {
				// alert(item.parentNode.parentNode.childNodes[1].innerHTML + "를 다시 입력하세요.");
				alert(item.parentNode.previousElementSibling.innerHTML + "를 다시 입력하세요.");
				// ID, Password
				item.focus();
			}
			return item.value !== "";// 비어있으면 거짓
		});

		if (flag == true) {
			// 가상 form 만들기
			let form = document.createElement("form");
			form.setAttribute("action", "./login");
			form.setAttribute("method", "post");
			
			let idField = document.createElement("input");
			idField.setAttribute("type", "hidden");
			idField.setAttribute("name", "id");
			idField.setAttribute("value", id.value);
			form.appendChild(idField);
			
			let pwField = document.createElement("input");
			pwField.setAttribute("type", "hidden");
			pwField.setAttribute("name", "pw");
			pwField.setAttribute("value", pw.value);
			form.appendChild(pwField);
			
			document.body.appendChild(form);
			form.submit();
			// appendChild() : node객체만 자식 요소로 추가
			// document.body.append(div, p, 'hello')
			// 결과 : <div></div> <p></p> hello
		}
	}
</script>
<script type="text/javascript">
	$(function(){
			// 쿠키 값 가져오기
			let userID = getCookie('userID');// id
			let setCookieY = getCookie('setCookie');// Y
			
			// 쿠키 검사 > 쿠키가 있다면 해당 쿠키에서 id값을 가져와서 id칸에 붙여넣기
			if(setCookieY == 'Y'){
				$('#saveID').prop('checked', true);// 속성 추가
				$('#id').val(userID);
			} else{
				$('#saveID').prop('checked', false);
			}
			
		$("#login").click(function(){
			// id, pw 검사
			let id = $('#id').val();
			let pw = $('#pw').val();
			if(id == '' || id.length < 4){
				alert('올바른 아이디를 입력하세요.');
				$('#id').focus;
				return false;
			}
			if(pw == '' || pw.length < 4){
				alert('올바른 비밀번호를 입력하세요.');
				$('#pw').focus;
				return false;
			}
			
			if($('#saveID').is(':checked')){
				// setCookie('userID', 값, 저장기간);
				setCookie('userID', id, 7);
				setCookie('setCookie', 'Y', 7);
			} else{
				// deleteCookie();
				deleteCookie('userID');
				deleteCookie('setCookie');
			}
			
			$.ajax({
				url : "./login",
				type: "post",
				data : {id:id, pw:pw},
				dataType : "json",
				success:function(data){
					location.href="/";
				},
				error:function(error){
					alert('다시 시도하세요.');
				}
			});
		});
	});
	
	// setCookie()
	function setCookie(cookieName, value, exdays){// setCookie('userID', id, 7)
		let exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);
		let cookieValue = value + (((exdays == null) ? "" : "; expires=" + exdate.toGMTString()));
		document.cookie = cookieName + "=" + cookieValue;
		//                 userID=aaaa;expires=2023-08-25
	}
	
	// deleteCookie()
	function deleteCookie(cookieName){
		let expireDate = new Date();
		expireDate.setDate(expireDate.getDate() - 1);
		document.cookie = cookieName + "=" + ";expires=" + expireDate.toGMTString;
	}
	
	// getCookie()
	function getCookie(cookieName){//getCookie('userID') userID=aaaa;expires=2023-08-25
		let x, y;
		let val = document.cookie.split(";");//[userID=aaaa, expires=2023-08-25]
		for(let i = 0; i < val.length; i++){
			x = val[i].substr(0, val[i].indexOf("="));// userID
			y = val[i].substr(val[i].indexOf("=") + 1);// aaaa
			// x = x.replace(/^\s+|\s+$/g, '');// 공백제거
			x = x.trim();
			if(x == cookieName){
				return y;
			}
		}
	}
</script>
</head>
<body>
<%@ include file="menu.jsp" %>
        <header class="masthead">
            <div class="container">
               <div class="rounded-3 login-form">
               		<h2>LOGIN</h2>
               		<img alt="login" src="./img/login.png" width="250px;">
               	<c:if test="${param.error eq 'login' }">
	               	<div class="mb-3 row">
	               		<h2>로그인 하세요.</h2>
	               	</div>
               	</c:if>
				<div class="mb-3 row"><!-- 옆에 붙여써야 item.parentNode.parentNode.childNodes[0].innerHTML -->
					<label for="staticEmail" class="col-sm-3 col-form-label">ID</label>
					<div class="col-sm-8">
						<input type="text" class="form-control" id="id" placeholder="아이디를 입력하세요">
					</div>
				</div>
				<div class="mb-3 row">
					<label for="inputPassword" class="col-sm-3 col-form-label">Password</label>
					<div class="col-sm-8">
						<input type="password" class="form-control" id="pw" placeholder="암호를 입력하세요">
					</div>
				</div>
				<div class="mb-3 row">
					<div class="col-sm-12">
						<input type="checkbox" class="saveID" id="saveID"><!-- input id, label for 맞춰야 한다. -->
						<label for="saveID">아이디 저장</label>
					</div>
				</div>
				<div class="mb-3 row">
					<div class="col-sm-12">
						<input type="button" id="login" class="btn btn-primary" value="login"><!-- onclick="loginCheck()" -->
						<input type="button" id="join" class="btn btn-info" value="가입하기">
					</div>
				</div>
               </div>

            </div>
        </header>
        <!-- 에러가 들어오면 동작 -->
        <c:if test="${param.error ne null }">
        	<script type="text/javascript">
        		alert("로그인해야 사용할 수 있는 메뉴입니다.");
        	</script>
        </c:if>
     	<!-- (java, jstl) -> (html, js, jquery) -->
        

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>