<%@page import="java.util.Map"%>
<%@page import="kr.or.ddit.vo.AlbasengVO"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="kr.or.ddit.web.SimpleFormProcessServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>05/albaList.jsp</title>
</head>
<body>
	<table>
		<thead>
			<tr>
				<th>알바생코드</th>
				<th>이름</th>
				<th>주소</th>
				<th>연락처</th>
			</tr>
		</thead>
		
		<tbody>
			<%
				//simpleForm클래스에서 전역으로 선언해준 맵 가져오기
				//맵의 값들을 for문으로 하나하나 찍어주기
				//추가에 성공했을때 알바생코드, 이름, 주소, 연락처를 albaList에 추가해준다
				//getServletContext().getAttribute("albasengs");은 Object형이기 때문에 Map에 담아줄때 다운캐스팅을 해주고 담아준다
				//getServletContext().getAttribute("albasengs")로 param-name이 albasengs 객체를 불러와서 형변환을 한 다음 사용하고 있다.
				Map<String,AlbasengVO> alba = (Map<String,AlbasengVO>)getServletContext().getAttribute("albasengs");
				
				
				//자바에서 컬렉션 프레임워크란 다수의 데이터를 쉽고 효과적으로 처리할 수 있는 표준화된 방법을 제공하는 클래스의 집합(List,Set,Map)
				//Iterator는 자바의 컬렉션 프레임웍에서 컬렉션에 저장되어 있는 요소들을 읽어오는 방법을 표중화 하였는데 그 중 하나가 Iterator이다.
				//iterator를 사용할 수 없는 컬렉션인 Map에서 iterator를 사용하려면 2가지 키워드가 있다 - Map.keyset(), Map.entrySet()
				for(Entry<String, AlbasengVO> entry:alba.entrySet()){
					%>
					<tr>
						<td><%=entry.getKey() %></td>
						<td><%=entry.getValue().getName() %></td>
						<td><%=entry.getValue().getAddress() %></td>
						<td><%=entry.getValue().getTel() %></td>
					</tr>
					<% 
				}
			%>
		</tbody>
	</table>
</body>
</html>