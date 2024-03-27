package com.spring.javaProjectS10.vo;

import lombok.Data;

@Data
public class ProductOptionVO {
	private int idx;
	private int productIdx;
	private String optionName;
	private int optionPrice;
	
	private String productName;
}
