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

<%! int paidcheckmanage;
	String startdatemanage;
	String enddatemanage;
	int orderid;
	String query;
	
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
	
			
 	if(request.getParameter("orderid")!=null){
		orderid = Integer.parseInt(request.getParameter("orderid"));

	}
	
  	if(request.getParameter("paidcheckmanage"+orderid)!=""){
  		
		paidcheckmanage = Integer.parseInt(request.getParameter("paidcheckmanage"+orderid));
  		
		query = "update paid set paidcheck = ? where orderid = " + orderid;
		pstmt = conn.prepareStatement(query);
		pstmt.setInt(1, paidcheckmanage);
		pstmt.executeUpdate(); 
		pstmt.close();

	}  
	
if(request.getParameter("startdatemanage"+orderid)!=""){  
		startdatemanage =(String)request.getParameter("startdatemanage"+orderid);
		
		query = "update delivery set startdate = to_date(?,'yyyy-mm-dd') where orderid = " + orderid;
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, startdatemanage);
		pstmt.executeUpdate(); 
		pstmt.close();
 	 }  
	
	  if(request.getParameter("enddatemanage"+orderid)!=""){  
		enddatemanage = (String)request.getParameter("enddatemanage"+orderid);
	
		query = "update delivery set enddate = to_date(?,'yyyy-mm-dd') where orderid = " + orderid;
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, enddatemanage);
		pstmt.executeUpdate(); 
		pstmt.close(); 
	  } 
	

	
		
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
<jsp:forward page="OrdersManagement.jsp"/>







</body>
</html>