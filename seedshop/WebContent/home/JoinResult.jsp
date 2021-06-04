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
<link rel="shortcut icon" href="images/favicon.ico" />
</head>
<body>
<%! String id; %>

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

//password 복호화 메소드
public static String secretOpen(String password) {
	String pass = password;		
	char[] arrChar = pass.toCharArray();
	int[] resultArr = new int[arrChar.length];
	for(int i=0; i<arrChar.length; i++) {
		resultArr[i] = (int)arrChar[i]-10;			
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
	PreparedStatement pstmt1 = null;
    PreparedStatement pstmtSelect = null; 
	
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
	String user = "seedshop";
	String pass = "seedshop001";
	
	try{
	request.setCharacterEncoding("utf-8");
	id= request.getParameter("id");
	
	//password 암호화
	String passbefore = request.getParameter("password");
	String password = secret(passbefore);
	
	
	String name = request.getParameter("name");
	
	//생년월일 계산
	String birthyyyy = request.getParameter("birthyyyy");
	String birthmm = request.getParameter("birthmm");
	String birthdd = request.getParameter("birthdd");
	String birth = birthyyyy+ birthmm + birthdd;
	
	//최종생년월일
	Date date = transformDate(birth);
	
	//나이 계산
	SimpleDateFormat format1 = new SimpleDateFormat ("yyyy");
	String format_time1 = format1.format(System.currentTimeMillis());
	int age = (Integer.parseInt(format_time1)-Integer.parseInt(birthyyyy));
	
	String sex = request.getParameter("sex");
	
	String emailfront = request.getParameter("email");
	String emailend = request.getParameter("email2");
	String email = emailfront + "@" +emailend;
	
		
	
	
	String phone = request.getParameter("phone");
	String addressmain = request.getParameter("addressmain");
	String addresssub = request.getParameter("addresssub");
	

	
 	
	
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(Data.url, Data.user, Data.pass);
		
		
		///현재 데이터베이스에 저장된 normalcustid중 최대값을 확인하여 중복된 normalcustid가 데이터베이스에 저장되지 않게
		String normalcustidMax = "select normalcustid  from (select normalcustid from normalcustomer order by normalcustid desc) where rownum<=1";
		pstmtSelect = conn.prepareStatement(normalcustidMax);
		ResultSet rs = pstmtSelect.executeQuery(); 
		//고객번호가 100번부터 시작하게
		int normalcustid = 100; 
	 	while (rs.next())
		{
			 normalcustid = rs.getInt(1)+1;
		} 
		rs.close();
		
		//일반 고객테이블에서 아이디 중복확인
		String idquery = "select id from normalcustomer where id like '"+id+"'";
		PreparedStatement idstate = conn.prepareStatement(idquery);
		ResultSet idrs = idstate.executeQuery(); 
		while (idrs.next())
		{
			if(idrs.getString(1).equals(id)){%>
				<jsp:forward page="JoinForm.jsp"/>
			  <% };
		}; 
		idrs.close(); 
		
		//중요 고객 테이블에서 아이디 중복확인
		String importantidquery = "select id from importantcustomer where id like '"+id+"'";
		PreparedStatement imidstate = conn.prepareStatement(importantidquery);
		ResultSet imidrs = imidstate.executeQuery(); 
		while (imidrs.next())
		{
			if(imidrs.getString(1).equals(id)){%>
				<jsp:forward page="JoinForm.jsp"/>
			  <% };
		}; 
		imidrs.close(); 
		
		
		//데이터베이스에 데이터 입력
		pstmt = conn.prepareStatement("insert into normalcustomer(normalcustid, id, password, age, sex, email, phone, addressmain, addresssub, grade, name, birth)"+
							"values(?,?,?,?,?,?,?,?,?,?,?,?)"); 
		pstmt.setInt(1,normalcustid);
		pstmt.setString(2,id);
		pstmt.setString(3,password);
		pstmt.setInt(4,age);
		pstmt.setString(5,sex);
		pstmt.setString(6,email);
		pstmt.setString(7,phone);
		pstmt.setString(8,addressmain);
		pstmt.setString(9,addresssub);
		pstmt.setString(10,"BRONZE");
		pstmt.setString(11,name);
		pstmt.setDate(12,date);
		
		pstmt.executeUpdate();
		
		
	
			
		
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
			if(pstmt1 != null) pstmt1.close();
			if(pstmtSelect != null) pstmtSelect.close();
			if(conn != null) conn.close();			
		}catch(Exception e){
				
		}
	}
%>

<script>
alert("회원가입 성공")
document.location.href="/seedshop/templete/login.jsp"
</script>




</body>
</html>