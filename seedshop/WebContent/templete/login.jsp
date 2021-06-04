<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>씨앗상점 접속</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/templete/images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/templete/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/templete/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/templete/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/templete/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/templete/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/templete/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/templete/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/templete/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/templete/css/util.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/templete/css/main.css">
<!--===============================================================================================-->
</head>


<body>
	
	<div class="limiter" >
		<div class="container-login100" >
			<div class="wrap-login100 p-t-50 p-b-90" style="border-style:solid; border-color:#26528C; border-width:3px; padding:50px;">
				<form class="login100-form validate-form flex-sb flex-w" action="/seedshop/home/LoginResult.jsp"  method="post">
					<span class="login100-form-title p-b-51">
						환영합니다
					</span>

							<%!String remember; %>
							<% if(session.getAttribute("remember")!=null){
							 remember = (String)session.getAttribute("remember");%>

					<div class="wrap-input100 validate-input m-b-16" data-validate = "Username is required">
						<input class="input100" type="text" name="id" placeholder="Id" value="<%=remember%>">
						<span class="focus-input100"></span>
					</div>
					
					<% }else{    %>
					<div class="wrap-input100 validate-input m-b-16" data-validate = "Username is required">
						<input class="input100" type="text" name="id" placeholder="Id">
						<span class="focus-input100"></span>
					</div>
					<% } %>
					
					
					<div class="wrap-input100 validate-input m-b-16" data-validate = "Password is required">
						<input class="input100" type="password" name="password" placeholder="Password">
						<span class="focus-input100"></span>
					</div>
					
					<div class="flex-sb-m w-full p-t-3 p-b-24">
						<div class="contact100-form-checkbox">
							<input class="input-checkbox100" id="ckb1" type="checkbox" name="remember">
							<label class="label-checkbox100" for="ckb1">
								아이디 기억하기
							</label>
						</div>

					</div>

					<div class="container-login100-form-btn m-t-17">
						<button class="login100-form-btn" style="background-image:url(images/blue.jpg);" >
						<input type="submit" value=""><b>로그인</b>
					</div>
					
					
						<a href="/seedshop/home/index.html">홈으로</a>
						<a href="/seedshop/home/JoinForm.jsp">회원가입</a>
					

				</form>
			</div>
		</div>
	</div>
	
	

	
	<!-- </form> -->

<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/templete/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/templete/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/templete/vendor/bootstrap/js/popper.js"></script>
	<script src="${pageContext.request.contextPath}/templete/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/templete/vendor/select2/select2.min.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/templete/vendor/daterangepicker/moment.min.js"></script>
	<script src="${pageContext.request.contextPath}/templete/vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/templete/vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="${pageContext.request.contextPath}/templete/js/main.js"></script>


</body>
</html>