package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.dao.IMemberDAO;
import kr.or.ddit.member.dao.MemberDAOImpl;
import kr.or.ddit.vo.MemberVO;

public class MemberServiceImpl implements IMemberService {
	// 의존 객체를 직접 생성하는 방식 : 결합력 최상 실행코드의 캡슐화
	IMemberDAO memberDAO = new MemberDAOImpl();
	
	@Override
	public ServiceResult registMember(MemberVO member) {
		ServiceResult result = null;
		 if(memberDAO.selectMember(member.getMem_id())==null) {
			 int rowCnt = memberDAO.insertMember(member);
			 if(rowCnt>0) {
				 result = ServiceResult.OK;
			 }else {
				 result = ServiceResult.FAILED;
			 }
		 }else {
			result = ServiceResult.PKDUPLICATED; 
		 }
		 return result;
	}

	@Override
	public List<MemberVO> retrieveMemberList() {
		List<MemberVO> memberList = memberDAO.selectMemberList();
		return memberList;
	}

	@Override
	public MemberVO retrieveMember(String mem_id) {
		MemberVO member = memberDAO.selectMember(mem_id);
		return member;
	}

	@Override
	public ServiceResult modifyMember(MemberVO member) {
		return null;
	}

	@Override
	public ServiceResult removeMember(MemberVO member) {
		return null;
	}

}
