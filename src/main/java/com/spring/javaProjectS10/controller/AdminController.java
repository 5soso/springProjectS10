package com.spring.javaProjectS10.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaProjectS10.service.AdminService;
import com.spring.javaProjectS10.service.MemberService;
import com.spring.javaProjectS10.vo.ChartVO;
import com.spring.javaProjectS10.vo.MemberVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
	
	//관리자화면 보여주기
	@RequestMapping(value = "/adminMain", method = RequestMethod.GET)
	public String adminMainGet(Model model) {
		List<ChartVO> chartVOS = adminService.getProductChart();
		model.addAttribute("chartVOS", chartVOS);
		//System.out.println("chartVOS : " + chartVOS);
		
		String[] productNames = new String[5];
		int[] count = new int[5];
		
		for(int i=0; i<productNames.length; i++) {
			productNames[i] = chartVOS.get(i).getProductName();
			count[i] = chartVOS.get(i).getCnt();
		}
		
		//System.out.println("count : "  + count[0]);
		//System.out.println("productNames : "  + productNames[0]);
		
		model.addAttribute("productNames",productNames);
		model.addAttribute("count",count);
		return "admin/adminMain";
	}
	
	//회원정보리스트 보여주기
	@RequestMapping(value = "/member/adminMemberList", method = RequestMethod.GET)
	public String adminMemberListGet(MemberVO vo, Model model) {
		List<MemberVO> vos = memberService.getmemberList();
		model.addAttribute("vos", vos);
		
		return "admin/member/adminMemberList";
	}
	
	//회원 등급 변경하기
	@ResponseBody
	@RequestMapping(value = "/member/adminMemberLevel", method = RequestMethod.POST)
	public String adminMemberLevelPost(int idx, int level) {
		int res = adminService.setMemberLevelCheck(idx, level);
		return res+"";
	}
}
