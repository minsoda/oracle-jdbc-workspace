package com.youtube.model.vo;

import java.util.Date;

public class VideoComment {

	private int commnetCode;
	private String commentDesc;
	private Date commentDate;
	private int commentParent;
	private Video video;
	private Member member;
	
	public VideoComment() {}
	
	public VideoComment(int commnetCode, String commentDesc, Date commentDate, int commentParent, Video video,
			Member member) {
		this.commnetCode = commnetCode;
		this.commentDesc = commentDesc;
		this.commentDate = commentDate;
		this.commentParent = commentParent;
		this.video = video;
		this.member = member;
	}
	public int getCommnetCode() {
		return commnetCode;
	}
	public void setCommnetCode(int commnetCode) {
		this.commnetCode = commnetCode;
	}
	public String getCommentDesc() {
		return commentDesc;
	}
	public void setCommentDesc(String commentDesc) {
		this.commentDesc = commentDesc;
	}
	public Date getCommentDate() {
		return commentDate;
	}
	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}
	public int getCommentParent() {
		return commentParent;
	}
	public void setCommentParent(int commentParent) {
		this.commentParent = commentParent;
	}
	public Video getVideo() {
		return video;
	}
	public void setVideo(Video video) {
		this.video = video;
	}
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	@Override
	public String toString() {
		return "VideoComment [commnetCode=" + commnetCode + ", commentDesc=" + commentDesc + ", commentDate="
				+ commentDate + ", commentParent=" + commentParent + ", video=" + video + ", member=" + member + "]";
	}
	
	
	
}
