<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>06/implicitObject.jsp</title>
</head>
<body>
	<h4>기본 객체(내장 객체)</h4>
	<pre>
		** pageContext(PageContext) : JSP 페이지와 관련된 *모든 정보*를 가진 객체. 그 모든것은 아래와 같은 것들을 포함하고 있다 전체 기본객체를 통틀어서 제일먼저
		request(HttpServletRequest) : 요청과 클라이언트의 정보를 캡슐화한 객체
		response(HttpServletResponse) : 응답과 관련된 모든 정보를 캡슐화한 객체
		out(JSPWriter) : 출력버퍼에 데이터를 기록하거나 버퍼를 제어하기 위해 사용되는 출력 스트림	writer는 출력 스트림(문자 스트림)
		session(HttpSession) : 한세션 내에서 발생하는 모든 정보를 캡슐화한 객체 		시간(웹)/통로
		  -> 하나의 application시작할때 부터 종료할때까지 기간을 session? 한명의 유저가 브라우저에서 요청을 날리면 세션시작 그 유저가 이용하다가 사이트 떠날때까지를 한 세션
		  	브라우저가 대상이 되어 생성된다 사람은 한명이라도 브라우저가 2개이상이면 세션도 2개이상
		application(ServletContext) : 컨텍스트(어플리케이션)와 서버에 대한 정보를 가진 객체
		<%=application.hashCode() %>
		config(ServletConfig) : 서블릿 등록과 관련된 정보를 가진 객체	컴파일 -> 등록 -> 매핑 
		page(Object) : 현재 JSP 페이지에 대한 레퍼런스
		 : was가 만들어 놓은 싱글톤 객체? 오브젝트로 선언한 이유 어떤 jsp페이지 공통된 참조를 해야되기 때문에 this와 같은 의미 
		exception(Throwable) : 발생한 예외에 대한 정보를 가진 객체
			: 예외(에러)가 발생한 경우, 에러를 처리하는 페이지에서 사용됨
			(page 지시자의 isErrorPage로 활성화함.)
		<%=exception%>
	</pre>
</body>
</html>