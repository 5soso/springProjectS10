package com.spring.javaProjectS10.vo;

import lombok.Data;

@Data
public class ReviewVO {
	private int idx;
	private String mid;
	private String productCode;
	private String productName;
	private String orderIdx;
	private String content;
	private int dogWeight;
	private String dogSize; // 리뷰작성시 사용자입력 (옵션=사이즈)
	private String reImage;
	private int reStar;
	private String reDate;
	
	private int mainPrice; // 상품가격
	private int replyCnt; // 댓글 수
	private String orderOptionName; // 주문내역에 있는 옵션명
	private String fSName; // 상품 이미지(여러장)
	private String categorySubName; 
}
