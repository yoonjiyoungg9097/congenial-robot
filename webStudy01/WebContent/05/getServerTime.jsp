<%@page import="java.util.Objects"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%!
	String marshalling(Map<String, Object> originalData){//마샬링의 타켓은  map 그 결과 문자열이 만들어짐
		StringBuffer result = new StringBuffer();//스트링버퍼 객체 생성
		//자바 컬렉션 프레임워크(collection framework) : 다수의 데이터를 쉽고 효과적으로 처리할 수 있는 표준화된 방법을 제공하는 클래스의 집합을 의미합니다
		//이 프레임워크들은 자바의 인터페이스를 사용하여 구현한다 (List인터페이스, Set인터페이스, Map인터페이스)
		//Iterator는 자바의 컬렉션 프레임웍에서 컬렉션에 저장되어 있는 요소들을 읽어오는 방법을 표중화 하였는데 그 중 하나가 Iterator이다.
		//iterator를 사용할 수 없는 컬렉션인 Map에서 iterator를 사용하려면 2가지 키워드가 있다 - Map.keyset(), Map.entrySet()
		result.append("{");
		String jsonPattern = "\"%s\":\"%s\",";
		for(Entry<String, Object> entry:originalData.entrySet()){
			String propName = entry.getKey();
// 			String propValue = entry.getValue().toString();
			String propValue = Objects.toString(entry.getValue(), "");
			result.append(
				String.format(jsonPattern, propName, propValue)
					);
		}
		//마지막 콤마 없애기 위해
		int lastIndex = result.lastIndexOf(",");
		result.deleteCharAt(lastIndex);
		
		result.append("}");
		return result.toString();
	}
%> 
<%--
	매 1초마다 현재 서버의 시각을 JSON 형태로 전송.
	응답으로 전송될 JSON 객체 내s는
	현재 서버의 시각을  의미하는 serverTime 이라는 프로퍼티가 있다.
--%>
<%
	response.setHeader("Refresh", "1"); //1초마다 갱신
	Date now = new Date();
	Map<String, Object> javaObject = new LinkedHashMap<>(); //마샬링의 대상이 되는 부분
	javaObject.put("serverTime", now);
	String json = marshalling(javaObject); 
	out.print(json);
%>

<%-- {
	"serverTime" : "<%= now%>"
} --%>
