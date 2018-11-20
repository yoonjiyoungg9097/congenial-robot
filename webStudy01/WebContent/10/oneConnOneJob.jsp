<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="kr.or.ddit.db.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>10/oneConnOneJob.jsp</title>
</head>
<body>
<%
	long startTime = System.currentTimeMillis();
	try(
		Connection conn = ConnectionFactory.getConnection();
		Statement stmt = conn.createStatement();
	){
		String sql = "select mem_name from member where mem_id = 'a001'";
		ResultSet rs = stmt.executeQuery(sql);
		if(rs.next()){
			out.println(rs.getString(1));
		}
	}
	long endTime = System.currentTimeMillis();
	
%>
소요 시간 : <%=endTime-startTime %>ms
</body>
</html>