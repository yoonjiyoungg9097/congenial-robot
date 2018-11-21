<%@page import="kr.or.ddit.ServiceResult"%>
<%@page import="kr.or.ddit.member.service.AuthenticateServiceImpl"%>
<%@page import="kr.or.ddit.vo.MemberVO"%>
<%@page import="kr.or.ddit.member.service.IAuthenticateService"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="kr.or.ddit.db.ConnectionFactory"%>
<%@page import="java.sql.Connection"%>
<%@page import="kr.or.ddit.utils.CookieUtil.TextType"%>
<%@page import="kr.or.ddit.utils.CookieUtil"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 
<%!
	public boolean authenticate(String mem_id, String mem_pass) throws SQLException{
		boolean result = false;
		StringBuffer sql = new StringBuffer();
		sql.append(" select mem_name from member where mem_id = ? and mem_pass = ? ");
		try(
			Connection conn = ConnectionFactory.getConnection(); //ConnectionFactory 클래스 만들어주기
// 			Statement stmt =  conn.createStatement();
			PreparedStatement pstmt = conn.prepareStatement(sql.toString());
	    ){
// 			sql.append(" select mem_name from member where mem_id='"+mem_id+"' and mem_pass='"+mem_pass+"'");
			pstmt.setString(1, mem_id); //자동으로 쿼테이션
			pstmt.setString(2, mem_pass);
			
			ResultSet rs = pstmt.executeQuery(sql.toString());
			if(rs.next()){
				result = true;	
			}
		}
		return result;
	}

--%>    
<!-- 1. 파라미터 확보 -->
<!-- 2. 검증(필수 데이터 - 아이디와 비밀번호 누락되면 안됨) -->
<!-- 3. 불통 -->
<!-- 	이동 (도착지 - loginForm.jsp, 기존에 입력했던 아이디를 그대로 전달할 수 있는 방식.) -->
<!-- 4. 통과 -->
<!-- 	4-1. 인증(아이디==비번) -->
<!-- 		4-2. 인증 성공 : 웰컴 페이지로 이동 (원본 요청을 제거하고 이동)  -->
<!-- 		인증성공은 요청에 대한 처리가 완전히 끝나서 그 안에 원본요청은 가지고 있지 않아도 된다 -->
<!-- 		4-3. 인증 실패 : 이동 (도착지 - loginForm.jsp, 기존에 입력했던 아이디를 그대로 전달할 수 있는 방식.) -->
<%
	//아이디나 비밀번호에 특수문자라 있을 경우 처리해주는 부분
	request.setCharacterEncoding("UTF-8");
	String mem_id = request.getParameter("mem_id");
	String mem_pass = request.getParameter("mem_pass");
	String idChecked = request.getParameter("idChecked");
	String goPage = null; //페이지 이동
	boolean redirect = false; //이동방식 구분해주기 위해서
	
	if(mem_id==null || mem_id.trim().length()==0 || mem_pass==null || mem_pass.trim().length()==0){
// 		goPage = "/login/loginForm.jsp?error=1";
		goPage = "/login/loginForm.jsp";
		redirect = true;
// 		session.setAttribute("error", 1); //error는 이름 그에 해당하는 값=1
		session.setAttribute("message", "아이디나 비번 누락");
	}else{
// 		if(id.equals(pass)){
		IAuthenticateService service = new AuthenticateServiceImpl();
		Object result = service.authenticate(new MemberVO(mem_id, mem_pass));
		if(result instanceof MemberVO){//result 가 MemberVO타입인지 아닌지
			goPage = "/"; //클라이언트 사이드
			redirect = true;
			int maxAge = 0;
			Cookie cookie =null;
			session.setAttribute("authMember", result);
			if("idSaved".equals(idChecked)){
				maxAge = 60*60*24*7;
			}
			Cookie idCookie = CookieUtil.createCookie("idCookie", mem_id, request.getContextPath(), TextType.PATH, maxAge);
			response.addCookie(idCookie);
// 			if(StringUtils.isNotBlank(request.getParameter("idChecked"))){
// 				maxAge = 60*60*24*7;
// 				cookie = CookieUtil.createCookie("idCookie", mem_id, request.getContextPath(), TextType.PATH, maxAge);
// 			}else {
// 				cookie = CookieUtil.createCookie("idCookie", mem_id, request.getContextPath(), TextType.PATH, maxAge);
// 			}
// 			response.addCookie(cookie);
		}else if(result == ServiceResult.PKNOTFOUND){//비번이 틀림
// 			goPage = "/login/loginForm.jsp?error=1";
			goPage = "/login/loginForm.jsp";
			redirect = true;
// 			session.setAttribute("error", 1);
			session.setAttribute("message", "존재하지 않는 회원");
		}else{
			goPage = "/login/loginForm.jsp";
			redirect = true;
// 			session.setAttribute("error", 1);
			session.setAttribute("message", "비번 오류로 인증 실패");
			}
	}
	
	if(redirect){
		response.sendRedirect(request.getContextPath() + goPage);
	}else{
		RequestDispatcher rd = request.getRequestDispatcher(goPage);
		rd.forward(request, response);
	}
	
%>
