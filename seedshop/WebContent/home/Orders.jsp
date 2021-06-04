<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

if((Integer)session.getAttribute("normalcustid")!=null){
	%>
	<jsp:forward page="NormalOrders.jsp"/>
	<%
}else if((Integer)session.getAttribute("importantcustid")!=null){
	%>
	<jsp:forward page="ImportantOrders.jsp"/>
	<%
}else{
	out.println("<script> alert('로그인 후 이용 가능합니다');history.go(-1);</script>");
}
%>


</body>
</html>