<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 1. 파라미터 확보 -->
<!-- 2. 검증 (필수 데이터 검증, 유효데이터 검증 - Map에 그 값이 파라미터로 넘어왔는지) -->
<!-- 3. 불통 -->
<!-- 	1) 필수데이터 누락 : 400 -->
<!-- 	2) 우리가 관리하지 않는 멤버를 요구한 경우 : 404 -->
<!-- 4. 통과 -->
<!-- 	이동(맵에 있는 개인 페이지, 클라이언트가 멤버 개인페이지의 주소를 모르도록.) -->
<!-- 	이동(맵에 있는 개인 페이지, getBlackPink에서 원본 요청을 모두 처리했을 경우, UI 페이지로 이동할때 ) -->
<%!
	public Map<String, String[]> singerMap = new LinkedHashMap<>();
{
	singerMap.put("B001", new String[]{"Jennie", "/WEB-INF/blackpink/jennie.jsp"});	
	singerMap.put("B002", new String[]{"Jisoo", "/WEB-INF/blackpink/jisoo.jsp"});	
	singerMap.put("B003", new String[]{"Lisa", "/WEB-INF/blackpink/lisa.jsp"});	
	singerMap.put("B004", new String[]{"Rose", "/WEB-INF/blackpink/rose.jsp"});	
}
%>
<%
	// selectbox에서 선택한 거 가져오기
	String Member = request.getParameter("member");
// 	String goPage = null;
// 	boolean result = true;
	int status = 0;

    //가져온값을 검증
	if(Member==null || Member.trim().length()==0){
// 		goPage = "/05/blackpinkForm.jsp";
// 		result = false;
		status = HttpServletResponse.SC_BAD_REQUEST;
	}else if(!singerMap.containsKey(Member)){//존재하는 키값인지 아닌지??
		status = HttpServletResponse.SC_NOT_FOUND;
	}
    
    if(status!=0){
    	response.sendError(status);
    	return;
    }
    
    String[] value = singerMap.get(Member);
	String goPage = value[1];
	RequestDispatcher rd = request.getRequestDispatcher(goPage);
	rd.forward(request, response);
// 	response.sendRedirect(request.getContextPath() + goPage);
	


// 	if(result){
// 		for(S:){
			
// 		}
// 		RequestDispatcher rd = request.getRequestDispatcher(goPage);
// 		rd.include(request, response);
// 	}
	
%>

