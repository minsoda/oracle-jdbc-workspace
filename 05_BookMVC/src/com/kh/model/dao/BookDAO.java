package com.kh.model.dao;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.model.vo.Book;
import com.kh.model.vo.Member;
import com.kh.model.vo.Rent;

import config.ServerInfo;

public class BookDAO implements BookDAOTemplate{

	private Properties p = new Properties();
	
	public BookDAO() {
		try {
			p.load(new FileInputStream("src/config/jdbc.properties"));
			Class.forName(ServerInfo.DRIVER_NAME);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	
	
	@Override
	public Connection getConnect() throws SQLException {
		
		Connection conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
		return conn;
	}

	@Override // 커밋을 해줘야 변경된 정보를 보기떄문에 닫아줘야함. select는 조회이기때문에 크게 상관이 없다.
	public void closeAll(PreparedStatement st, Connection conn) throws SQLException {
		st.close();
		conn.close();
	
	}

	@Override
	public void closeAll(ResultSet rs, PreparedStatement st, Connection conn) throws SQLException {
		rs.close();
		closeAll(st, conn); 
		
	}

	@Override
	public ArrayList<Book> printBookAll() throws SQLException {
		
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("printBookAll"));
		
		
		ResultSet rs = st.executeQuery(); // 한줄씩
		ArrayList<Book> bookList = new ArrayList<>();
		
		while(rs.next()) { //행의 반복
			bookList.add(new Book(rs.getInt("bk_no"), rs.getString("bk_title") , rs.getString("bk_author")));
		}
		closeAll(rs, st, conn);
		return bookList;
	}

	@Override
	public int registerBook(Book book) throws SQLException {
		// 반환값 타입이 int인 경우 다 st. executeupdate()!
		
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("registerBook"));
		
		st.setString(1, book.getBkTitle());
		st.setString(2, book.getBkAuthor());
		
		int result = st.executeUpdate();
		
		closeAll(st, conn);
		
		return result;
	}

	@Override
	public int sellBook(int no) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("sellBook"));
		
		st.setInt(1, no);
		
		int result = st.executeUpdate();
		
		closeAll(st, conn);
		
		return result;
	}

	@Override
	public int registerMember(Member member) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("registerMember"));
		
		st.setString(1, member.getMemberId());
		st.setString(2, member.getMemberPwd());
		st.setString(3, member.getMemberName());
		
		int result = st.executeUpdate();
		closeAll(st, conn);
		
		return result;
	}

	@Override
	public Member login(String id, String password) throws SQLException {
		// 아이디,비번을 받아 -> 디비로 가서 조회가 되고 -> 조회된 값이 멤버의 객체에 담긴다.
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("login"));
		
		st.setString(1, id);
		st.setString(2, password);
		ResultSet rs = st.executeQuery();
		
		Member member = null;// member로 가져오고 싶당!,어플리케이션에 null !=  때문에
		// if 문이 없을떄 null로 하기 위해서 
		
		if(rs.next()) { // 결과값이기 떄문에 전부 작성되면 좋다!
			member = new Member(); //if문에서 set으로 변경된걸로 나오기 위해서
			member.setMemberNo(rs.getInt("member_no"));
			member.setMemberId(rs.getString("member_id"));
			member.setMemberPwd(rs.getString("member_pwd"));
			member.setMemberName(rs.getString("member_name"));
			member.setStatus(rs.getString("status").charAt(0));
			member.setEnrollDate(rs.getDate("enroll_date"));
		}
		closeAll(rs, st, conn);
		
		return member;
	}

	@Override
	public int deleteMember(String id, String password) throws SQLException {
		// 위에 member 변수 있어서 로그인때 담아놓아서 매개변수로 따로 안받음!
		
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("deleteMember"));
		
		st.setString(1, id);
		st.setString(2, password);
		int result = st.executeUpdate();
		
		closeAll(st, conn);
		
		return result;
	}

	@Override
	public int rentBook(Rent rent) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("rentBook"));
		
		st.setInt(1, rent.getMember().getMemberNo()); // rent에 member 객체로 부터 no가져옴
		st.setInt(2, rent.getBook().getBkNo());
		int result = st.executeUpdate();
		
		closeAll(st,conn);
		
		return result;
	}

	@Override
	public int deleteRent(int no) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("deleteRent"));
		
		st.setInt(1, no);
		int result = st.executeUpdate();
		
		closeAll(st,conn);
		
		return result;
	}

	@Override
	public ArrayList<Rent> printRentBook(String id) throws SQLException {
		// SQL 문 - JOIN 필요! 
		// rent_no, rent_date, bk_title, bk_author
		// 조건은 member_id가지고 가져오니까!
		
		// while문 안에서! Rent rent = new Rent();
		// setter 사용!
		// rent.setBook(rs.getString("bk_title"),  rs.getString("bk_author")));
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("printRentBook"));
		
		st.setString(1, id);
		ResultSet rs = st.executeQuery();
		
		ArrayList<Rent> rentList = new ArrayList<>(); // 인터페이스라서 null로 로그인처럼 생성불가!
		
		while(rs.next()){
			Rent rent = new Rent(); // ArrayList<Rent> 니까 rent의 객체 생성!
			rent.setRentNo(rs.getInt("rent_no"));
			rent.setRentDate(rs.getDate("rent_date"));
			rent.setBook(new Book(rs.getString("bk_title"),  rs.getString("bk_author")));
			rentList.add(rent); // null로 하면 에러. 
		}
		// Rent rent = new Rent(no, date, book)~~~ : 생성자 생성후 사용 가능!
		closeAll(rs, st, conn);
		return rentList;
	}

}
