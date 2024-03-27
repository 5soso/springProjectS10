package com.spring.javaProjectS10.vo;

import lombok.Data;

@Data
public class ProductBaesongVO {
  private int idx;
  private int oIdx;
  private String orderIdx;
  private int orderTotalPrice;
  private String mid;
  private String name;
  private String address; // 구매자의 배송주소(변경한 주소)
  private String tel; // 구매자의 연락처 (변경후 연락처)
  private String email;
  private String message;
  private String payment;
  private String payMethod;
  private String orderStatus;
  
  private String buyer_addr; // 구매한사람의 주소
  private String buyer_tel;
  
  // 아래는 주문테이블에서 사용된 필드리스트이다.
	private int productIdx;
	private String orderDate;
	private String productName;
	private int mainPrice;
	private String thumbImg;
	private String optionName;
	private String optionPrice;
	private String optionNum;
	private int totalPrice;
}
