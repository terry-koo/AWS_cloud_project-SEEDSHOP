<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*" %>
<%@page import="java.sql.Date" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="database.*" %>
<
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매데이터 저장</title>
<link rel="shortcut icon" href="images/favicon.ico" />
</head>
<body>
<%!
int priceplant;
int price;
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
int orderid;
int shippingcharge;
Date date;
%>


<%

date = transformDate("11111111");
int normalcustid = (Integer)session.getAttribute("normalcustid");
if((Integer)normalcustid==null){  
	out.println("<script> alert('로그인 후 이용 가능합니다');history.go(-1);</script>");
}else{
	Connection conn = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmtship = null;
	PreparedStatement pstmtSelect = null;
    PreparedStatement pstmt1 = null; 
    PreparedStatement pstmt2 = null; 
    PreparedStatement afterorderpstm = null; 
   
	
	String url = "jdbc:oracle:thin:seedshop-oracle.cevmjfigajuy.ap-northeast-2.rds.amazonaws.com:1521:ORCL";
	String user = "terrykoo";
	String pass = "terry9497";
	
	
	
	
	try{
	request.setCharacterEncoding("utf-8");
	
	//현재 날짜 계산
	SimpleDateFormat format1 = new SimpleDateFormat ("yyyyMMdd");
	String format_time1 = format1.format(System.currentTimeMillis());
	Date now = transformDate(format_time1); 
	
	
	
	
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		conn = DriverManager.getConnection(Data.url, Data.user, Data.pass);
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(Data.url, Data.user, Data.pass);
		
		
		
		//고객주소 참고하여 택배가격 구하기
		String shippingquery = "select charge from vw_shippingcharge where normalcustid="+normalcustid;
		pstmtship = conn.prepareStatement(shippingquery);
		ResultSet rsship = pstmtship.executeQuery(); 
		//고객번호가 100번부터 시작하게
	 	while (rsship.next())
		{
	 		shippingcharge = rsship.getInt(1);
		} 
	 	rsship.close();
		
		
		
		
		
		//주문 씨앗 가격 구하기
		
		if(request.getParameterValues("seedid")!=null){
			String[] seedString = request.getParameterValues("seedid");
			int[] seedValues = new int[seedString.length];
			//체크한 값들을 int형 배열에 집어넣기위해
			for(int i =0; i<seedValues.length; i++){ seedValues[i]=Integer.parseInt(seedString[i]); }
					
				if(seedValues != null){
					for(int i=0; i<seedValues.length; i++){
						
						
						
						///현재 데이터베이스에 저장된 orderid의 최댓값을 구해서 중복된 데이터 저장 방지
						String orderidquery = "select orderid  from (select orderid from onlineorder order by orderid desc) where rownum<=1";
						pstmtSelect = conn.prepareStatement(orderidquery);
						ResultSet rs = pstmtSelect.executeQuery(); 
						//고객번호가 100번부터 시작하게
						int orderid = 1; 
						orderid = 1; 
					 	while (rs.next())
						{
					 		orderid = rs.getInt(1)+1;
						} 
						rs.close();
						
						
		 					
						
						
						String seedquery = "select  price  from seed where seedid = " + seedValues[i];    //오류 가능성 있음!!!!!!!!!!
						pstmt1 = conn.prepareStatement(seedquery);
						
						ResultSet seedrs = pstmt1.executeQuery(); 
						while (seedrs.next())
						{
					 		price = seedrs.getInt(1);
					 		
						}
						seedrs.close();
						
				
				
				
						
						pstmt = conn.prepareStatement("insert into onlineorder(orderid, normalcustid, importantcustid, seedid, plantid, orderdate, saleprice)"+
								"values(?,?,?,?,?,?,?)"); 
						pstmt.setInt(1,orderid);
						//값이 없을때는 null값이 아닌 0이 들어가게 처리
						pstmt.setInt(2,normalcustid); 
						pstmt.setInt(3,0); 
						pstmt.setInt(4,seedValues[i]); 
						pstmt.setInt(5,0); 
						pstmt.setDate(6, now);
						pstmt.setInt(7,price);
						pstmt.setInt(7,price+shippingcharge);
						pstmt.executeUpdate(); 
								
						//입금테이블, 택배테이블 생성
						String paidquery = "insert into paid values(?,?)";
						afterorderpstm = conn.prepareStatement(paidquery);
						afterorderpstm.setInt(1,orderid);
						afterorderpstm.setInt(2,0);
						afterorderpstm.executeUpdate(); 
						afterorderpstm.close();
						
						String deliveryquery = "insert into delivery values(?,?,?)";
						afterorderpstm = conn.prepareStatement(deliveryquery);
						afterorderpstm.setInt(1,orderid);
						afterorderpstm.setDate(2, date);
						afterorderpstm.setDate(3, date);
						afterorderpstm.executeUpdate(); 
						afterorderpstm.close();
						
					};
				}
				
				SimpleEmailService.SendMessage("gg"); //이메일 보내기
			}	///
		
		
		//주문 모종 가격 구하기
		if(request.getParameterValues("plantid")!=null){
			String[] plantString = request.getParameterValues("plantid");
			int[] plantValues = new int[plantString.length];
			//체크한 값들을 int형 배열에 집어넣기위해
			for(int i =0; i<plantValues.length; i++){ plantValues[i]=Integer.parseInt(plantString[i]); }
					
				if(plantValues != null){
					for(int i=0; i<plantValues.length; i++){
						
						
						
						///현재 데이터베이스에 저장된 orderid의 최댓값을 구해서 중복된 데이터 저장 방지
						String orderidquery = "select orderid  from (select orderid from onlineorder order by orderid desc) where rownum<=1";
						pstmtSelect = conn.prepareStatement(orderidquery);
						ResultSet rs = pstmtSelect.executeQuery(); 
						//고객번호가 100번부터 시작하게
						int orderid = 1; 
						orderid = 1; 
					 	while (rs.next())
						{
					 		orderid = rs.getInt(1)+1;
						} 
						rs.close();
						
						
						
						
						String plantquery = "select  price  from plant where plantid = "+plantValues[i];    //오류 가능성 있음!!!!!!!!!!
						pstmt1 = conn.prepareStatement(plantquery);
						
						ResultSet plantrs = pstmt1.executeQuery(); 
						while (plantrs.next())
						{
					 		price = plantrs.getInt(1);
					 		
						}
						plantrs.close();
						
				
				///
				
						
						pstmt = conn.prepareStatement("insert into onlineorder(orderid, normalcustid, importantcustid, seedid, plantid, orderdate, saleprice)"+
								"values(?,?,?,?,?,?,?)"); 
						pstmt.setInt(1,orderid);
						//값이 없을때는 null값이 아닌 0이 들어가게 처리
						pstmt.setInt(2,normalcustid); 
						pstmt.setInt(3,0); 
						pstmt.setInt(4,0); 
						pstmt.setInt(5,plantValues[i]); 
						pstmt.setDate(6, now);
						pstmt.setInt(7,price);
						pstmt.setInt(7,price+shippingcharge);
						pstmt.executeUpdate(); 
								
						//입금테이블, 택배테이블 생성
						String paidquery = "insert into paid values(?,?)";
						afterorderpstm = conn.prepareStatement(paidquery);
						afterorderpstm.setInt(1,orderid);
						afterorderpstm.setInt(2,0);
						afterorderpstm.executeUpdate(); 
						afterorderpstm.close();
						
						String deliveryquery = "insert into delivery values(?,?,?)";
						afterorderpstm = conn.prepareStatement(deliveryquery);
						afterorderpstm.setInt(1,orderid);
						afterorderpstm.setDate(2, date);
						afterorderpstm.setDate(3, date);
						afterorderpstm.executeUpdate(); 
						afterorderpstm.close();
					};
				}
				
				SimpleEmailService.SendMessage("gg"); //이메일 보내기
			}	///
		 
		
		
		 	

	
	
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
			if(pstmt1 != null) pstmt1.close();
			if(pstmt2 != null) pstmt2.close();
			if(pstmtship != null) pstmtship.close();
			if(conn != null) conn.close();			
		}catch(Exception e){
				
		}
	}
	out.println("<script> alert('구매 완료');history.go(-1);</script>");
	
}//로그인했을때 실행시키는 else문 닫음 %>
 
</body>
</html>