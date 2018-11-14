<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>06/applicationDesc.jsp</title>
</head>
<body>
	<h4>ServletContext</h4>
	<pre>
		<%=application.hashCode() %>
		<a href="<%=request.getContextPath()%>/06/implicitObject.jsp">implicitObject.jsp로 이동</a>
		<a href="<%=request.getContextPath()%>/desc">DescriptionServlet으로 가기</a>
		: 컨텍스트와 해당 컨텍스트를 운영(관리)중인 서버에 대한 정보를 가진 객체.
		
		1. 서버에 대한 정보 획득
			<%-- <%=application == getServletContext() %> --%>
			<%=application.getServerInfo() %>
			<%=application.getMajorVersion() %>.<%=application.getMinorVersion() %>
			<%=application.getMimeType("test.hwp") %><!-- .startsWith() -->
			
		2. 로그 기록(logging)
			<%
				application.log("명시적으로 기록한 로그 메시지");
			%>
			
		3. 컨텍스트 파라미터(어플리케이션의 초기화 파라미터) 획득 : 컨텍스트는 파라미터를 받을자 컨텍스트는 어플리케이션을 통해 들어오는 데이터를 의미?
			<%=application.getInitParameter("param1") %> <!-- web.xml -->
			<%
				Enumeration<String> names = application.getInitParameterNames();
				while(names.hasMoreElements()){
					out.println(application.getInitParameter(names.nextElement()));
				}
			%>
		4. 웹리소스를 획득 (webContent아래에 있는것들) : http://localhost/webStudy01/images/Penguins.jpg
			<%=application.getRealPath("/images/Penguins.jpg")%> <!-- 서버사이드 경로방식 --> 
			
			<%
// 				File File = new File(fileSystemPath);
// 				out.println(file.getAbsolutePath());
				String fileSystemPath = application.getRealPath("/images/Penguins.jpg");
				File srcFile = new File(fileSystemPath);
				
				File targetFolder = new File(application.getRealPath("/06"));
				File targetFile = new File(targetFolder, srcFile.getName());
				System.out.println(targetFile.exists());
				
				int pointer = -1;
				byte[] buffer = new byte[1024];
				try(
// 					FileInputStream fis = new FileInputStream(srcFile);
					InputStream fis = application.getResourceAsStream("/images/Penguins.jpg");
					FileOutputStream fos = new FileOutputStream(targetFile);
				){
					while((pointer = fis.read(buffer))!=-1){
						fos.write(buffer, 0, pointer);
					}
				}
				System.out.println(targetFile.exists());
				
			%>
	</pre>
	<img src="<%=request.getContextPath() %>/06/Penguins.jpg"/>
	<img src="<%=request.getContextPath() %>/images/Penguins.jpg"/>
</body>
</html>














