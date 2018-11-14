<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>03/resourceIdentify.jsp</title>
</head>
<body>
	<h4>자원의 식별</h4>
<pre>
	식별하고 싶은 자원의 종류
	1. 파일 시스템 자원 : 파일시스템 경로를 통한 식별
	2. 클래스패스(classpath) 자원 : classpath 기준 경로를 통한 식별
	3. 웹리소스 식별
		URI(Uniform Resource Indentifier)
			URL(Uniform Resource Locator)
			URN(Uniform Resource Name)
			URC(Uniform Resource Content)
		URL
		scheme안에는 프로토콜 네임
		scheme://domain:port/context명/depth1/depth2.../resource_name
		
		절대경로 (ex 펭귄이미지) : http://localhost:80/webStudy01/images/Penguins.jpg
			client-side : /webStudy01/images/Penguins.jpg 먼저 contextPath부터 나와야 한다
			              <%-- "<%=request.getContextPath() %>/images/Penguins.jpg" --%>
			server-side : /desc (contextPath를 제외한 이후 경로 표기) 
		상대경로 : 경로를 판단할 기준 위치 : 현재 브라우저의 주소값
		      : ../images/Penguins.jpg
</pre>
	<!-- <img src="/webStudy01/images/Penguins.jpg" /> -->
	<img src="<%=request.getContextPath() %>/images/Penguins.jpg" />
	<img src="http://localhost:80/webStudy01/images/Penguins.jpg" />
	<img src="../images/Penguins.jpg">
</body>
</html>