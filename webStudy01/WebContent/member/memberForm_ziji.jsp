<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h4>회원 가입</h4>
<form action="<%= request.getContextPath()%>/member/memberInsert.jsp" method="post">
	<table>
		<tr>
			<th>회원아이디</th>
			<td>
				<input type="text" name="mem_id"/>
			</td>
		</tr>
		
		<tr>
			<th>회원 비밀번호</th>
			<td>
				<input type="password" name="mem_pw">
			</td>
		</tr>
		
		<tr>
			<th>회원  이름</th>
			<td>
				<input type="text" name="mem_name">
			</td>
		</tr>

		<tr>
			<th>회원  주민등록번호</th>
			<td>
				<input type="text" name="mem_regno1">-<input type="text" name="mem_regno2">
			</td>
		</tr>

		<tr>
			<th>회원  생일</th>
			<td>
				<input type="date" name="mem_bir">
			</td>
		</tr>

		<tr>
			<th>회원 우편번호</th>
			<td>
				<input type="text" name="mem_zip" placeholder="000-000">
			</td>
		</tr>

		<tr>
			<th>회원 주소</th>
			<td>
				<input type="text" name="mem_add1">
			</td>
		</tr>
	
		<tr>
			<th>상세 주소</th>
			<td>
				<input type="text" name="mem_add2">
			</td>
		</tr>
	
		<tr>
			<th>회원 집전화번호</th>
			<td>
				<input type="text" name="mem_hometel">
			</td>
		</tr>

		<tr>
			<th>회원 전화번호</th>
			<td>
				<input type="text" name="mem_comtel">
			</td>
		</tr>

		<tr>
			<th>회원 핸드폰번호</th>
			<td>
				<input type="text" name="mem_hp">
			</td>
		</tr>

		<tr>
			<th>회원 이메일</th>
			<td>
				<input type="text" name="mem_mail">
			</td>
		</tr>

		<tr>
			<th>회원 직업</th>
			<td>
				<input type="text" name="mem_job">
			</td>
		</tr>

		<tr>
			<th>회원 취미</th>
			<td>
				<input type="text" name="mem_like">
			</td>
		</tr>
		
		<tr>
			<th>회원 기념일</th>
			<td>
				<input type="text" name="mem_memorial">
			</td>
		</tr>

		<tr>
			<th>회원 기념일 날짜</th>
			<td>
				<input type="text" name="mem_memorialday">
			</td>
		</tr>
		
		<tr>
			<td colspan="2">
				<input type="submit" value="등록"/>
				<input type="reset" value="취소"/>
			</td>
		</tr>
	</table>
</form>
</body>
</html>