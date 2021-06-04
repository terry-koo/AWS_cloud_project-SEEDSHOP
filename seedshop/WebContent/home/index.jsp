<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="database.Data" %>    
<!DOCTYPE html>
<html>
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>SeedShop</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free HTML5 Website Template by FreeHTML5.co" />
	<meta name="keywords" content="free website templates, free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
	<meta name="author" content="FreeHTML5.co" />
	<meta name="twitter:title" content="" />
	<meta name="twitter:image" content="" />
	<meta name="twitter:url" content="" />
	<meta name="twitter:card" content="" />

	<link href='https://fonts.googleapis.com/css?family=Raleway:400,300,600,400italic,700' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="css/animate.css">
	<link rel="stylesheet" href="css/icomoon.css">
	<link rel="stylesheet" href="css/bootstrap.css">
	<link rel="stylesheet" href="css/magnific-popup.css">
	<link rel="stylesheet" href="css/owl.carousel.min.css">
	<link rel="stylesheet" href="css/owl.theme.default.min.css">
	<link rel="stylesheet" href="css/style.css">
	<script src="js/modernizr-2.6.2.min.js"></script>
	
	<!-- 아이콘 생성 -->
	<link rel="shortcut icon" href="images/favicon.ico" />
	
	</head>
	<body>
		
	<div class="gtco-loader"></div>
	
	
	<nav class="gtco-nav" role="navigation">
		<div class="gtco-container">
			<div class="row">
				<div class="col-xs-2">
					<div id="gtco-logo"><a href="index.jsp">SeedShop</a></div>
				</div>
				<div class="col-xs-10 text-right menu-1">
					<ul>
						<li class="active"><a href="index.jsp">Home</a></li>
						<li><a href="About.jsp">About</a></li>
						<li class="has-dropdown">
							<a>SHOP</a>
							<ul class="dropdown">
								<li><a href="Seed.jsp">SEED</a></li>
								<li><a href="Plant.jsp">PLANT</a></li>
							</ul>
						</li>
						<li class="has-dropdown">
							<a>My</a>
							<ul class="dropdown">
								<li><a href="Orders.jsp">ORDERS</a></li>
								<li><a href="Profile.jsp">PROFILE</a></li>
							</ul>
						</li>
						<li class="has-dropdown">
							<a href="/seedshop/home/NewFile.jsp">Contact</a>
							<ul class="dropdown">
								<li><a href="Livechat.jsp">LIVE CHAT</a></li>
								<li><a href="Call.jsp">CALL</a></li>
							</ul>
						</li>
						
						<!-- 로그인여부에 따라 보이는 항목이 다름 -->
						<% if("true".equalsIgnoreCase((String)session.getAttribute("login"))||"true".equalsIgnoreCase((String)session.getAttribute("staff"))||"true".equalsIgnoreCase((String)session.getAttribute("master"))){%>
						<li class="has-dropdown">
							<a href="/seedshop/home/Logout.jsp" style="color:red;">logout</a>
						</li>
						<%}else{ %>
						<li class="has-dropdown">
							<a href="/seedshop/templete/login.jsp" style="color:red;">login</a>
						</li>
						<%} %>
						
						<!-- 직원 아이디로 로그인시 보이는 메뉴 -->
						<% if("true".equalsIgnoreCase((String)session.getAttribute("staff"))){%>
						<li class="has-dropdown">
							<a style="color:green;">Manage</a>
							<ul class="dropdown">
								<li><a href="SeedManageForm.jsp">SEED/PLANT</a></li>
								<li><a href="OrdersManagement.jsp">ORDERS</a></li>
								<li><a href="CustomerManagement.jsp">CUSTOMERS</a></li>
							</ul>
						</li>
						<%} %>
						
						
						<!-- 마스터 아이디로 로그인시 보이는 메뉴 -->
						<% if("true".equalsIgnoreCase((String)session.getAttribute("master"))){%>
						<li class="has-dropdown">
							<a href="/seedshop/home/NewFile.jsp" style="color:cyan; font-size:20px;"><b>MASTER</b></a>
							<ul class="dropdown">
								<li><a href="StaffList.jsp" style="color:red;">직원 </a></li>
								<li><a href="BestCustomer.jsp" style="color:red;">고객</a></li>
								<li><a href="Benefit.jsp" style="color:red;">총 매출</a></li>
							</ul>
						</li>
						<%} %>
						
						
					</ul>
				</div>
			</div>
			
		</div>
	</nav>

	<header id="gtco-header" class="gtco-cover" role="banner" style="background-image:url(images/Sunflower_from_Silesia2.jpg);">
		<div class="overlay"></div>
		<div class="gtco-container">
			<div class="row">
				<div class="col-md-12 col-md-offset-0 text-center">
					<div class="display-t">
					
					<% if("true".equalsIgnoreCase((String)session.getAttribute("login"))){%>
						<div class="display-tc animate-box" data-animate-effect="fadeIn">
							<h1>"<%= session.getAttribute("name") %>"님 환영합니다!</h1>
							<h2 style="margin:auto; color:white; background-color: rgba( 0, 0, 0, 0.5 ); width:330px;">[ &nbsp온라인에서 &nbsp 편하게  &nbsp주문하세요 &nbsp]</h2>
								<br>
							<p>
								<a href="/seedshop/home/Logout.jsp" class="btn btn-primary btn-lg">로그아웃</a> 
							</p>
						</div>
						
					<%}else if("true".equalsIgnoreCase((String)session.getAttribute("staff"))){%> 
						<div class="display-tc animate-box" data-animate-effect="fadeIn">
								<h1>"<%= session.getAttribute("name") %>"님 환영합니다!</h1>
								<h2 style="margin:auto; color:green; background-color: rgba( 0, 0, 0, 0.5 ); width:330px;"><b>[ 관리자 모드가 활성화 되었습니다 ]</b></h2>
									<br>
								<p>
									<a href="/seedshop/home/Logout.jsp" class="btn btn-primary btn-lg">로그아웃</a> 
								</p>
							</div>
							
					<%}else if("true".equalsIgnoreCase((String)session.getAttribute("master"))){%> 
						<div class="display-tc animate-box" data-animate-effect="fadeIn">
								<h1 style="margin:auto;  width:1000px; color:white; background-color: rgba( 255, 0, 0, 0.6 );">[주의! 최종 관리자 계정 접속중 ]</h1>
									<br>
								<p>
									<a href="/seedshop/home/Logout.jsp" class="btn btn-primary btn-lg">로그아웃</a> 
								</p>
							</div>		
							
					<%}else{ %>
						<div class="display-tc animate-box" data-animate-effect="fadeIn">
							<h1 >씨앗상점에 오신 걸 환영합니다</h1>
								<h2 style="margin:auto; color:white; background-color: rgba( 0, 0, 0, 0.5 ); width:330px;">[ &nbsp온라인에서 &nbsp 편하게  &nbsp주문하세요 &nbsp]</h2>
								<br>
							<p>
								<a href="/seedshop/templete/login.jsp" class="btn btn-primary btn-lg">로그인</a> 
								<a href="/seedshop/home/JoinForm.jsp" class="btn btn-white btn-outline btn-lg">회원가입</a>
							</p>
						</div>
					<% } %>
					</div>
				</div>
			</div>
		</div>
	</header>
	
	
	
	
	<script src="js/jquery.min.js"></script>
	<script src="js/jquery.easing.1.3.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/jquery.waypoints.min.js"></script>
	<script src="js/owl.carousel.min.js"></script>
	<script src="js/jquery.countTo.js"></script>
	<script src="js/jquery.magnific-popup.min.js"></script>
	<script src="js/magnific-popup-options.js"></script>
	<script src="js/main.js"></script>

	</body>
</html>
