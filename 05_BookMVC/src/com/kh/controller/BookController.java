package com.kh.controller;

import java.sql.SQLException;
import java.util.ArrayList;

import com.kh.model.dao.BookDAO;
import com.kh.model.vo.Book;
import com.kh.model.vo.Member;
import com.kh.model.vo.Rent;

public class BookController {

	private BookDAO dao = new BookDAO(); 
	private Member member = new Member();
	
	public ArrayList<Book> printBookAll(){
		ArrayList<Book> list = new ArrayList<>();

		try {
			list.contains(dao.printBookAll());
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public boolean registerBook(Book book) {
		
			try {
					if(dao.registerBook(book))
						
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
		
		
		return false;
	}
	
	public boolean sellBook(int no) {
		
		return false;
	}
	
	public boolean registerMember(Member member) {
		

			
		return false;
	}
	
	public Member login(String id, String password) {
		return member;
	}
	
	public boolean deleteMember() {
		return false;
	}
	
	public boolean rentBook(int no) {
		return false;
	}
	
	public boolean deleteRent(int no) {
		return false;
	}
	
	public ArrayList<Rent> printRentBook(){ // 멤버 아이디로 본인이 대여한 리스트 확인
		return null;
	}
	
	
	
}
