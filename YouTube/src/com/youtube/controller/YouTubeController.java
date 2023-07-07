package com.youtube.controller;

import java.sql.SQLException;

import com.youtube.model.dao.ChannelDAO;
import com.youtube.model.dao.MemberDAO;
import com.youtube.model.vo.Channel;
import com.youtube.model.vo.Member;

public class YouTubeController {

	private MemberDAO memberDao = new MemberDAO();
	private Member member = new Member();
	private Channel channel = new Channel();
	private ChannelDAO channelDao = new ChannelDAO();
	
	public boolean register(Member member) {
		try {
			if(memberDao.register(member)==1) return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public Member login(String id, String password) {
		
		try {
			member = memberDao.login(id, password);
			if(member!=null) return member;
			else return null;
		} catch (SQLException e) {
			e.printStackTrace();
		}

	return null;
	}
	
	public boolean addChannel(Channel channel) {
		
		channel.setMember(member); // 로그인정보가 담겨있으니까
		try {
			if(channelDao.addChannel(channel) ==1) return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
	return false;	
	}
	
	public boolean updateChannel(Channel channel) {
		myChannel();
		try {
			channel.setChannelCode(this.channel.getChannelCode());
			if(channelDao.updateChannel(channel) == 1) return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public boolean deleteChannel() {
		try {
			
			if(channelDao.deleteChannel(channel.getChannelCode()) == 1) return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
		
	}
	
	public Channel myChannel() {
	
		try {
			channel = channelDao.myChannel(member.getMemberId());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return channel;
		
	}
	
	
}
