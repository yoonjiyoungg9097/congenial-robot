package kr.or.ddit.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSource;

import oracle.jdbc.pool.OracleDataSource;

public class ConnectionFactory {
	private static String url;
	private static String user;
	private static String password;
	private static String driverClassName;
	private static DataSource dataSource;
	
	static {
		try {
//			Class.forName("oracle.jdbc.driver.OracleDriver"); //드라이버 클래스 로딩하는 단계
			ResourceBundle bundle = ResourceBundle.getBundle("kr.or.ddit.db.dbInfo");
			driverClassName = bundle.getString("driverClassName");
			url=bundle.getString("url");
			user=bundle.getString("user");
			password=bundle.getString("password");
			
//			DriverManager(Simple JDBC)와 DataSource(Pooling)의 차이
//			Simple JDBC 방식 : Connection이 필요할때 그 즉시 생성
//			Pooling 방식 : 미리 일정 갯수의 Connection을 생성하고,
//						  Pool을 통해 관리하다, 필요할때 배분해서 사용
//			(pooling장점 - 객체를 일정개수로 미리 생성** : 시간절약, 메모리공간 효울적 사용)
			
			
//			OracleDataSource oracleDS = new OracleDataSource();
//			oracleDS.setURL(url);
//			oracleDS.setUser(user);
//			oracleDS.setPassword(password);
//			dataSource = oracleDS;
			// DBMS에 종속되지 않는 풀링 시스템
			BasicDataSource basicDS = new BasicDataSource();
			basicDS.setDriverClassName(driverClassName);
			basicDS.setUrl(url);
			basicDS.setUsername(user);
			basicDS.setPassword(password);
			int initialSize = Integer.parseInt(bundle.getString("initialSize"));
			int maxActive = Integer.parseInt(bundle.getString("maxActive"));
			long maxWait = Long.parseLong(bundle.getString("maxWait"));
			basicDS.setInitialSize(initialSize); //처음에 5개를 생성하겠다
			basicDS.setMaxActive(maxActive); //최대10개까지 ????
			basicDS.setMaxWait(maxWait); //3초 이내에 반납이 되지않는다면 다시 생성 10개까지 20초 이내에 반납된다면 반납???
			dataSource = basicDS;
		} catch (Exception e) {
			throw new RuntimeException(e); //cheked에서 uncheckd exception으로 변경?
		} 
	}
	
	public static Connection getConnection() throws SQLException {//호출자쪽으로 예외를 넘기겠다는 의미
//		String url="jdbc:oracle:thin:@localhost:1521/xe";
//	    String user="pc21";
//	    String password="java";
		
//	    Connection conn= DriverManager.getConnection(url, user, password);	//java.sql 패키지로 선언할것
		
		Connection conn = dataSource.getConnection();
	    return conn;
	}
}
