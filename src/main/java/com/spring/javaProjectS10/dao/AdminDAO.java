package com.spring.javaProjectS10.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS10.vo.ChartVO;

public interface AdminDAO {

	public int setMemberLevelCheck(@Param("idx") int idx, @Param("level") int level);

	public List<ChartVO> getProductChart();
	
}
