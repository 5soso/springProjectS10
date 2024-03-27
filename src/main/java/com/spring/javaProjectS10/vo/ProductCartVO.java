package com.spring.javaProjectS10.vo;

import lombok.Data;

@Data
public class ProductCartVO {
	private int idx;
	private String cartDate;
	private String mid;
	private int productIdx;
	private String productName;
	private int mainPrice;
	private String thumbImg;
	private String optionIdx;
	private String optionName;
	private String optionPrice;
	private String optionNum;
	private int totalPrice;
	
	private String basicProduct; // 장바구니 기본품목
	private String categorySubName;
	
	private String orderIdx;
}
