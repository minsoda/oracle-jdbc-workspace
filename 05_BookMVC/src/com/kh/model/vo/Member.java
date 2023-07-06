package com.kh.model.vo;

import java.util.Date;

public class Member {

	
	private int memberNo;
	private String memberId;
	private String memberPwd;
	private String memberName;
	private char status;
	private Date enrollDate;
	
	
	public Member() {
		
	}
	
	public Member(String id, String password, String name) {
		this.memberId = id;
		this.memberPwd = password;
		this.memberName = name;
	
	}


	public Member(int memberNo) {
		this.memberNo = memberNo;
		
	}


	public Member(int memberNo, String memberId, String memberPwd, String memberName, char status, Date enrollDate) {
		super();
		this.memberNo = memberNo;
		this.memberId = memberId;
		this.memberPwd = memberPwd;
		this.memberName = memberName;
		this.status = status;
		this.enrollDate = enrollDate;
	}


	public int getMemberNo() {
		return memberNo;
	}


	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}


	public String getMemberId() {
		return memberId;
	}


	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}


	public String getMemberPwd() {
		return memberPwd;
	}


	public void setMemberPwd(String memberPwd) {
		this.memberPwd = memberPwd;
	}


	public String getMemberName() {
		return memberName;
	}


	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}


	public char getStatus() {
		return status;
	}


	public void setStatus(char status) {
		this.status = status;
	}


	public Date getEnrollDate() {
		return enrollDate;
	}


	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}


	@Override
	public String toString() {
		return "Member [memberNo=" + memberNo + ", memberId=" + memberId + ", memberPwd=" + memberPwd + ", memberName="
				+ memberName + ", status=" + status + ", enrollDate=" + enrollDate + "]";
	}
	
	
	
	
}
