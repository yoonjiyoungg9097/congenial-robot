<%@page import="kr.or.ddit.vo.MemberVO"%>
<%@page import="kr.or.ddit.web.modulize.ServiceType"%>
<%@page import="kr.or.ddit.web.modulize.Contents"%>
<%@page import="javafx.scene.control.Alert"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 	String command = request.getParameter("command");
// 	String urlAddress = "";
// 	if(StringUtils.isNotBlank(command)){//받아온 command즉 경로가 null이 아닐때
// 		Contents i = Contents.getContents(command);
// 		//enum과 같은 타입의 Contents 타입으로 그 안의 메소드인 getContents를 통해 받아오는 값을 담아준다
// 		urlAddress = i.getUrl();
// 	}

	MemberVO authMember = (MemberVO) session.getAttribute("authMember");
	String cmdParam = request.getParameter("command");
	int statusCode = 0;
	String includePage = null;
	if(StringUtils.isNotBlank(cmdParam)){
		try{
			ServiceType sType = ServiceType.valueOf(cmdParam.toUpperCase());
			includePage = sType.getServicePage();
		}catch(IllegalArgumentException e){//제공할 수 없는 서비스 현재 클라이언트가 찾고있는 서비스를 가지고 있지 않을때
			statusCode = HttpServletResponse.SC_NOT_FOUND;
		}
	}
	
	if(statusCode!=0){
		response.sendError(statusCode);
		return;
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/index.jsp</title>
<link href="<%=request.getContextPath() %>/css/main.css" rel="stylesheet">
<script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
</head>
<body >
	<div id="top">
		<%-- <%
			pageContext.include("");
		%> --%>
		<jsp:include page="/includee/header.jsp" /> <!-- 서버 사이드 -->
<%-- 		<iframe src="<%=request.getContextPath() %>/includee/header.jsp"></iframe> <!-- 클라이언트 사이드 --> --%>
	</div>
	
	<div id="left">
		<jsp:include page="/includee/left.jsp" /> 
<%-- 		<iframe src="<%=request.getContextPath() %>/includee/left.jsp"></iframe> --%>
	</div>
	

	<div id="body" style="overflow-y: auto">	
		
		<%
		if(StringUtils.isNotBlank(includePage)){
// 			pageContext.include(includePage);
		%>
			<jsp:include page="<%=includePage %>"></jsp:include>
		<% 
		}else{
			%>
			<h4>웰컴 페이지</h4>
			<pre>
				처음부터 웰컴 페이지로 접속하거나,
				로그인에 성공해서 웰컴 페이지로 접속하는 경우의 수가 있다.
		
				<%
					
					if(authMember!=null){
				%>
				<%=authMember.getMem_name() %>님 로그인상태, <a href="<%=request.getContextPath()%>/login/logout.jsp">로그아웃</a>
		
				<% 
					}else{
				%>
				<a href="<%=request.getContextPath()%>/login/loginForm.jsp">로그인하러 가기</a>
				<%
					}
				}
				%>
<%-- 	<%
		if(StringUtils.isNotBlank(urlAddress)){
	%>
			<jsp:include page="<%=urlAddress %>"></jsp:include>
	<% 	
		}else{
			
	
	%> --%>
	<%-- <h4>웰컴 페이지</h4>
	<pre>
		처음부터 웰컴 페이지로 접속하거나,
		로그인에 성공해서 웰컴 페이지로 접속하는 경우의 수가 있다.
		
		<%
			String id = (String)session.getAttribute("authMember");
			if(StringUtils.isNotBlank(id)){
		%>
		<%=id %>님 로그인상태, <a href="<%=request.getContextPath()%>/login/logout.jsp">로그아웃</a>
		
		<% 
			}else{
		%>
		<a href="<%=request.getContextPath()%>/login/loginForm.jsp">로그인하러 가기</a>
		<%
			}
		%> --%>
	</pre>
	</div>
	<div id="footer">
		<%
			pageContext.include("/includee/footer.jsp");
		%> 
<%-- 		<iframe src="<%=request.getContextPath() %>/includee/footer.jsp"></iframe> --%>
	</div>
</body>
</html>