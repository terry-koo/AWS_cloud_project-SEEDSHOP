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
<title>회원가입데이터 저장</title>
</head>
<body>
<%! String id; %>
<%! String password; %>
<%! String remember; %>
<%! String name; %>
<%! String grade; %>
<%! String staffid; %>
<%! int staffidnum; %>



<%!
//password 암호화 메소드 : 문자열을 아스키코드로 변환하여 특정 상수를 더한다음 다시 문자열로 만듬
public String secret(String password) {
	String pass = password;		
	char[] arrChar = pass.toCharArray();
	int[] resultArr = new int[arrChar.length];
	for(int i=0; i<arrChar.length; i++) {
		resultArr[i] = (int)arrChar[i]+10;			
	}
	
	for(int i=0; i<arrChar.length; i++) {
		arrChar[i] = (char)resultArr[i];			
	}
	String a = Arrays.toString(arrChar);
	String a1 = a.replace("[","");
	String a2 = a1.replace("]","");
	String a3 = a2.replace(",","");
	String a4 = a3.replace(" ","");
	return a4;
}

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
	id= request.getParameter("id");
	
	
	
	//password 암호화
	String passbefore = request.getParameter("password");
	password = secret(passbefore);
	
	//아이디 기억하기 체크 여부
	remember = request.getParameter("remember");
	
 	
	
	//동적로딩	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(Data.url, Data.user, Data.pass);
	
	//마스터 계정 로그인 확인
		String masterquery = "select masterid, masterpassword from master where masterid like '"+id+"'";
		PreparedStatement idstate2 = conn.prepareStatement(masterquery);
		ResultSet idrs2 = idstate2.executeQuery(); 
		while (idrs2.next())
		{
			 if(idrs2.getString(1).equals(id)&&idrs2.getString(2).equals(password)){
			 		id = idrs2.getString(1);
			 		session.setAttribute("master", "true");
			 		if("on".equals(remember)){session.setAttribute("remember", id);}
			 		%>
			 		<jsp:forward page="index.jsp"/>
			 		 <%
			 }
				
		}
		idrs2.close(); 
	
		
	//직원 계정 로그인 확인
	String staffquery = "select id, password, staffid,name from staff where id like '"+id+"'";
		PreparedStatement staffstate = conn.prepareStatement(staffquery);
		ResultSet staffrs = staffstate.executeQuery(); 
		
		while (staffrs.next())
		{	
			
			 if(staffrs.getString(1).equals(id)&&staffrs.getString(2).equals(passbefore)){
			 		staffid = staffrs.getString(1);
			 		staffidnum = staffrs.getInt(3);
			 		String staffname = staffrs.getString(4) + " 직원";
			 		session.setAttribute("staffid", (Integer)staffidnum);
			 		session.setAttribute("name", staffname);
			 		session.setAttribute("staff", "true");
			 		
			 		
			 		if("on".equals(remember)){session.setAttribute("remember", id);}
			 		%>
			 		<jsp:forward page="index.jsp"/>
			 		<%
			 }
				
		}
		staffrs.close(); 
		
		
	
		
		//일반 로그인 확인
		String idquery = "select id, password,name,grade,normalcustid from normalcustomer where id like '"+id+"'";
		PreparedStatement idstate = conn.prepareStatement(idquery);
		ResultSet idrs = idstate.executeQuery(); 
		while (idrs.next())
		{
			 if(idrs.getString(1).equals(id)&&idrs.getString(2).equals(password)){
			 		name = idrs.getString(3);
			 		id = idrs.getString(1);
			 		grade= idrs.getString(4);
			 		int normalcustid = idrs.getInt(5);
			 		session.setAttribute("login", "true");
			 		session.setAttribute("id", id);
			 		session.setAttribute("name", name);
			 		session.setAttribute("grade", grade);
			 		session.setAttribute("normalcustid", normalcustid);
			 		if("on".equals(remember)){session.setAttribute("remember", id);}
			 		%>
			 		<jsp:forward page="index.jsp"/>
			 		 <%
			 }
				
		}
		idrs.close(); 
		
		//중요고객 로그인 확인 구현자리
		//session.setAttribute("importantcustid", importantcustid);
		
		String importantidquery = "select id, password,name,grade,importantcustid from importantcustomer where id like '"+id+"'";
		PreparedStatement importantidstate = conn.prepareStatement(importantidquery);
		ResultSet imidrs = importantidstate.executeQuery(); 
		while (imidrs.next())
		{
			 if(imidrs.getString(1).equals(id)&&imidrs.getString(2).equals(password)){
			 		name = imidrs.getString(3);
			 		id = imidrs.getString(1);
			 		grade= imidrs.getString(4);
			 		int importantcustid = imidrs.getInt(5);
			 		session.setAttribute("login", "true");
			 		session.setAttribute("id", id);
			 		session.setAttribute("name", name);
			 		session.setAttribute("grade", grade);
			 		session.setAttribute("importantcustid", importantcustid);
			 		if("on".equals(remember)){session.setAttribute("remember", id);}
			 		%>
			 		<jsp:forward page="index.jsp"/>
			 		<%
			 }
				
		}
		imidrs.close(); 
		
		
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
	<script>
				alert("아이디나 비밀번호가 틀립니다");
				document.location.href="/seedshop/templete/login.jsp"
	</script>





</body>
</html>