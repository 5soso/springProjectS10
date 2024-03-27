package com.spring.javaProjectS10.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaProjectS10.service.ComplaintService;
import com.spring.javaProjectS10.service.MemberService;
import com.spring.javaProjectS10.service.ProductService;
import com.spring.javaProjectS10.vo.ComplaintVO;

@Controller
@RequestMapping("/complaint")
public class ComplaintController {
	@Autowired
	ProductService productService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	ComplaintService complaintService;
	
	// 리뷰 신고처리 - 사용자
	@ResponseBody
	@RequestMapping(value = "/reviewComplaintInput", method = RequestMethod.POST)
	//public String reviewComplaintInput(int idx, String mid, String part, String content) {
	public String reviewComplaintInput(ComplaintVO vo) {
    vo.setPartIdx(vo.getIdx());
    
		int res = complaintService.setReviewComplaintInput(vo);
		return res + "";
	}
	
	/* ======================================================================================================= */
	// 관리자
	
	// 리뷰리스트 폼 보여주기 - 관리자
	@RequestMapping(value = "/complaintList", method = RequestMethod.GET)
	public String complaintListGet(Model model, ComplaintVO vo) {
		List<ComplaintVO> vos = complaintService.getComplaintList();
		model.addAttribute("vos", vos);
		System.out.println("vos : " + vos);
		
		return "admin/complaint/complaintList";
	}
}
