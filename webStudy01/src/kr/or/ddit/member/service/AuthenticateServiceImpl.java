package kr.or.ddit.member.service;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.member.dao.IMemberDAO;
import kr.or.ddit.member.dao.MemberDAOImpl;
import kr.or.ddit.vo.MemberVO;

public class AuthenticateServiceImpl implements IAuthenticateService {
	IMemberDAO memberDAO = new MemberDAOImpl();
//	public static enum ServiceResult{PKNOTFOUND, INVALIDPASSWORD}
	
	@Override
	public Object authenticate(MemberVO member) {//MeberVO였던 반환타입을 Object로 변경
		Object result = null;
		MemberVO savedMember = memberDAO.selectMember(member.getMem_id());
		if(savedMember!=null) {
			if(savedMember.getMem_pass().equals(member.getMem_pass())) {
				result = savedMember;
			}else {
				result = ServiceResult.INVALIDPASSWORD;
			}
		}else {
			result = ServiceResult.PKNOTFOUND;
		}
		return result;
	}

}
