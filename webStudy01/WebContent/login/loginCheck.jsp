<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	String id = request.getParameter("mem_id");
	String pass = request.getParameter("mem_pass");
	String goPage = null; //페이지 이동
	boolean redirect = false; //이동방식 구분해주기 위해서
	
	if(id==null || id.trim().length()==0 || pass==null || pass.trim().length()==0){
// 		goPage = "/login/loginForm.jsp?error=1";
		goPage = "/login/loginForm.jsp";
		redirect = true;
// 		session.setAttribute("error", 1); //error는 이름 그에 해당하는 값=1
		session.setAttribute("message", "아이디나 비번 누락");
	}else{
		if(id.equals(pass)){
			goPage = "/"; //클라이언트 사이드
			redirect = true;
			session.setAttribute("authMember", id);
		}else{//비번이 틀림
// 			goPage = "/login/loginForm.jsp?error=1";
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
