package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DBConnectionTest2 {
	
	// 따로 빼주기!
	public static final String DRIVER_NAME = "oracle.jdbc.driver.OracleDriver";
	public static final String URL = "jdbc:oracle:thin:@localhost:1521:xe"; 
	public static final String USER = "kh";
	public static final String PASSWORD = "kh";
	
	
	public static void main(String[] args) {
		
		// 1. 드라이버 로딩
		try {
			Class.forName(DRIVER_NAME);
			System.out.println("Driver Loading...!");
			
		// 2. 디비 연결
			Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
			System.out.println("DB Connection..!!");
		
		// 3. Statement 객체 생성 - INSERT
			String query = "INSERT INTO emp(emp_id, emp_name)VALUES(?, ?)"; // 들어갈 값에 ? 작성
			PreparedStatement st = conn.prepareStatement(query);
					
		// 4. 쿼리문 실행
			st.setInt(1, 3); // ?에 들어갈 값 작성. (위치, 값),primary로 지정되어있어서 한번 실행 후 바로 저장되어있어서 다른값 넣어야해용
			st.setString(2, "김민소");
			
			int result = st.executeUpdate(); // 제대로 실행될 경우 1 반환
			System.out.println(result + " 명 추가!");
			
			
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
		
	}

}
