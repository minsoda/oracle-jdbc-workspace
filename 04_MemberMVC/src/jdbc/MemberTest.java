package jdbc;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.kh.model.vo.Member;

import config.ServerInfo;

public class MemberTest {
	
	private Properties p = new Properties();
	
	public MemberTest() {
		
		try {
			p.load(new FileInputStream("src/config/jdbc.properties"));
			Class.forName(ServerInfo.DRIVER_NAME);
			
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public Connection getConnect() throws SQLException {
		Connection conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
		return conn;
	}
	
	public void closeAll(PreparedStatement st, Connection conn) throws SQLException {
//		if(st != null) 
			 st.close();
//		if(conn != null) 
			conn.close();
	}
	
	public void closeAll(ResultSet rs, PreparedStatement st, Connection conn) throws SQLException {
//		if(rs != null) 
			rs.close();
			closeAll(st, conn);
	}
	
	public void registerMember(Member vo) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("registerMember"));
		
		st.setString(1, vo.getId());
		st.setString(2, vo.getPassword());
		st.setString(3, vo.getName());
		st.executeUpdate();
//		int result = st.executeUpdate();

		closeAll(st, conn);
	}
	
	public void updatePassword(Member vo) throws SQLException { 
		
		Connection conn = getConnect();		
		PreparedStatement st = conn.prepareStatement(p.getProperty("updatePassword"));
		
		st.setString(1, vo.getPassword());
		st.setString(2, vo.getId());
		st.executeUpdate();
		
//		int result = st.executeUpdate();
		
		closeAll(st, conn);
		
	}
	
	public void updateName(Member vo) throws SQLException {
		
		Connection conn = getConnect();		
		PreparedStatement st = conn.prepareStatement(p.getProperty("updateName"));
		
		st.setString(1, vo.getName());
		st.setString(2, vo.getId());
		st.executeUpdate();
//		int result = st.executeUpdate();
		
		closeAll(st, conn);
		
	}
	
	public Member getMember(String id) throws SQLException {
		
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("getMember"));
		
		st.setString(1, id);
		ResultSet rs = st.executeQuery();
		
		Member m = null;
		if(rs.next()) {
			m = new Member(id, rs.getString("password"), rs.getString("name"));
		}
			closeAll(rs, st, conn);
		return m;
	}
	
	public Member login(Member vo) throws SQLException {
		
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("login"));
		
		st.setString(1, vo.getId());
		st.setString(2, vo.getPassword());
		ResultSet rs = st.executeQuery();
		
		Member m = null;
		if(rs.next()) {
			m = new Member(rs.getString("id"), rs.getString("password"), rs.getString("name"));
		}
		closeAll(rs, st, conn);
		return m;
	}
	
	public static void main(String[] args) {

		try {
			
			MemberTest mt = new MemberTest();
			Member m = new Member("user01", "1234", "user11");
			mt.registerMember(m);
			System.out.println("회원가입!");
			
			m.setPassword("123456");
			mt.updatePassword(m);
			System.out.println("비밀번호 변경!");
		
			m.setName("user1234");
			mt.updateName(m);
			System.out.println("이름 변경!");
			
			System.out.println(mt.getMember(m.getId()));
			
			System.out.println(mt.login(m));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

}
