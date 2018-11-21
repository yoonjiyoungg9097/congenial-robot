<%@page import="kr.or.ddit.ServiceResult"%>
<%@page import="kr.or.ddit.member.service.MemberServiceImpl"%>
<%@page import="kr.or.ddit.member.service.IMemberService"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="kr.or.ddit.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 1. 파라미터 확보(특수문자 고려) -->
<!-- 2. 검증(검증룰 : member 테이블의 스키마를 확인, 필수데이터 검증은 반드시!!) -->
<!-- 3. 통과 -->
<!-- 	1) 로직객체와의 의존관계 형성 -->
<!-- 	2) 로직 선택(registMember) -->
<!-- 		PKDUPLICATED : memberForm.jsp 로 이동, foward(메시지, 기존 입력데이터 공유) -->
<!-- 		OK : memberList.jsp로 이동, redirect -->
<!-- 		FAILED : memberForm.jsp 로 이동, forward(기존 입력데이터, 메시지 공유) -->
<!-- 4. 불통 -->
<!-- 	memberForm.jsp 로 이동, forward(기존 입력데이터, 검증 결과 메시지 공유) -->
<%
	request.setCharacterEncoding("UTF-8");
	MemberVO member = new MemberVO();
	member.setMem_id(request.getParameter("mem_id"));
	member.setMem_pass(request.getParameter("mem_pw"));
	member.setMem_name(request.getParameter("mem_name"));
	member.setMem_regno1(request.getParameter("mem_regno1"));
	member.setMem_regno2(request.getParameter("mem_regno2"));
	member.setMem_bir(request.getParameter("mem_bir"));
	member.setMem_zip(request.getParameter("mem_zip"));
	member.setMem_add1(request.getParameter("mem_add1"));
	member.setMem_add2(request.getParameter("mem_add2"));
	member.setMem_hometel(request.getParameter("mem_hometel"));
	member.setMem_comtel(request.getParameter("mem_comtel"));
	member.setMem_hp(request.getParameter("mem_hp"));
	member.setMem_mail(request.getParameter("mem_mail"));
	member.setMem_job(request.getParameter("mem_job"));
	member.setMem_like(request.getParameter("mem_like"));
	member.setMem_memorial(request.getParameter("mem_memorial"));
	member.setMem_memorialday(request.getParameter("mem_memorialday"));
	
	boolean result = true;
	Map<String, String> error = new LinkedHashMap<>();
	if(StringUtils.isBlank(member.getMem_id())){
		result = false;
		error.put("id", "아이디 누락");
	}
	if(StringUtils.isBlank(member.getMem_pass())){
		result = false;
		error.put("pw", "비밀번호 누락");
	}
	if(StringUtils.isBlank(member.getMem_name())){
		result = false;
		error.put("name", "이름 누락");
	}
	if(true){
		IMemberService service = new MemberServiceImpl();
		ServiceResult rs = service.registMember(member);
		if(rs==ServiceResult.OK){
			response.sendRedirect(request.getContextPath()+"/member/memberList.jsp");
		}
	}
	
%>