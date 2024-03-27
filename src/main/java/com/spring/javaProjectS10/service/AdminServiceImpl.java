package com.spring.javaProjectS10.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS10.dao.AdminDAO;
import com.spring.javaProjectS10.vo.ChartVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;

	@Override
	public int setMemberLevelCheck(int idx, int level) {
		return adminDAO.setMemberLevelCheck(idx, level);
	}

	@Override
	public List<ChartVO> getProductChart() {
		return adminDAO.getProductChart();
	}
}
