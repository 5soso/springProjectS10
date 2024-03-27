package com.spring.javaProjectS10.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS10.pagination.PageProcess;
import com.spring.javaProjectS10.pagination.PageVO;
import com.spring.javaProjectS10.service.MemberService;
import com.spring.javaProjectS10.service.ProductService;
import com.spring.javaProjectS10.vo.ProductOrderVO;
import com.spring.javaProjectS10.vo.ReviewVO;

@Controller
@RequestMapping("/review")
public class ReviewController {
	@Autowired
	ProductService productService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	MemberService memberService;
	
	// 사용자 리뷰리스트 보여주기(최신순(recent)/별점순(star))
	@RequestMapping(value = "/productReview", method = RequestMethod.GET)
	public String productReviewGet(Model model,
			@RequestParam(name="reviewChange", defaultValue = "recent", required = false) String reviewChange, 
  		@RequestParam(name="searchString", defaultValue = "", required = false) String searchString, 
  		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
  		@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "productReview", reviewChange, searchString);
		List<ReviewVO> vos = productService.getProductReview(pageVO.getStartIndexNo(), pageSize, reviewChange);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("reviewChange", reviewChange);
		model.addAttribute("reviewTotalCount", pageVO.getTotRecCnt());
		return "review/productReview";
	}
	
	// 사용자 검색어창 폼 보여주기
	@RequestMapping(value = "/reviewSearch", method = RequestMethod.GET)
	public String reviewSearchGet(Model model, String reviewSearch) {
		List<ReviewVO> vos = productService.getProductReviewSearch(reviewSearch);
		model.addAttribute("vos", vos);
		
		return "review/reviewSearch";
	}
	
	/*
	// 리뷰 별점순으로 보여주기
	@RequestMapping(value = "/reviewChange", method = RequestMethod.GET)
	public String reviewChangeGet(Model model,
			@RequestParam(name="reviewChange", defaultValue = "recent", required = false) String reviewChange, 
  		@RequestParam(name="searchString", defaultValue = "", required = false) String searchString, 
  		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
  		@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "reviewChange", reviewChange, searchString);
		List<ReviewVO> vos = productService.getProductReviewChange(reviewChange, pageVO.getStartIndexNo(), pageSize);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("reviewChange", reviewChange);
		model.addAttribute("reviewTotalCount", pageVO.getTotRecCnt());
		
		return "review/productReview";
	}
	*/
	
	// 리뷰작성하기 폼 보기
	@RequestMapping(value = "/productReviewView", method = RequestMethod.GET)
	public String productReviewViewGet(Model model, String orderIdx) {
		List<ProductOrderVO> vos = productService.getProductOrderIdx(orderIdx);
		model.addAttribute("vos", vos);
		return "review/productReviewView";
	}
	
	// 리뷰작성 처리
	@ResponseBody
	@RequestMapping(value = "/productReviewView", method = RequestMethod.POST)
	public String productReviewViewPost(ReviewVO vo, MultipartFile reImg) {
		int res = productService.setReviewInput(vo, reImg);
		
		return res + "";
	}
}
