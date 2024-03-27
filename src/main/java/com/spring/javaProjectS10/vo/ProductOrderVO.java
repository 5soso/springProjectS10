package com.spring.javaProjectS10.vo;

import lombok.Data;

@Data
public class ProductOrderVO {
  private int idx;
  private String orderIdx;
  private String mid;
  private int productIdx;
  private String orderDate;
  private String productName;
  private int mainPrice;
  private String thumbImg;
  private String optionName;
  private String optionPrice;
  private String optionNum;
  private int totalPrice;
  
  private int cartIdx;  // 장바구니 고유번호.
  private int maxIdx;   // 주문번호를 구하기위한 기존 최대 비밀번호필드
  private int baesong;  // 배송비저장필드
  
	public String categorySubName;
	public String detail;
	private String productCode;
	
	private String reviewOk; //리뷰작성했는지체크
}