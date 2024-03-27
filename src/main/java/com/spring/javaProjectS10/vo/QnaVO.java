package com.spring.javaProjectS10.vo;

import lombok.Data;

@Data
public class QnaVO {
	private int idx;
	private int qnaIdx;
	private String mid;
	private String nickName;
	private String title;
	private String email;
	private String pwd;
	private String wDate;
	private String content;
	private String qnaSw;
	private int ansLevel;
	private String part;
	
	private String diffTime;
	private String qnaAnswer;
}
