package com.spring.javaProjectS10.service;

import java.util.List;

import com.spring.javaProjectS10.vo.ChartVO;

public interface AdminService {

	public int setMemberLevelCheck(int idx, int level);

	public List<ChartVO> getProductChart();

}
