<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	public Map<String, String[]> singerMap = new LinkedHashMap<>();
{
	singerMap.put("B001", new String[]{"Jennie", "/WEB-INF/blackpink/jennie.jsp"});	
	singerMap.put("B002", new String[]{"Jisoo", "/WEB-INF/blackpink/jisoo.jsp"});	
	singerMap.put("B003", new String[]{"Lisa", "/WEB-INF/blackpink/lisa.jsp"});	
	singerMap.put("B004", new String[]{"Rose", "/WEB-INF/blackpink/rose.jsp"});	
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>05/blackpinkForm.jsp</title>
<script>
	function changemember(){
		document.singerForm.submit();
	}
</script>
</head>
<body>
	<form name="singerForm" action="<%=request.getContextPath() %>/05/getBlackPink.jsp">
		<select name="member" onchange="changemember()">
			<option value="">멤버 선택</option>
<!-- 			<option value="B001" >Jennie</option> -->
<!-- 			<option value="B002" >Jisoo</option> -->
<!-- 			<option value="B003" >Lisa</option> -->
<!-- 			<option value="B004" >Rose</option> 지영언니 화이팅 : 김정희!!!! -->

			<%
				for(Entry<String, String[]> blackpink : singerMap.entrySet()){
					out.println(String.format(
							"<option value='%s' >%s</option>", blackpink.getKey(),blackpink.getValue()[0]));
				}
			%>
		</select>
	</form>
</body>
</html>