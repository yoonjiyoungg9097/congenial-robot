<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <meta http-equiv="Refresh" content="3;url=http://www.naver.com"> -->
<!-- 현재 페이지가 공사중이니 임시페이지로 자동으로 넘어갈때 -->
<title>04/autoRequest.jsp</title>
<script src="<%=request.getContextPath()%>/js/jquery-3.3.1.min.js"></script>
</head>
<body>
	<h4>자동 요청을 발생시키는 방법</h4>
	<h4>
		<span id="countArea"></span>초 뒤에 네이버로 이동합니다
	</h4>
	<!-- 	getServerTime.jsp쪽으로 1초마다 비동기 요청을 발생시키고, -->
	<!-- 	JSON 형태로 전송된 응답데이터에서 serverTime 프로퍼티로 부터 확보. -->
	<!-- 	severClock span태그에 현재 서버의 시각이 갱신되도록 -->
	<pre>
		1. 서버 사이드
			<%
		// 				response.setIntHeader("Refresh", 1); //1은 주기를 의미하는데 int로 썼기 때문에 세컨드로 설정
	%>
			현재 서버의 시간 : <%-- <%=new Date()%> --%> <span id="severClock"></span>
		2. 클라이언트 사이드
			HTML : meta 태그 이용
			Javascript : 스케쥴링 함수 이용 Inteval과 timeout??
	</pre>

	<script type="text/javascript">
// 	var wait = 1;
// 	var count = wait;
// 	var spanTag = document.getElementById("countArea");
// 	setInterval(function() {//콜백함수
// 		count--;
// 		spanTag.innerHTML = count;
// 	}, 1000);
// 	setTimeout(function() {
// 		location.reload(); /* 현재입력창에 있는 주소를 다시 사용하겠다는 의미  계속 홈페이지 새로고침이 된다*/ 
// // 		location.href="http://www.naver.com";
// 	}, wait*1000);

		var severClock = $("#severClock");
		setInterval(function(){
			$.ajax({
				url : "<%= request.getContextPath()%>/05/getServerTime.jsp", 
				dataType : "json", //Accept, AcceptContent-Type
				success : function(resp) {//resp는 json객체(resp는 map) servertime이라는 프로퍼티를 포함 
					severClock.html(resp.serverTime);
				},
				error : function(resp) {
					console.log(resp.status +", "+ resp.responseText);
				}
			});
		}, 1000);
	</script>
</body>
</html>