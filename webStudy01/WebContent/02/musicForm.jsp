<%@page import="java.io.FilenameFilter"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	File folder = (File)application.getAttribute("contentFolder"); //Object형을 다운캐스팅
// 	String contentFolder = application.getInitParameter("contentFolder");
// 	File folder = new File(contentFolder);
// 	folder.list(); //모든 파일을 다 가져옴 이미지 동영상도
	String[] names = folder.list((dir, name)->{
// 		application.getMimeType(name).startsWith("text");
// 		return name.endsWith("txt");});
		return application.getMimeType(name).startsWith("text");});
%>

<script type="text/javascript">
	$(function(){
		var songForm = $("#songForm"); //왜 제일 위쪽에 해주는지?
		var resultArea = $("#resultArea");
		$("[name='music']").on("change", function() {
			var song = $(this).val();
			var url = songForm.attr("action");
			var method = songForm.attr("method");
			$.ajax({
				url : url,
				method : method,
// 				data : "song="+song, //세그먼트가 여러개가 되면 쓰기 힘들기 때문에
				data : {
					song:song
				},
				dataType : "html", // accept : text/html
				success : function(resp) {
					resultArea.html(resp);
				},
				error : function(resp) {
					console.log(resp.responseText); //클라이언트의 콘솔
				}
			});
		});
	});
</script>
<!-- action="/song"은 절대경로 -->
	<form id="songForm" action="<%=request.getContextPath() %>/song" method="post"> 
		<select name="music">
			<option value="">가사 선택</option>
			<%
				for(String name:names){
					out.println(String.format(
							"<option>%s</option>",name
							));
				}
			%>
		</select>
		<input type="hidden" value="lyricsProcess" name="command">
	</form>
	
	<div id="resultArea"></div>
