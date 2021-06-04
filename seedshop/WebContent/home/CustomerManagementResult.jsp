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
<title>고객관리등륵</title>
<link rel="shortcut icon" href="images/favicon.ico" />
</head>
<body>



<%! int importantcustid;
	int staffid;
	
%>


<%
	Connection conn = null;
	PreparedStatement pstmt = null;
    
	
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "seedshop";
	String pass = "seedshop001";
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(Data.url, Data.user, Data.pass);
	
	
	try{
	
		
	request.setCharacterEncoding("utf-8");
	
	 
	int staffid = (Integer)session.getAttribute("staffid");	 


	importantcustid = Integer.parseInt((String)request.getParameter("custid"));
	
	 
  	
	String query = "update importantmanagement set staffid = ? where importantcustid = " +importantcustid ;
	pstmt = conn.prepareStatement(query);
	pstmt.setInt(1, staffid);
	pstmt.executeUpdate(); 
	pstmt.close();


		
	}catch(Exception e){
		e.printStackTrace();%>
			<script>
				alert("올바른 값을 입력하시오");
				document.location.href="/seedshop/home/index.jsp"
			</script>
		<%
	}finally{
		try{
			if(pstmt != null) pstmt.close();
			if(conn != null) conn.close();			
		}catch(Exception e){
				
		}
	}
	
	
%>


<jsp:forward page="CustomerManagement.jsp"/>





</body>
</html>