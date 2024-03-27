package com.spring.javaProjectS10.vo;

import lombok.Data;

@Data
public class WishListVO {
	private int idx;
	private String mid;
	private String productCode;
	private String options;
	private String wishDate;
	
	private String productName;
	private String detail;
	private int mainPrice;
	private String fSName;
	private String content;
	
	private String categorySubCode;
	private String categorySubName;
	
	private int totalPrice;
	private int productIdx; // product 상품테이블의 상품고유 번호..
}
