package com.spring.javaProjectS10.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS10.vo.MemberVO;

public interface MemberDAO {

	public int setMemberJoinOk(@Param("vo") MemberVO vo);

	public MemberVO getMemberIdCheck(@Param("mid") String mid);

	public MemberVO getMemberTelCheck(@Param("tel") String tel);

	public MemberVO getMemberNameCheck(@Param("name") String name, @Param("email") String email);

	public void setKakaoMemberInput(@Param("mid") String mid, @Param("pwd") String pwd, @Param("name") String name, @Param("email") String email);

	public List<MemberVO> getMemberEmailSearch(@Param("email") String email);

	public void setMemberPasswordUpdate(@Param("mid") String mid, @Param("pwd") String pwd);

	public int setMemberUpdate(@Param("vo") MemberVO vo);

	public void setLastDateUpdate(@Param("mid") String mid);

	public int setMemberDelete(@Param("mid") String mid);

	public List<MemberVO> getmemberList();

}
