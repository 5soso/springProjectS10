package com.spring.javaProjectS10.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS10.vo.ComplaintVO;

@Mapper
public interface ComplaintDAO {

	public int setReviewComplaintInput(@Param("vo") ComplaintVO vo);

	public List<ComplaintVO> getComplaintList();

}
