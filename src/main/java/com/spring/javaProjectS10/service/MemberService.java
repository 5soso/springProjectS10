package com.spring.javaProjectS10.service;

import java.util.List;

import com.spring.javaProjectS10.vo.MemberVO;

public interface MemberService {

	public int setMemberJoinOk(MemberVO vo);

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberTelCheck(String tel);

	public MemberVO getMemberNameCheck(String name, String email);

	public void setKakaoMemberInput(String mid, String pwd, String name, String email);

	public List<MemberVO> getMemberEmailSearch(String email);

	public void setMemberPasswordUpdate(String mid, String pwd);

	public int setMemberUpdate(MemberVO vo);

	public void setLastDateUpdate(String mid);

	public int setMemberDelete(String mid);

	public List<MemberVO> getmemberList();

}
