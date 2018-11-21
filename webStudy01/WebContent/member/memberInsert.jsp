<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Map"%>
<%@page import="kr.or.ddit.ServiceResult"%>
<%@page import="kr.or.ddit.member.service.MemberServiceImpl"%>
<%@page import="kr.or.ddit.member.service.IMemberService"%>
<%@page import="kr.or.ddit.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!private boolean validate(MemberVO member, Map<String, String> errors){
		boolean valid = true;
		if(StringUtils.isBlank(member.getMem_id())){ 
			valid=false; 
			errors.put("mem_id", "회원아이디 누락");
		}
		if(StringUtils.isBlank(member.getMem_pass())){ 
			valid=false; 
			errors.put("mem_pass", "비밀번호 누락");
		}
		if(StringUtils.isBlank(member.getMem_name())){ 
			valid=false; 
			errors.put("mem_name", "회원명 누락");
		}
		if(StringUtils.isNotBlank(member.getMem_bir())){
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
			// formatting : 특정 타입의 데이터를 일정 형식의 문자열로 변환. String
			// parsing : 일정한 형식의 문자열을 특정 타입의 데이터로 변환. Date
			try{
				formatter.parse(member.getMem_bir()); 
			}catch(ParseException e){//checked Exception
				valid = false;
				errors.put("mem_bir", "날짜 형식 확인");
			}
		}
		return valid;
	}%>
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
%>
<jsp:useBean id="member" class="kr.or.ddit.vo.MemberVO" scope="request" />
<%-- <jsp:setProperty property="mem_id" name="member" param="mem_id"/> --%>
<jsp:setProperty property="*" name="member" />
<%
	String goPage = null;
	boolean redirect = false;
	String message = null;
	Map<String, String> errors = new LinkedHashMap<>();
	request.setAttribute("errors", errors);
	boolean valid = validate(member, errors);
	System.err.println(errors.size());

	// 	if(errors.size()>0){
	if (valid) {
		IMemberService service = new MemberServiceImpl();
		ServiceResult result = service.registMember(member);
		switch (result) {
		case PKDUPLICATED:
			goPage = "/member/memberForm.jsp";
			message = "아이디 중복이니까 바꾸세요.";
			break;
		case FAILED:
			goPage = "/member/memberForm.jsp";
			message = "서버 오류로 인한 실패, 잠시 뒤에 다시 해주세요";
			break;
		case OK:
			goPage = "/member/memberList.jsp";
			redirect = true;
			break;
		}
		request.setAttribute("message", message);
	} else {
		goPage = "/member/memberForm.jsp";
	}
	if (redirect) {
		response.sendRedirect(request.getContextPath() + goPage);
	} else {
		RequestDispatcher rd = request.getRequestDispatcher(goPage);
		rd.forward(request, response);
	}
%>