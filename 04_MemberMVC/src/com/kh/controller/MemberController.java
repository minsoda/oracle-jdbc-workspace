package com.kh.controller;

import java.sql.SQLException;

import com.kh.model.dao.MemberDAO;
import com.kh.model.vo.Member;

import oracle.net.aso.m;

public class MemberController {

	private MemberDAO dao = new MemberDAO();
	
	// controller에서 try~catch!
	
	public boolean joinMembership(Member m) {

		// id가 없다면 회원가입 후 true 반환
		// 없다면 false 값 반환
		
			try {
				if(dao.getMember(m.getId()) == null) {
				dao.registerMember(new Member(m.getId(), m.getPassword(), m.getName()));
				return true;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		return false;

	}
	
	public String login(String id, String password) {

		// 로그인 성공하면 이름 반환
		// 실패하면 null 반환
		Member m = new Member();
		m.setId(id);
		m.setPassword(password);
		
		try {
			if(dao.login(m) != null) {
				return dao.login(m).getName();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	
	public boolean changePassword(String id, String oldPw, String newPw) {

		// 로그인 했을 때 null이 아닌 경우
		// 비밀번호 변경 후 true 반환, 아니라면 false 반환
		Member m = new Member();
		m.setId(id);
		m.setPassword(oldPw);
		
		
		if(login(id, oldPw) != null) {
				try {
					dao.updatePassword(new Member(m.getId(),newPw,m.getName()));
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
				return true;
				
		}
		return false;
	}
	
	public void changeName(String id, String name) {

		// 이름 변경!
		Member m = new Member();
		m.setId(id);
		m.setName(name);
		
		try {
			dao.updateName(new Member(m.getId(), m.getPassword(), name)); 
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}


}