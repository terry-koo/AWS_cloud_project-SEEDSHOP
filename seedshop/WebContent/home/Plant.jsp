<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.Date" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="database.Data" %>


<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	<!-- 홈페이지 아이콘 -->
	<link rel="shortcut icon" href="images/favicon.ico" />
	
	<!-- 표 스타일 -->
	<style>
  table {
    border-top: 1px solid #444444;
    border-collapse: collapse;
    color:black;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 6px;
  }
  html, body {background-color: #C7DBD0; height:100%; overflow:hidden }

	</style>

	</head>
	<body>
	
	<div class="gtco-loader"></div>
	<div id="page">
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

	<header id="gtco-header" class="gtco-cover" role="banner" style="background-image:url(images/Sunflower_from_Silesia2.jpg); height:105px;">
		</header>
	
	
		
<div id="wrap" style="margin:auto; background-color:#C7DBD0; height:100%; padding:80px">
<!--@@@@@@@@@@@@@@@@@@@  양식 시작    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->	
 <%
	Connection conn = null;
	PreparedStatement pstmt = null;
    PreparedStatement pstmtSelect = null; 
	
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "seedshop";
	String pass = "seedshop001";
	
	try{
	request.setCharacterEncoding("utf-8");
	
	
	//동적로딩
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(Data.url, Data.user, Data.pass);
	
	
	
	String plantquery = "select plantname, price, sow, company,plant.plantid  from plant, plantcompany where plant.plantid = plantcompany.plantid";
	pstmtSelect = conn.prepareStatement(plantquery);
	
	//쿼리 결과를 담을 변수
	String plantname;
	int price;
	int sow;
	String company;
	int plantid;
	
	
	ResultSet rs = pstmtSelect.executeQuery(); 
	%>
	<br>
	<br>
	<br>
	
	<h1 style="color:black; text-align:center"><b>모종 구매</b></h1>
	<br>
	<%! String grade; %>
	<% grade = (String)session.getAttribute("grade"); %>
	<%if("BRONZE".equals(grade)||"SILVER".equals(grade)){ %>
	<form action="NormalOrderResult.jsp">
	<%}else if("GOLD".equals(grade)||"DIAMOND".equals(grade)){ %>
	<form action="ImportantOrderResult.jsp">
	<% }else{%>
	<% out.println("<script> alert('로그인 후 이용 가능합니다');history.go(-1);</script>");}%>
	<table style="margin:auto;  width:45%;">
		<tr>
			<td><b>씨앗명</b></td>	
			<td><b>가격</b></td>	
			<td><b>파종시기</b></td>	
			<td><b>업체명</b></td>	
			<td><b>모종선택</b></td>	
		</tr>
	
	<%
 	while (rs.next())
	{
 		plantname = rs.getString(1);
 		price = rs.getInt(2);
 		sow = rs.getInt(3);
 		company = rs.getString(4);
 		plantid = rs.getInt(5); 
 		
 		%>
 		<tr>
			<td><b><%= plantname %></b></td>	
			<td><%= price %>원</td>	
			<td><%= sow %>월</td>	
			<td><%= company %></td>	
			<td style="text-align:center; zoom:1.6;"><input type="checkbox" name="plantid" value="<%=plantid%>"></td>
		</tr>
 	
 		<%
 		
	} 
	
	
	%>
	</table>
	<br>
	<div style="text-align:center;">
	<input type="submit" value="구매하기">
	</div>
	</form>
	<%
	rs.close();
	
		
		
	}catch(Exception e){
		e.printStackTrace();%>
			
		<%
	}finally{
		try{
			if(pstmt != null) pstmt.close();
			if(pstmtSelect != null) pstmtSelect.close();
			if(conn != null) conn.close();			
		}catch(Exception e){
				
		}
	}
%>      
       

       

       
       
<!--@@@@@@@@@@@@@@@@@@@  양식 끝    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->		     
</div>

	</div>

	

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