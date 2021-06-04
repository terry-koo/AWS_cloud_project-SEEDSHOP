<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="database.Data" %>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.Date" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="database.Data" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
안녕하세요
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
    PreparedStatement pstmtSelect = null; 
	
	//String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	//String user = "seedshop";
	//String pass = "seedshop001";
	
	try{
	request.setCharacterEncoding("utf-8");
	
	
	//동적로딩
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(Data.url, Data.user, Data.pass);
	
	
	
	String seedquery = "select seedname, price, sow  from seed";
	pstmtSelect = conn.prepareStatement(seedquery);
	
	//쿼리 결과를 담을 변수
	String seedname;
	int price;
	int sow;
	String company;
	int seedid;

	
	ResultSet rs = pstmtSelect.executeQuery(); 
%>
	
	
	<table>
		<tr>
			<td><b>씨앗명</b></td>	
			<td><b>가격</b></td>	
			<td><b>파종시기</b></td>		
		</tr>
	
<%
 	while (rs.next())
	{
 		seedname = rs.getString(1);
 		price = rs.getInt(2);
 		sow = rs.getInt(3);
 		
%>
 		<tr>
			<td><b><%= seedname %></b></td>	
			<td><%= price %>원</td>	
			<td ><%= sow %>월</td>	
		</tr>
 	
 <%
	} 
%>
	</table>
테이블끝
<%
	rs.close();
			
	}catch(Exception e){
		e.printStackTrace();
%>
			
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
마지막

</body>
</html>