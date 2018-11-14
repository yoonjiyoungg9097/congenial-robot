<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	table{
		border: 1px solid black;
	}
</style>
</head>
<body>
<%
String minStr = request.getParameter("mindan");
String maxStr = request.getParameter("maxdan");
if(minStr == null||!minStr.matches("\\d")
		|| maxStr == null || !maxStr.matches("\\d")){
	response.sendError(400);
	return;
}
%>
<%-- <form action="<%=request.getContextPath() %>/02/numberTest.jsp"> --%>
<form>
	최소단 : <input type="number" name="mindan" value="<%=minStr%>"/>
	최대단 : <input type="number" name="maxdan" value="<%=maxStr%>"/>
	<input type="submit" value="구구단"/>
</form>
	<table>
		<% 
			int minDan = Integer.parseInt(minStr);
			int maxDan = Integer.parseInt(maxStr);
			
		
		String pattern = "%d * %d = %d";
		for(int dan=minDan; dan<=maxDan; dan++){
			%>
			<tr>
			<% 
			for(int gu=1; gu<=9; gu++){
				%>
				<td><%= String.format(pattern, dan, gu, (dan*gu))%></td>
				<% 
			}
			%>
			</tr>
			<% 
		}
		%>
	</table>
	<ul>
		<%
			for(int number=1; number<=50; number++){
				%>
				<li><%= number %></li>
				<%		
			}
		%>
	</ul>
</body>
</html>