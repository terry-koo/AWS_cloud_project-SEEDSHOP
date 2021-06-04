<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Data" %>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Orders</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Free HTML5 Website Template by FreeHTML5.co" />
<meta name="keywords"
	content="free website templates, free html5, free template, free bootstrap, free website template, html5, css3, mobile first, responsive" />
<meta name="author" content="FreeHTML5.co" />


<meta name="twitter:title" content="" />
<meta name="twitter:image" content="" />
<meta name="twitter:url" content="" />
<meta name="twitter:card" content="" />

<link
	href='https://fonts.googleapis.com/css?family=Raleway:400,300,600,400italic,700'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="css/animate.css">
<link rel="stylesheet" href="css/icomoon.css">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/magnific-popup.css">
<link rel="stylesheet" href="css/owl.carousel.min.css">
<link rel="stylesheet" href="css/owl.theme.default.min.css">
<link rel="stylesheet" href="css/style.css">

<!-- 홈페이지 아이콘 -->
<link rel="shortcut icon" href="images/favicon.ico" />

<style>
  table {
    border-top: 1px solid #444444;
    border-collapse: collapse;
    color:black;
  }
  th, td {
    border-bottom: 1px solid #444444;
    padding: 5px;
  }
  html, body { background-color: #C7DBD0; height:100%; overflow:hidden; }

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

<header id="gtco-header" class="gtco-cover" role="banner"
	style="background-image: url(images/Sunflower_from_Silesia2.jpg); height: 105px;">
</header>



<div id="wrap" style="margin: auto; margin-top:10px; background-color: #C7DBD0; height: 100%; padding: 80px">
	<!--@@@@@@@@@@@@@@@@@@@  양식 시작    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->

<%!
// 데이터베이스에 date타입 데이터를 넣기위해 변환하는 메서드
public Date transformDate(String date)
{
    SimpleDateFormat beforeFormat = new SimpleDateFormat("yyyymmdd");
    
    // Date로 변경하기 위해서는 날짜 형식을 yyyy-mm-dd로 변경해야 한다.
    SimpleDateFormat afterFormat = new SimpleDateFormat("yyyy-mm-dd");
    
    java.util.Date tempDate = null;
    
    try {
        // 현재 yyyymmdd로된 날짜 형식으로 java.util.Date객체를 만든다.
        tempDate = beforeFormat.parse(date);
    } catch (Exception e) {
        e.printStackTrace();
    }
    
    // java.util.Date를 yyyy-mm-dd 형식으로 변경하여 String로 반환한다.
    String transDate = afterFormat.format(tempDate);
    
    // 반환된 String 값을 Date로 변경한다.
    Date d = Date.valueOf(transDate);
    
    return d;
};

%>
	<%!
	String customername;
	String customername2;
	String staffname;
	int staffid=0;
	int normalcustid=0;
	int normalcustid2=0;
	int importantcustid=0;
	int recommend=0;
	int recommend2=0;
	int recommendcount=0;
	Date recommenddate;
	Date date;
	
	%>


	<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmtSelect1 = null;
	PreparedStatement pstmtSelect2 = null;
	
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "seedshop";
	String pass = "seedshop001";
	
	try {
		request.setCharacterEncoding("utf-8");
	
		//동적로딩
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(Data.url, Data.user, Data.pass);
	
		
		//기본값인지 확인하는 용도
		date = transformDate("11111111");
		
		
	
		String importantquery = "select * from view_importantmanagement";
		
		
		pstmtSelect2 = conn.prepareStatement(importantquery);
		ResultSet rs2 = pstmtSelect2.executeQuery();  
		
		
		//현재 날짜 
		SimpleDateFormat format1 = new SimpleDateFormat ("yyyy-MM-dd");
		String format_time1 = format1.format(System.currentTimeMillis());
			
	%>
	<br> <br> <br>

	<h1 style="color: black; text-align: center">
		<b>고객목록</b>
	</h1>
	<br>
	<form action="CustomerManagementResult.jsp">
		<table style="margin:auto;  width:100%;">
			<tr>
				<td>관리번호</td>
				<td>고객이름</td>
				<td>중요고객번호</td>
				<td>당담 직원번호</td>
				<td>당담 직원이름</td>
				<td>추천하는번호</td>
				<td>추천받은횟수</td>
				<td>관리하기</td>
				
			</tr>
	
			<%
		
			 
			// 중요고객
			while (rs2.next()) {
				customername2 = rs2.getString(1);
				importantcustid = rs2.getInt(2);
				staffid = rs2.getInt(3);
				staffname = rs2.getString(4);
				recommend2 = rs2.getInt(5);
				recommendcount = rs2.getInt(6);
				int managementid = rs2.getInt(8);
				
			%>
			
			<tr>
				<td><%=managementid%></td>
				<td><%=customername2%></td>
			
					<%if(0==importantcustid){%><td>x</td><%}	
					else{%><td><%= importantcustid %></td><%}%>
				<%
					if(0==staffid){%><td>x</td><%}	
					else{%><td><%= staffid %></td><%}%>
				<td><%=staffname%></td>
				<%
					if(0==recommend2){%><td>없음</td><%}	
					else{%><td><%= recommend2 %></td><%}%>
				<%
					if(0==recommendcount){%><td>없음</td><%}	
					else{%><td><%= recommendcount %>번</td><%}%>
					<td style="text-align: center; zoom: 1.6;"><input
					type="radio" name="custid" value="<%=importantcustid%>" required></td>
				
			
			</tr>

			<%
				}
			%>
			
	
	</table>
		<br>
		<div style="text-align: center;">
			<input type="submit" value="내 관리고객 등륵">
		</div>
	</form>
	<%
		
		
		rs2.close();

		} catch (Exception e) {
			e.printStackTrace();
			

		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (pstmtSelect1 != null)
					pstmtSelect1.close();
				if (pstmtSelect2 != null)
					pstmtSelect2.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {

			}
		}
	%>


			<!--@@@@@@@@@@@@@@@@@@@  양식 끝    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
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