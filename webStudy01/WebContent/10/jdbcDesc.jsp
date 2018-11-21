<%@page import="kr.or.ddit.db.ConnectionFactory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.ddit.vo.DataBasePropertyVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>10/jdbcDesc.jsp</title>
</head>
<body>
	<h4>JDBC(Java DataBase Connectivity)</h4>
	<pre>
		데이터베이스 연결 프로밍 단계
		1. 드라이버 빌드패스에 추가
		2. 드라이버 클래스 로딩
		3. 연결 객체(Connection) 생성  ex)Connection conn =
		4. 쿼리 객체 생성 :내가 사용할 
			Statement  동적- 쿼리문을 미리 지정해주지 않음 ex) select * from member where 조건1,... 조건  n (사용자가 조건을 더 줄수있음 )
			PreparedStatement 정적-쿼리문에 들어갈 조건 등의 개수를 미리 정해주고 사용 ex) select * from member where mem_id=? and mem_pass =? (사용자가 임의로 추가 불가능)
			CallableStatement - 함수, 프로시져(절차적)
		5. 쿼리 실행(CRUD)
			ResultSet executeQuery : Select 
			int(실행에 영향을 받은 레코드수) executeUpdate : insert/update/delete (int몇개의 레코드가 인서트/업데이트/딜리트가 됬는지)     
		6. 결과 집합 사용  ResultSet - 커서형태릐 데이터
		7. 자원의 해제 : finally 블럭/ try~with~resource 구문   ex)conn.close rs.close
		<%--
			try(	
				close를 해줘야하는 객체를 이 구역(위드절)에 선언시 클로즈를 생략해도 됨
				finaliy 생략가능 < 
			 )
				{
				}
			catch(){
			}finaliy{
				conn.close
				rs.closr
			}
			ㄹ
		--%>
		<% 
			
				String[] headers = null; // 컬럼의 이름 
				List<DataBasePropertyVO> dataList = null; //레코드의 값
		    try(
				Connection conn = ConnectionFactory.getConnection(); //ConnectionFactory 클래스 만들어주기
				Statement stmt =  conn.createStatement();
		    ){
				//out.print(conn.getClass());
				StringBuffer sql = new StringBuffer();
// 				String s= sql.toString(); 스트링버퍼를 스트링으로 해주려면 toString메서드를 사용해야함!
				sql.append(" select property_name, property_value, description "); 
				sql.append(" from database_properties ");
				ResultSet rs = stmt.executeQuery(sql.toString());//디비에 쿼리문실행후 값 저장
			
				ResultSetMetaData rsmd = rs.getMetaData(); // 컬러명을가져오기위한 방법
				
				headers = new String[rsmd.getColumnCount()];//컬럼의 개수를 받아와 배열의 크기를 지정해주기 위해 
				for(int idx=1; idx<=rsmd.getColumnCount(); idx++){
					headers[idx-1] = rsmd.getColumnName(idx);
				}//java의 배열,문자열등의 인덱스는 0부터 시작하지만 오라클은 1부터 시작함 
				dataList = new ArrayList<>();//
				while(rs.next()){//pointer를 하나씩 아래로 움직여주기 위해서
					//레코드 한건 == VO
					DataBasePropertyVO vo = new DataBasePropertyVO();//담기위해서 새로운 주소값 생성 
// 					String property_name = rs.getString(1);
// 					String property_value = rs.getString(2);
// 					String description = rs.getString(3);//요기까지 설명함
					vo.setProperty_name(rs.getString("property_name"));
					vo.setProperty_value(rs.getString("property_value"));
					vo.setDescription(rs.getString("description"));
					dataList.add(vo);
				} // while end
		    } // try block end
		%>
	</pre>
	
	<table>
		<thead>
			<tr>
				<%
					for(String head:headers){
						%>
						<th><%=head %></th>
						<%
					}
				%>
			</tr>
		</thead>
		<tbody>
			<%
				for(DataBasePropertyVO vo : dataList){
					%>
					<tr>
						<td><%=vo.getProperty_name() %></td>
						<td><%=vo.getProperty_value() %></td>
						<td><%=vo.getDescription() %></td>
					</tr>
					<% 
				}
			%>
		</tbody>
	</table>
</body>
</html>