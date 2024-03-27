package com.spring.javaProjectS10.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS10.vo.QnaVO;

public interface QnaDAO {

	public String getEmail(@Param("mid") String mid);

	public int getCountIdx();

	public int getMaxIdx();

	public void qnaInputOk(@Param("vo") QnaVO vo);
	
	public int totRecCnt();

	public List<QnaVO> getQnaList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public QnaVO getQnaContent(@Param("idx") int idx);

	public void setQnaDelete(@Param("idx") int idx);

	public void setQnaContentUpdate(@Param("vo") QnaVO vo);

	public List<QnaVO> getQnaIdxCheck(@Param("qnaIdx") int qnaIdx);

	public void setQnaCheckUpdate(@Param("idx") int idx, @Param("title") String title);

	public List<QnaVO> getQnaSearchList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);

	public int totRecCntSearch(@Param("search") String search, @Param("searchString") String searchString);

	public void qnaAdminInputOk(@Param("qnaIdx") int qnaIdx);

	public void qnaAdminAnswerUpdateOk(@Param("qnaIdx") int qnaIdx);
}
