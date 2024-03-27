package com.spring.javaProjectS10.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaProjectS10.dao.ProductDAO;
import com.spring.javaProjectS10.dao.QnaDAO;

@Service
public class PageProcess {
	
	@Autowired
	QnaDAO qnaDAO;
	
	@Autowired
	ProductDAO productDAO;
	
	public PageVO totRecCnt(int pag, int pageSize, String section, String part, String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		String search = "";
		
	  if(section.equals("qna")) totRecCnt = qnaDAO.totRecCnt();
	  else if(section.equals("qnaSearch")) {
	  	search = part;
	  	totRecCnt = qnaDAO.totRecCntSearch(search, searchString);
	  }
	  else if(section.equals("productList")) totRecCnt = productDAO.totRecCnt(part);
	  else if(section.equals("productReview")) totRecCnt = productDAO.totRecCntReview();
	  //else if(section.equals("reviewChange")) totRecCnt = productDAO.totRecCntReview();
		
		int totPage = (totRecCnt % pageSize)==0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1 ;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		pageVO.setPart(part);
		pageVO.setSearch(search);
		pageVO.setSearchString(searchString);
		
		return pageVO;
	}
}
