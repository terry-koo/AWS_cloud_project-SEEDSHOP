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
    padding: 10px;
  }
  html, body { height:100%; overflow:hidden }

	</style>

	<script type="text/javascript">
        // 씨앗데이터 입력정보를 결과로 넘기기전에 모든 값이 입력되었는지 확인하는 메소드
        function checkValue()
        {
        	 if(!document.profile.email.value){
                 alert("이메일을 입력하세요.");
                 return false;
             }
        	
        	if(!document.profile.phone.value){
                alert("전화번호를 입력하세요.");
                return false;
            }
            
           
            
            if(!document.profile.addresssub.value){
                alert("상세주소를 입력하세요.");
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
	
	
	//쿼리 결과를 담을 변수
	String seedname;
	int price;
	int sow;
	String company;
	int seedid;
	
	
	
	%>
	<br>
	<br>
	<br>
	
	<h1 style="color:black; text-align:center"><b>내 정보</b></h1>
	<br>
	
	<%! 
		int custid; 
		String name;
		String birth;
		String email;
		String phone;
		String address;
		String grade;
		int recommend;
		ResultSet rs;
		int recommendcount;
 		String recommenddate;
	
	%>
	
	<% grade = (String)session.getAttribute("grade"); %>
	
	<!-- 일반고객 프로필 -->
	<%if("BRONZE".equals(grade)||"SILVER".equals(grade)){ 
		int normalcustid = (Integer)session.getAttribute("normalcustid");
		String normalProfile = "select normalcustomer.normalcustid, name, to_char(birth,'yyyy-mm-dd'), email, phone, concat(addressmain,addresssub) ,grade , nvl((select recommend from normalmanagement where normalmanagement.normalcustid =normalcustomer.normalcustid),'0') from normalcustomer where normalcustomer.normalcustid = " + normalcustid;
		pstmtSelect = conn.prepareStatement(normalProfile);
		rs = pstmtSelect.executeQuery(); 
	
	
	%>
			<form action="ProfileResult.jsp" name="profile" onsubmit="return checkValue()">
			<table style="margin:auto;  width:100%; font-size:11pt;">
				<tr>
					<td><b>고객번호</b></td>	
					<td><b>이름</b></td>	
					<td><b>생년월일</b></td>	
					<td><b>이메일</b></td>
					<td><b>이메일 수정</b></td>
					<td><b>휴대전화</b></td>
					<td><b>휴대전화 수정</b></td>
					<td><b>주소</b></td>
					<td><b>주소 수정</b></td>
					<td><b>등급</b></td>	
					<td><b>추천고객</b></td>	
				</tr>
			
			<%
		 	while (rs.next())
			{
		 		custid = rs.getInt(1);
		 		name = rs.getString(2);
		 		birth = rs.getString(3);
		 		email = rs.getString(4);
		 		phone = rs.getString(5); 
		 		address = rs.getString(6); 
		 		grade = rs.getString(7); 
		 		recommend = rs.getInt(8); 
		 		
		 		%>
		 		<tr>
					<td><%= custid %></td>	
					<td><%= name %></td>	
					<td><%= birth %></td>	
					<td><%= email %></td>	
					<td>
                        <input type="text" name="email" maxlength="30" style="height:25px; width:100px;">@
                        <select name="email2">
                            <option>naver.com</option>
                            <option>daum.net</option>
                            <option>gmail.com</option>
                            <option>nate.com</option>                        
                        </select>
                    </td>
					<td><%= phone %></td>	
					<td>
                        <input type="text" name="phone" style="height:25px; width:100px;" />
                    </td>
					<td><%= address %></td>	
                    <td>
                        <select name="addressmain">
                        	<option>서울특별시</option>
                            <option>인천광역시</option>
                            <option>경기도</option>
                            <option>강원도</option>   
                            <option>충청남도</option>
                            <option>충청북도</option>
                            <option>전라북도</option>  
                            <option>전라남도</option>
                            <option>광주광역시</option>
                            <option>경상남도</option>   
                            <option>대구광역시</option>
                            <option>부산광역시</option>   
                            <option>울산광역시</option>  
                            <option>경상북도</option>    
                            <option>세종특별자치시</option>
                            <option>대전광역시</option>    
                            <option>제주특별자치도</option>  
                        </select>
                        <input type="text" size="20" name="addresssub" style="height:25px;"/>
                    </td>
                     
                    
					<td><%= grade %></td>
					<td>등급제한</td>	
				</tr>
		 	
		 		<%
			} 
			rs.close();
			%>
			</table>
			<br>
			<div style="text-align:center;">
			<input type="submit" value="수정하기">
			</div>
			</form>
			
			
			
	<!-- 중요고객프로필 -->		
	<%}else if("GOLD".equals(grade)||"DIAMOND".equals(grade)){ 
		int importantcustid = (Integer)session.getAttribute("importantcustid");
		String ImportantProfile = "select importantcustomer.importantcustid, name, to_char(birth,'yyyy-mm-dd'), email, phone, concat(addressmain,addresssub) ,grade , nvl((select recommend from importantmanagement where importantmanagement.importantcustid =importantcustomer.importantcustid),'0'), nvl((select recommendcount from importantmanagement where importantmanagement.importantcustid =importantcustomer.importantcustid),'0'),  to_char(nvl((select recommenddate from importantmanagement where importantmanagement.importantcustid =importantcustomer.importantcustid),to_date('1111-11-11','yyyy-mm-dd')),'yyyymmdd') from importantcustomer where importantcustomer.importantcustid = " + importantcustid;
		pstmtSelect = conn.prepareStatement(ImportantProfile);
		rs = pstmtSelect.executeQuery(); 
	
	
	%>
			<form action="ProfileResult.jsp" name="profile" onsubmit="return checkValue()">
			<table style="margin:auto;  width:100%; font-size:11pt;">
				<tr>
					<td><b>고객번호</b></td>	
					<td><b>이름</b></td>	
					<td><b>생년월일</b></td>	
					<td><b>이메일</b></td>
					<td><b>이메일 수정</b></td>
					<td><b>휴대전화</b></td>
					<td><b>휴대전화 수정</b></td>
					<td><b>주소</b></td>
					<td><b>주소 수정</b></td>
					<td><b>등급</b></td>	
					<td><b>추천고객</b></td>	
					<td><b>추천받은횟수</b></td>	
					
				</tr>
			
			<%
		 	while (rs.next())
			{
		 		custid = rs.getInt(1);
		 		name = rs.getString(2);
		 		birth = rs.getString(3);
		 		email = rs.getString(4);
		 		phone = rs.getString(5); 
		 		address = rs.getString(6); 
		 		grade = rs.getString(7); 
		 		recommend = rs.getInt(8); 
		 		recommendcount = rs.getInt(9); 
		 		
		 		
		 		%>
		 		<tr>
					<td><%= custid %></td>	
					<td><%= name %></td>	
					<td><%= birth %></td>	
					<td><%= email %></td>	
					<td>
                        <input type="text" name="email" maxlength="30" style="height:25px; width:80px;">@
                        <select name="email2">
                            <option>naver.com</option>
                            <option>daum.net</option>
                            <option>gmail.com</option>
                            <option>nate.com</option>                        
                        </select>
                    </td>
					<td><%= phone %></td>	
					<td>
                        <input type="text" name="phone" style="height:25px; width:80px;"/>
                    </td>
					<td><%= address %></td>	
                    <td>
                         <select name="addressmain">
                        	<option>서울특별시</option>
                            <option>인천광역시</option>
                            <option>경기도</option>
                            <option>강원도</option>   
                            <option>충청남도</option>
                            <option>충청북도</option>
                            <option>전라북도</option>  
                            <option>전라남도</option>
                            <option>광주광역시</option>
                            <option>경상남도</option>   
                            <option>대구광역시</option>
                            <option>부산광역시</option>   
                            <option>울산광역시</option>  
                            <option>경상북도</option>    
                            <option>세종특별자치시</option>
                            <option>대전광역시</option>    
                            <option>제주특별자치도</option>  
                        </select>
                        <input type="text" size="20" name="addresssub" style="height:25px; width:150px;"/>
                    </td>
					<td><%= grade %></td><%
					if(recommend==0){%><td>없음</td><%}	
					else{%><td><%= recommend %></td><%}%>	
					<td><%= recommendcount %> 번</td>
					
				</tr>
		 	
		 		<%
			}
			rs.close();
			%>
			</table>
			<br>
			<div style="text-align:center;">
			<input type="submit" value="수정하기">
			</div>
			</form>
			
			
	
	
	<!-- 비회원 리턴 -->
	<% }else{
	out.println("<script> alert('로그인 후 이용 가능합니다');history.go(-1);</script>");
	}		

	
	}catch(Exception e){
		e.printStackTrace();
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