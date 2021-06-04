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
	
	<link rel="shortcut icon" href="images/favicon.ico" />
	
	<script type="text/javascript">
        // 씨앗데이터 입력정보를 결과로 넘기기전에 모든 값이 입력되었는지 확인하는 메소드
        function seedcheckValue()
        {
        	if(!document.seed.seedname.value){
                alert("씨앗명을 입력하세요.");
                return false;
            }
            
            if(!document.seed.price.value){
                alert("정가를 입력하세요.");
                return false;
            }
            
            if(!document.seed.sow.value){
                alert("파종시기를 입력하세요.");
                return false;
            }
            
            if(!document.seed.company.value){
                alert("업체명을 입력하세요.");
                return false;
            }
            
            if(!document.seed.country.value){
                alert("원산지를 입력하세요.");
                return false;
            }
            
            if(!document.seed.cost.value){
                alert("원가를 입력하세요.");
                return false;
            }
           
        } 
        // 모종데이터 입력정보를 결과로 넘기기전에 모든 값이 입력되었는지 확인하는 메소드
        function plantcheckValue()
        {
        	if(!document.plant.plantname.value){
                alert("모종명을 입력하세요.");
                return false;
            }
            
            if(!document.plant.price.value){
                alert("정가를 입력하세요.");
                return false;
            }
            
            if(!document.plant.sow.value){
                alert("심는시기를 입력하세요.");
                return false;
            }
            
            if(!document.plant.company.value){
                alert("업체명을 입력하세요.");
                return false;
            }
            
            if(!document.plant.country.value){
                alert("원산지를 입력하세요.");
                return false;
            }
            
            if(!document.plant.cost.value){
                alert("원가를 입력하세요.");
                return false;
            }
            
        } 
    </script>
	
    
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
	
	
		
<div id="wrap" style="margin:auto; background-color:white; padding:80px; text-align:center;">
<!--@@@@@@@@@@@@@@@@@@@  양식 시작    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->	
<br>
<br>
<br>

<h1 style="text-align:center; color:green;"><b>새로운 씨앗/모종 추가</b></h1>

<br>


<div style="display:inline-block; border:solid; padding:70px;">
<form method="post" action="SeedManageFormResult_seed.jsp" name="seed" onsubmit="return seedcheckValue()">
<h3>씨앗추가</h3>
<table style="margin:auto;">
	<tr>
		<td>씨앗명 &nbsp</td>
		<td><input type="text" name="seedname" value=""></td>
	</tr>
	
	<tr style="height:5pt"><td></td></tr>
	
	<tr>
		<td>정가 </td>
		<td><input type="text" name="price"></td>
	</tr>
	
	<tr style="height:5pt"><td></td></tr>
	
	<tr>
		<td>원가 </td>
		<td><input type="text" name="cost"></td>
	</tr>
	
	<tr style="height:5pt"><td></td></tr>
	
	<tr>
		<td>파종시기 </td>
		<td style="text-align:left;">
			<select name="sow" style="height:24pt;">
	            <option value="1" >1월</option>
	            <option value="2" >2월</option>
	            <option value="3" >3월</option>
	            <option value="4" >4월</option>
	            <option value="5" >5월</option>
	            <option value="6" >6월</option>
	            <option value="7" >7월</option>
	            <option value="8" >8월</option>
	            <option value="9" >9월</option>
	            <option value="10" >10월</option>
	            <option value="11" >11월</option>
	            <option value="12" >12월</option>
       		 </select>
		</td>
	</tr>
	
	<tr style="height:5pt"><td></td></tr>
	
	<tr>
		<td>납품업체 </td>
		<td style="text-align:left;">
		<select name="company" style="height:24pt;">
            <option value="자라라" >자라라</option>
            <option value="나무야" >나무야</option>
            <option value="우리씨앗" >우리씨앗</option>
            <option value="수입왕" >수입왕</option>
            <option value="대한식물" >대한식물</option>
            <option value="씨앗모아" >씨앗모아</option>
        </select>
		</td>
	</tr>
	
	<tr style="height:5pt"><td></td></tr>
	
	<tr>
		<td>원산지 </td>
		<td><input type="text" name="country"></td>
	</tr>
</table>

 <br>
 
 <div style="text-align:center;">
            <input type="submit" value="새로운 씨앗 추가"/>  
 </div>
 
</form>  
</div>
 

<div style="display:inline-block; margin-left:150px; border:solid; padding:70px ">
<h3>모종추가</h3>
<form method="post" action="SeedManageFormResult_plant.jsp" name="plant" onsubmit="return plantcheckValue()">
<table style="margin:auto;">
	<tr>
		<td>모종명&nbsp</td>
		<td><input type="text" name="plantname"></td>
	</tr>
	
	<tr style="height:5pt"><td></td></tr>
	
	<tr>
		<td>정가 </td>
		<td><input type="text" name="price"></td>
	</tr>
	
	<tr style="height:5pt"><td></td></tr>
	
	<tr>
		<td>원가 </td>
		<td><input type="text" name="cost"></td>
	</tr>
	
	<tr style="height:5pt"><td></td></tr>
	
	<tr>
		<td>심는시기 </td>
		<td style="text-align:left;">
		<select name="sow" style="height:24pt;">
            <option value="1" >1월</option>
            <option value="2" >2월</option>
            <option value="3" >3월</option>
            <option value="4" >4월</option>
            <option value="5" >5월</option>
            <option value="6" >6월</option>
            <option value="7" >7월</option>
            <option value="8" >8월</option>
            <option value="9" >9월</option>
            <option value="10" >10월</option>
            <option value="11" >11월</option>
            <option value="12" >12월</option>
        </select>
		</td>
	</tr>
	
	<tr style="height:5pt"><td></td></tr>
	
	<tr>
		<td>납품업체 </td>
		<td style="text-align:left;">
		<select name="company" style="height:24pt;">
            <option value="자라라" >자라라</option>
            <option value="나무야" >나무야</option>
            <option value="수입왕" >수입왕</option>
            <option value="대한식물" >대한식물</option>
        </select>
		</td>
	</tr>
	
	<tr style="height:5pt"><td></td></tr>
	
	<tr>
		<td>원산지 </td>
		<td><input type="text" name="country"></td>
	</tr>
</table>

 <br>
 
 <div style="text-align:center;">
            <input type="submit" value="새로운 모종 추가"/>  
 </div>
 
</form>   
   
</div>     
       
       
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