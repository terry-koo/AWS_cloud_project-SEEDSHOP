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
    padding: 10px;
  }
  html, body { height:100%; overflow:hidden }

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



<div id="wrap"
	style="margin: auto; background-color: #C7DBD0; height: 100%; padding: 80px">
	<!--@@@@@@@@@@@@@@@@@@@  양식 시작    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->


	<%!
	int importantcustid;
	int shippingcharge;
	int orderid;
	String orderdate;
	int seedid;
	String seedname;
	String company;
	int saleprice;
	int charge;
	int plantid;
	String plantname;
	%>


	<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmtship = null;
	PreparedStatement pstmtSelect = null;
	PreparedStatement pstmtSelect2 = null;
	
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "seedshop";
	String pass = "seedshop001";
	
	try {
		request.setCharacterEncoding("utf-8");
	
		//동적로딩
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(Data.url, Data.user, Data.pass);
	
		//고객번호 구하기
		importantcustid = (Integer) session.getAttribute("importantcustid");
		
		//고객주소 참고하여 택배가격 구하기
		String shippingquery = "select charge from vw_shippingcharge_important where importantcustid=" + importantcustid;
		pstmtship = conn.prepareStatement(shippingquery);
		ResultSet rsship = pstmtship.executeQuery();
		while (rsship.next()) {
			shippingcharge = rsship.getInt(1);
		}
		rsship.close();
		
		//주문 씨앗 목록
		String importantSeedOrders = "select distinct onlineorder.orderid, to_char(onlineorder.orderdate,'yyyymmdd'), nvl(seed.seedid,0), nvl(seed.seedname,'없음'), nvl(seedcompany.company,'없음'), onlineorder.saleprice ,(select paidcheck from paid where paid.orderid = onlineorder.orderid), (select to_char(startdate,'yyyy-mm-dd') from delivery where delivery.orderid = onlineorder.orderid), (select to_char(enddate,'yyyy-mm-dd') from delivery where delivery.orderid = onlineorder.orderid) from onlineorder, normalcustomer, importantcustomer, seed, plant, seedcompany where onlineorder.seedid= seed.seedid and  seed.seedid = seedcompany.seedid and onlineorder.seedid = seedcompany.seedid and onlineorder.importantcustid =importantcustomer.importantcustid and  importantcustomer.importantcustid= " +importantcustid + " order by onlineorder.orderid ";


		pstmtSelect = conn.prepareStatement(importantSeedOrders);
	
		ResultSet rs = pstmtSelect.executeQuery();
		
		
		//주문 모종 목록
			
		String importantPlantOrders = "select distinct onlineorder.orderid, to_char(onlineorder.orderdate , 'yyyymmdd'), nvl(plant.plantid,0), nvl(plant.plantname,'없음'), nvl(plantcompany.company,'없음'), onlineorder.saleprice ,(select paidcheck from paid where paid.orderid = onlineorder.orderid), (select to_char(startdate,'yyyy-mm-dd') from delivery where delivery.orderid = onlineorder.orderid), (select to_char(enddate,'yyyy-mm-dd') from delivery where delivery.orderid = onlineorder.orderid) from onlineorder, normalcustomer, importantcustomer, plant, plantcompany where onlineorder.plantid= plant.plantid and  plant.plantid = plantcompany.plantid and onlineorder.plantid = plantcompany.plantid and onlineorder.importantcustid =importantcustomer.importantcustid and  importantcustomer.importantcustid= " +importantcustid + " order by onlineorder.orderid ";
		
		pstmtSelect2 = conn.prepareStatement(importantPlantOrders);
	
		ResultSet rs2 = pstmtSelect2.executeQuery();
			
			
	%>
	<br> <br> <br>

	<h1 style="color: black; text-align: center">
		<b>내 주문 목록</b>
	</h1>
	<br>

	
	<form action="index.jsp">
		<table style="margin: auto; width: 70%;">
			<tr>
				<td><b>주문번호</b></td>
				<td><b>주문일</b></td>
				<td><b>구매상품명</b></td>
				<td><b>업체명</b></td>
				<td><b>총 주문금액</b></td>
				<td><b>배송비</b></td>
				<td><b>입금내역</b></td>
				<td><b>배송시작일</b></td>
				<td><b>택배수령일</b></td>
			</tr>

			<%
				// 주문 씨앗 입력
				while (rs.next()) {
						orderid = rs.getInt(1);
						orderdate = rs.getString(2);
						seedid = rs.getInt(3);
						seedname = rs.getString(4);
						company = rs.getString(5);
						saleprice = rs.getInt(6);
						charge = shippingcharge;
						int paidcheck = rs.getInt(7);
						String start = rs.getString(8);
						String end = rs.getString(9);
			%>
			<tr>
				<td><%=orderid%></td>
				<td><%=orderdate%></td>
				<td><%=seedname%></td>
				<td><%=company%></td>
				<td><%=saleprice%></td>
				<td><%=charge%></td>
				<%
					if(paidcheck==0){%><td>미입금</td><%}	
					else{%><td><%= paidcheck %></td><%}%>	
				<%
					if("1111-11-11".equals(start)){%><td>출발안함</td><%}	
					else{%><td><%= start %></td><%}%>	
				<%
					if("1111-11-11".equals(end)){%><td>도착안함</td><%}	
					else{%><td><%= end %></td><%}%>
			</tr>

			<%
				}
			
			
			// 주문 모종 입력
			while (rs2.next()) {
				
						orderid = rs2.getInt(1);
						orderdate = rs2.getString(2);
						plantid = rs2.getInt(3);
						plantname = rs2.getString(4);
						company = rs2.getString(5);
						saleprice = rs2.getInt(6);
						charge = shippingcharge;
						int paidcheck = rs2.getInt(7);
						String start = rs2.getString(8);
						String end = rs2.getString(9); 
						
			%>
			<tr>
				<td><%=orderid%></td>
				<td><%=orderdate%></td>
				<td><%=plantname%></td>
				<td><%=company%></td>
				<td><%=saleprice%></td>
				<td><%=charge%></td>
				<%
					if(paidcheck==0){%><td>미입금</td><%}	
					else{%><td><%= paidcheck %></td><%}%>	
				<%
					if("1111-11-11".equals(start)){%><td>출발안함</td><%}	
					else{%><td><%= start %></td><%}%>	
				<%
					if("1111-11-11".equals(end)){%><td>도착안함</td><%}	
					else{%><td><%= end %></td><%}%>
			</tr>

			<%
				}
			%>
		</table >
		<br>
		<div style="text-align: center;">
			<input type="submit" value="홈으로">
		</div>
	</form>
	<%
		rs.close();
		rs2.close();

		} catch (Exception e) {
			e.printStackTrace();
			

		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (pstmtship != null)
					pstmtship.close();
				if (pstmtSelect != null)
					pstmtSelect.close();
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