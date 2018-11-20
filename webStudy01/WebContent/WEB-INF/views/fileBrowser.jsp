<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(function() {
	    var fileForm = document.fileForm;
		$("#fileList>li").on("dblclick", function() {
			alert($(this).attr('value'));
			fileForm.path.value=$(this).attr('value');
			fileForm.name.value=$(this).text();
			fileForm.submit();

		});
	})
	
	
</script>
<title>fileBrowser.jsp(View)</title>
</head>
<body>

	<jsp:useBean id="file" class="java.util.ArrayList" scope="request" />
	<ul id="fileList">
		<%
			String pattern = "<li value=%s >%s</li>"; //파일의 list들을 보여줄 li들 
			for (Object name : file) {//위에서 만들어준 file의 값들이 Object형의 name변수에 쌓이게 된다
				File ss = (File) name; //값을 담아주 name을 File형으로 다운캐스팅해서 ss 변수에 담아준다
				//ss의 절대경로와 이름을 li의 %s라고 선언해준 부분에 값을 넣어준다
				out.println(String.format(pattern, ss.getAbsolutePath(), ss.getName()));
			}
		%>
	</ul>
	<form method="get" name="fileForm" >
	<input name="path" value="" type="hidden" />
	<input name="name" value="" type="hidden" />
	<input type="radio" name="option" value="delete"/>삭제
	<input type="radio" name="option" value="copy"/>복사
	<input type="radio" name="option" value="move"/>이동
	</form>
</body>
</html>