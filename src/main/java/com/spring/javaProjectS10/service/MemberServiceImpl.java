package com.spring.javaProjectS10.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS10.dao.MemberDAO;
import com.spring.javaProjectS10.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;
	
	@Override
	public int setMemberJoinOk(MemberVO vo) {
		return memberDAO.setMemberJoinOk(vo);
	}

	@Override
	public MemberVO getMemberIdCheck(String mid) {
		return memberDAO.getMemberIdCheck(mid);
	}

	@Override
	public MemberVO getMemberTelCheck(String tel) {
		return memberDAO.getMemberTelCheck(tel);
	}

	@Override
	public MemberVO getMemberNameCheck(String name, String email) {
		return memberDAO.getMemberNameCheck(name, email);
	}

	@Override
	public void setKakaoMemberInput(String mid, String pwd, String name, String email) {
		memberDAO.setKakaoMemberInput(mid, pwd, name, email);
	}

	@Override
	public List<MemberVO> getMemberEmailSearch(String email) {
		return memberDAO.getMemberEmailSearch(email);
	}

	@Override
	public void setMemberPasswordUpdate(String mid, String pwd) {
		memberDAO.setMemberPasswordUpdate(mid, pwd);
	}

	@Override
	public int setMemberUpdate(MemberVO vo) {
		return memberDAO.setMemberUpdate(vo);
	}

	@Override
	public void setLastDateUpdate(String mid) {
		memberDAO.setLastDateUpdate(mid);
	}

	@Override
	public int setMemberDelete(String mid) {
		return memberDAO.setMemberDelete(mid);
	}

	@Override
	public List<MemberVO> getmemberList() {
		return memberDAO.getmemberList();
	}

}
