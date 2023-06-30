package config;

/*
 * 디비 서버 정보의 상수값으로 구성된 인터페이스
 * */
public interface ServerInfo {// 상수값 저장할거라서 interface

	String DRIVER_NAME = "oracle.jdbc.driver.OracleDriver";
	String URL = "jdbc:oracle:thin:@localhost:1521:xe"; 
	String USER = "kh";
	String PASSWORD = "kh";
	
}
