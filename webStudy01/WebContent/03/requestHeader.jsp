<%@page import="java.util.Locale"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String lang = request.getParameter("lang");
	Locale currentLocale = request.getLocale();
	if(lang!=null && lang.trim().length()!=0){
		currentLocale = Locale.forLanguageTag(lang); //파라미터가 없으면 현재의 locale사용 파라미터가 있으면 그 파라미터의 locale
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>03/requestHeader.jsp</title>
<script type="text/javascript">
	function changeHandler() {
		document.langForm.submit(); //버튼이 없어도 전송시킬 수 있다
	}
</script>
<!-- <script
  src="https://code.jquery.com/jquery-3.3.1.min.js"
  integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
  crossorigin="anonymous"></script>
<script type="text/javascript">
	$(function() {
		
		$("#lang").on("change", function(){
			document.langForm.submit();
		});
	});
</script> -->
</head>
<body>
<%
	Locale[] locales = Locale.getAvailableLocales(); //사용가능한 모든 Locale들
%>
<form name="langForm"> <!-- action이 없으면 현재 브라우저 주소 -->
<select name="lang" onchange="changeHandler();">
	<option value="" >언어 선택</option> <!-- selected="selected" -->
	<%
		String optPattern = "<option value='%s' %s>%s</option>";
		for(Locale tmp:locales){
			String value = tmp.toLanguageTag(); // 옵션의 value
			String text = tmp.getDisplayLanguage(); //옵션의 text
			String selected = "";
			if(currentLocale.equals(tmp)){
				selected = "selected";
			}
			if(text!=null && text.trim().length()!=0){
				out.println(String.format(optPattern, value, selected, text));
			}
		}
	%>
</select>
</form>
<ul>
	<li>
		현재 사용자의 언어와 국가 정보
		: <%= request.getHeader("accept-language")%>
	</li>
	
	<li>
		<%
// 			ex) ko_KR : 로케일문자 언어_지역(국가)
			Locale locale = request.getLocale();
			String country = locale.getDisplayCountry(currentLocale);
			//서버사이드 코드 클라이언트가 일본어를 사용할 경우 이건 서버사이드기 때ㅑ문에 클라이언트가 읽기힘들다 getDisplayCountry(여기에 Local.언어  가 들어가줘야한다)
			String language = locale.getDisplayLanguage(currentLocale);
		%>
		Locale 객체 활용
		: <%= language%>, <%= country%>
	</li>
</ul>
	<table>
		<thead>
			<tr>
				<th>헤더명</th>
				<th>헤더값</th>
			</tr>
		</thead>
		<tbody>
			<%
				Enumeration<String> names = request.getHeaderNames();
				String pattern = "<tr><td>%s</td><td>%s</td></tr>";
				while(names.hasMoreElements()){
					String headerName = names.nextElement();
					String headerValue = request.getHeader(headerName);
					out.println(String.format(pattern, headerName, headerValue));
				}
			%>
		</tbody>
	</table>
</body>
</html>