package com.spring.javaProjectS10.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS10.dao.ComplaintDAO;
import com.spring.javaProjectS10.vo.ComplaintVO;

@Service
public class ComplaintServiceImpl implements ComplaintService {

	@Autowired
	ComplaintDAO complaintDAO;

	@Override
	public int setReviewComplaintInput(ComplaintVO vo) {
		return complaintDAO.setReviewComplaintInput(vo);
	}

	@Override
	public List<ComplaintVO> getComplaintList() {
		return complaintDAO.getComplaintList();
	}
}
