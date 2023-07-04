package com.kh.model.dao;

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

/*
 * dao란?
 * Database Access Object의 약자로 디비에 접근하는 로직
 * (일명 비즈니스 로직)을 담고 있는 객체
 * */

public class MemberDAO implements MemberDAOTemplate{

	private Properties p = new Properties();

	// 1. 드라이버 로딩
	public MemberDAO() {
		try {
			p.load(new FileInputStream("src/config/jdbc.properties"));
			Class.forName(ServerInfo.DRIVER_NAME);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	// 2. 디비 연결
	public Connection getConnect() throws SQLException {
		Connection conn = DriverManager.getConnection(ServerInfo.URL, ServerInfo.USER, ServerInfo.PASSWORD);
		return conn;
	}

	// 자원반납1
	public void closeAll(PreparedStatement st, Connection conn) throws SQLException {
		st.close();
		conn.close();
	}

	// 자원반납 2
	public void closeAll(ResultSet rs, PreparedStatement st, Connection conn) throws SQLException {
		closeAll(st, conn); // 자원반납1 불러옴
		rs.close(); // rs 추가
	}

	// 회원가입
	public void registerMember(Member vo) throws SQLException {
		Connection conn = getConnect();
		PreparedStatement st = conn.prepareStatement(p.getProperty("registerMember"));

		st.setString(1, vo.getId());
		st.setString(2, vo.getPassword());
		st.setString(3, vo.getName());

		st.executeUpdate();

		closeAll(st, conn);
	}

	// 비밀번호 변경
	public void updatePassword(Member vo) throws SQLException { 
		Connection conn = getConnect();

		PreparedStatement st = conn.prepareStatement(p.getProperty("updatePassword"));

		st.setString(1, vo.getPassword());
		st.setString(2, vo.getId());

		st.executeUpdate();

		closeAll(st, conn);
	}

	// 정보변경
	public void updateName(Member vo) throws SQLException {
		Connection conn = getConnect();

		PreparedStatement st = conn.prepareStatement(p.getProperty("updateName"));

		st.setString(1, vo.getName());
		st.setString(2, vo.getId());

		st.executeUpdate();

		closeAll(st, conn);
	}

	// 정보보기
	public Member getMember(String id) throws SQLException {
		Connection conn = getConnect();

		PreparedStatement st = conn.prepareStatement(p.getProperty("getMember"));

		st.setString(1, id);
		ResultSet rs = st.executeQuery();

		Member m = null;
		if(rs.next()) {
			m = new Member(id, rs.getString("password"), rs.getString("name"));
		}

		closeAll(rs, st,conn);
		return m;
	}

	// 로그인
	public Member login(Member vo) throws SQLException {
		Connection conn = getConnect();

		PreparedStatement st = conn.prepareStatement(p.getProperty("login"));

		st.setString(1, vo.getId());
		st.setString(2, vo.getPassword());
		ResultSet rs = st.executeQuery();

		Member m = null;
		if(rs.next()) {
			m=new Member(rs.getString("id"), rs.getString("password"), rs.getString("name"));
		} 
		closeAll(rs, st, conn);
		return m;
	}
}