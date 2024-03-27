package com.spring.javaProjectS10.service;

import java.util.List;

import com.spring.javaProjectS10.vo.ComplaintVO;

public interface ComplaintService {

	public int setReviewComplaintInput(ComplaintVO vo);

	public List<ComplaintVO> getComplaintList();

}
