<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>06/sessionDesc.jsp</title>
</head>
<body>
	<h4>HttpSession</h4>
	<pre>
		: 한 세션 내의 모든 정보를 가진 객체.
		세션?? (시간과 통로) 클라이언트에 의해 생성된다
			통로 : 클라이언트와 서버사이에 유효한 데이터가 전송될 수 있는 연결.
			시간 : 클라이언트가 어플리케이션을 사용하기 시작한 순간부터
				  사용 종료 이벤트를 발생시킬 때까지의 시간.
				  
			사용 시작 : 클라이언트의 브라우저로부터 최초의 요청이 발생했을 때 -> session 객체 생성 		시작부터 종료까지 세션의 라이프사이클
					**세션의 대상은 브라우저 (사람이 아님)
					예를 들어 내가 지금 크롬과 파이어폭스로 요청을 하고 있을때 사람은 한명이지만 브라우저는 두개이다
			사용 종료 : 
				1) 명시적인 로그아웃
				2) 세션 만료시간(30분) 이내에 새로운 요청이 발생하지 않을때 세션생성 시점과 비교하는 것이 아니라 마지막 요청시간과 그 다음 요청 시간이 30분이상일때
				3) 브라우저를 완전히 종료한 경우
				
			세션 생성시점에 생성 아이디 : <%=session.getId() %>
<%-- 			<%=session. getCreationTime()%> --%>
			세션 생성 시점 : <%=new Date(session.getCreationTime()) %>
			마지막 접속 시간 : <%=new Date(session.getLastAccessedTime()) %>
			세션 만료 시간 : <%=session.getMaxInactiveInterval() %>
			<%
				session.setMaxInactiveInterval(4*60);
			%>
			세션 만료 시간 조정 후 : <%=session.getMaxInactiveInterval() %>
			<%-- <a href="?">쿠키 없는 상태에서 세션 유지</a> 현재페이지에서 요청을 시키는데 쿼리스트링 --%>
			<a href="sessionDesc.jsp;jsessionid=<%=session.getId()%>">쿠키 없는 상태에서 세션 유지</a> <%-- metrics변수? --%>
	</pre>
</body>
</html>