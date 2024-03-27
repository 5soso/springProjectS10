package com.spring.javaProjectS10.vo;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import lombok.Data;

@Data
public class MemberVO {
	private int idx; 
	
	@NotEmpty(message="아이디가 공백입니다.")
	@Size(min=4, max=20, message="아이디 길이가 잘못되었습니다.")
	private String mid;
	
	@NotEmpty(message="비밀번호가 공백입니다.")
	@Size(min=6, max=20, message="비밀번호 길이가 잘못되었습니다.")
	private String pwd;
	
	@NotEmpty(message="성명이 공백입니다.")
	@Size(min=1, max=15, message="성명의 길이가 잘못되었습니다.")
	private String name;
	
	@NotEmpty(message="전화번호가 공백입니다.")
	@Size(min=12, max=15, message="전화번호의 길이가 잘못되었습니다.")
	private String tel;
	
	@NotEmpty(message="이메일이 공백입니다.")
	private String email;
	
	@NotEmpty(message="주소가 공백입니다.")
	private String address;
	
	private String birthday;
	private int level;
	private int point;
	private String userCancel;
	private int visitCount;
	private String lastDate;
}
