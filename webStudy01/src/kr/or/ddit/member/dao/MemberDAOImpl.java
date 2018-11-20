package kr.or.ddit.member.dao;

import java.sql.SQLException;

import com.ibatis.sqlmap.client.SqlMapClient;

import kr.or.ddit.db.ibatis.CustomSqlMapClientBuilder;
import kr.or.ddit.vo.MemberVO;

public class MemberDAOImpl implements IMemberDAO {

	SqlMapClient sqlMapClient = CustomSqlMapClientBuilder.getSqlMapClient(); //팩토리의 역할
	@Override
	public MemberVO selectMember(String mem_id) {
		try {
			MemberVO member = (MemberVO) sqlMapClient.queryForObject("Member.selectMember", mem_id);
			return member;
		}catch (SQLException e) {
			throw new RuntimeException(e);
		}
	}

}
