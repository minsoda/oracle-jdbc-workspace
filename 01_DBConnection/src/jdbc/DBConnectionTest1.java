package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class DBConnectionTest1 {

	/*
	 * JDBC(Java DataBase Connectivity)
	 * - 자바에서 표준화된 방벙으로 다양한 데이터베이스에 접속할 수 있도록 설계된 인터페이스
	 * */
	
	public static void main(String[] args) {
		
		
		// JDBC 작업 4단계
		
	
		try {
			// 1.드라이버를 로딩
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("Driver Loading....!");
			
			// 2. 데이터베이스와 연결
			Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "kh", "kh");
			System.out.println("DB Connection..!!");
			
			// 3. Statement 객체 생성 - SELECT
			String query = "SELECT * FROM employee";
			PreparedStatement st = conn.prepareStatement(query); // Statement를 상속받은 class. 
			
			// 4. 쿼리문 실행
			ResultSet rs = st.executeQuery();
			
			while(rs.next()) {
				String empId = rs.getString("emp_id"); // 컬럼명 명시, SQL 데이터형이랑 상관없음
				String empName = rs.getString("emp_name");
				String deptCode = rs.getString("dept_code");
				String jobCode = rs.getString("job_code");
				int salary = rs.getInt("salary");
				float bonus = rs.getFloat("bonus");
				Date hireDate = rs.getDate("hire_date"); // util로 import 
				char entYn = rs.getString("ent_yn").charAt(0); //한글자니까 0
				
				System.out.println(empId + " / " + empName + " / " + deptCode + " / " 
									+ jobCode + " / " + salary + " / " + bonus + " / " 
									+ hireDate + " / " + entYn);
				
			}
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
	
	
	}

}
