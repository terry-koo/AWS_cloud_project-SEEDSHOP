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
<meta charset="UTF-8">
<title>프로필수정저장</title>
<link rel="shortcut icon" href="images/favicon.ico" />
</head>
<body>
<%! String id;
	String email;
	String email2;
	String phone;
	String addresssub;
	String addressmain;
	int normalcustid;
	int importantcustid;
	String grade;
	

%>



<%
	Connection conn = null;
	PreparedStatement pstmt = null;
    PreparedStatement pstmtSelect = null; 
	
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "seedshop";
	String pass = "seedshop001";
	
	try{
	request.setCharacterEncoding("utf-8");
	
			
	
	if(request.getParameter("phone")!=null){
	 phone = request.getParameter("phone");}
	
	if(request.getParameter("email")!=null){
	 email = request.getParameter("email");
	 email2 = request.getParameter("email2");
	 email = email + "@" + email2;
	}
	
	if(request.getParameter("addresssub")!=null){
	 addressmain = request.getParameter("addressmain");
	 addresssub = request.getParameter("addresssub");
	}

	
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(Data.url, Data.user, Data.pass);
		
		
		grade = (String)session.getAttribute("grade");
		
		 
		
		
		
		if("BRONZE".equals(grade)||"SILVER".equals(grade)){ 
			
		normalcustid = (Integer)session.getAttribute("normalcustid");
	
		String normalupdate = "update normalcustomer set phone= ?,email=?, addressmain= ?, addresssub = ? where normalcustid = "+ normalcustid;
		pstmtSelect = conn.prepareStatement(normalupdate);
	
		pstmtSelect.setString(1, phone);
		pstmtSelect.setString(2, email);
		pstmtSelect.setString(3, addressmain);
		pstmtSelect.setString(4, addresssub);
		
		pstmtSelect.executeUpdate(); 
	
		
	
		
		
		}else if("GOLD".equals(grade)||"DIAMOND".equals(grade)){ 
			 importantcustid = (Integer)session.getAttribute("importantcustid");
			 
			 
			 importantcustid = (Integer)session.getAttribute("importantcustid");
				
				String importantupdate = "update importantcustomer set phone= ?,email=?, addressmain= ?, addresssub = ? where importantcustid = "+ importantcustid;
				pstmtSelect = conn.prepareStatement(importantupdate);
			
				pstmtSelect.setString(1, phone);
				pstmtSelect.setString(2, email);
				pstmtSelect.setString(3, addressmain);
				pstmtSelect.setString(4, addresssub);
				
				pstmtSelect.executeUpdate(); 
			 
			 
			 
			 
		}else{
			out.println("<script> alert('로그인 후 이용 가능합니다');history.go(-1);</script>");
		}	
		
		
	}catch(Exception e){
		e.printStackTrace();%>
			<script>
				alert("올바른 값을 입력하시오");
				document.location.href="/seedshop/home/JoinForm.jsp"
			</script>
		<%
	}finally{
		try{
			if(pstmt != null) pstmt.close();
			if(pstmtSelect != null) pstmtSelect.close();
			if(conn != null) conn.close();			
		}catch(Exception e){
				
		}
	}
	
	out.println("<script> alert('회원정보 수정 성공');history.go(-1);</script>");
%>








</body>
</html>