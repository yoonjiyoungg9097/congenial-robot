<%@page import="kr.or.ddit.utils.CookieUtil"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.Objects"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 	String failId = request.getParameter("mem_id");
	String savedId = new CookieUtil(request).getCookieValue("idCookie");
// 	String error = request.getParameter("error");
// 	Integer error = (Integer)session.getAttribute("error");
	String message = (String)session.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login/loginForm.jsp</title>
<script type="text/javascript">
	<%
// 		if(error!= null && error.trim().length()>0){//문자열일 경우
		if(StringUtils.isNotBlank(message)){//메세지가 있을때
	%>
			alert("<%=message%>");
	<%
		session.removeAttribute("message");
		}
	%>
	
	<%
		
		String id = new CookieUtil(request).getCookieValue("idCookie");
		
	%>
// 	"M".equals(albaVO.getGender())?"checked":""
</script>
</head>
<body>
	<!-- 모든 인증처리는 post방식 get방식은 기본적으로 해킹된 정보라고 인식한다 -->
	<form action="<%=request.getContextPath() %>/login/loginCheck.jsp" method="post"> <!-- 이 주소는 브라우저가 사용 클라이언트 사이드 그래서 contextpath가 필요로 하다 -->
		<ul>
			<li>
				아이디 : <input type="text" name="mem_id" value="<%=Objects.toString(savedId, "") %>"/>
				<label>
				<input type="checkbox" name="idChecked" value="idSaved" <%=StringUtils.isNotBlank(savedId) ?"checked":""%> />아이디 기억하기
				</label>
			</li>
			<li>
				비밀번호 : <input type="password" name="mem_pass" value="" />
				<input type="submit" value="로그인" />
			</li>
		</ul>
	</form>
</body>
</html>