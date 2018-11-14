<%@page import="java.util.Map"%>
<%@page import="kr.or.ddit.vo.AlbasengVO"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="kr.or.ddit.web.SimpleFormProcessServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>05/albaList.jsp</title>
</head>
<body>
	<table>
		<thead>
			<tr>
				<th>알바생코드</th>
				<th>이름</th>
				<th>주소</th>
				<th>연락처</th>
			</tr>
		</thead>
		
		<tbody>
			<%
				//simple클래스에서 전역으로 선언해준 맵 가져오기
				//맵의 값들을 for문으로 하나하나 찍어주기
				//주석달기 
				Map<String,AlbasengVO> alba = (Map<String,AlbasengVO>)getServletContext().getAttribute("albasengs");
				for(Entry<String, AlbasengVO> entry:alba.entrySet()){
					%>
					<tr>
						<td><%=entry.getKey() %></td>
						<td><%=entry.getValue().getName() %></td>
						<td><%=entry.getValue().getAddress() %></td>
						<td><%=entry.getValue().getTel() %></td>
					</tr>
					<% 
				}
			%>
		</tbody>
	</table>
</body>
</html>