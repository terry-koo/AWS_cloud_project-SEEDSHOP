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
	
	<script type="text/javascript">
    
        // 필수 입력정보인 아이디, 비밀번호가 입력되었는지 확인하는 함수
        function checkValue()
        {
            if(!document.userInfo.id.value){
                alert("아이디를 입력하세요.");
                return false;
            }
            
            if(!document.userInfo.password.value){
                alert("비밀번호를 입력하세요.");
                return false;
            }
            
            // 비밀번호와 비밀번호 확인에 입력된 값이 동일한지 확인
            if(document.userInfo.password.value != document.userInfo.passwordcheck.value ){
                alert("비밀번호를 동일하게 입력하세요.");
                return false;
            }
        }
        
        // 취소 버튼 클릭시 로그인 화면으로 이동
        function goLoginForm() {
            location.href="/seedshop/home/index.html";
        }
    </script>
	<link rel="shortcut icon" href="images/favicon.ico" />
	
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

	<header id="gtco-header" class="gtco-cover" role="banner" style="background-image:url(images/Sunflower_from_Silesia2.jpg); height:100px;">
		</header>
	
<!--@@@@@@@@@@@@@@@@@@@  양식 시작    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->	

		
		
<div id="wrap" style="margin:auto; background-color:white; padding:80px">
        <br><br>
        <div style="text-align:center;"><b><font size="6" color="gray">회원가입</font></b></div>
        <div style="text-align:center;"><b><font size="2" color="gray">[씨앗상점의 회원이 되어주세요]</font></b></div>     
        
        <br><br>
        <div style="text-align:center;"><b><font size="2" style="color:red;"><b>* 표시 필수입력 사항</b></font></b></div>     


  
        <form method="post" action="JoinResult.jsp" name="userInfo" onsubmit="return checkValue()">
            <table style="margin:auto;">
                <tr>
                    <td id="title">아이디<font style="color:red;"><b>*</b></font></td>
                    <td>
                        <input type="text" name="id" maxlength="50"  placeholder="10자리 이하">                     
                    </td>
                </tr>
                
                <tr style="height:5pt"><td></td></tr>
                
                        
                <tr>
                    <td id="title">비밀번호<font style="color:red;"><b>*</b></font></td>
                    <td>
                        <input type="password" name="password" maxlength="50" placeholder="3~10자리 ">
                    </td>
                </tr>
                
               <tr style="height:5pt"><td></td></tr>
                
                <tr>
                    <td id="title">비밀번호 확인<font style="color:red;"><b>*</b></font></td>
                    <td>
                        <input type="password" name="passwordcheck" maxlength="50">
                    </td>
                </tr>
                
                <tr style="height:5pt"><td></td></tr>
                                 
                <tr>
                    <td id="title">이름<font style="color:red;"><b>*</b></font></td>
                    <td>
                        <input type="text" name="name" maxlength="50">
                    </td>
                </tr>
                
                <tr style="height:5pt"><td></td></tr>
                
                 <tr>
                    <td id="title">생일<font style="color:red;"><b>*</b></font></td>
                    <td>
                        <input type="text" name="birthyyyy" maxlength="4" placeholder="년(4자)" size="6" >
                        <select name="birthmm" style="height:24pt;">
                            <option value="">월</option>
                            <option value="01" >1</option>
                            <option value="02" >2</option>
                            <option value="03" >3</option>
                            <option value="04" >4</option>
                            <option value="05" >5</option>
                            <option value="06" >6</option>
                            <option value="07" >7</option>
                            <option value="08" >8</option>
                            <option value="09" >9</option>
                            <option value="10" >10</option>
                            <option value="11" >11</option>
                            <option value="12" >12</option>
                        </select>
                        <input type="text" name="birthdd" maxlength="2" placeholder="일" size="4" >
                    </td>
                </tr>   
                
                <tr style="height:5pt"><td></td></tr>
                 
                <tr>
                    <td id="title">성별<font style="color:red;"><b>*</b></font></td>
                    <td>
                        <input type="radio" name="sex" value="남" checked>남
                        <input type="radio" name="sex" value="여" checked>여
                    </td>
                </tr>
                
                <tr style="height:5pt"><td></td></tr>
                    
                <tr>
                    <td id="title">이메일<font style="color:red;"><b>*</b></font></td>
                    <td>
                        <input type="text" name="email" maxlength="50">@
                        <select name="email2">
                            <option>naver.com</option>
                            <option>daum.net</option>
                            <option>gmail.com</option>
                            <option>nate.com</option>                        
                        </select>
                    </td>
                </tr>
                
                <tr style="height:5pt"><td></td></tr>
                    
                <tr>
                    <td id="title">휴대전화<font style="color:red;"><b>*</b></font></td>
                    <td>
                        <input type="text" name="phone" />
                    </td>
                </tr>
                
                <tr style="height:5pt"><td></td></tr>
                
                <tr>
                    <td id="title">주소<font style="color:red;"><b>*</b></font></td>
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
                    </td>
                </tr>
                
                <tr style="height:5pt"><td></td></tr>
                
                <tr>
                	<td id="title">상세주소<font style="color:red;"><b>*</b></font></td>
                    <td>
                        <input type="text" size="50" name="addresssub"/>
                    </td>
                </tr>
              
            </table>
            <br>
            
            <div style="text-align:center;">
            <input type="submit" value="가입"/>  
            <input type="button" value="홈으로" onclick="goLoginForm()">
            </div>
            
        </form>
    </div>
    
    
  	
		
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