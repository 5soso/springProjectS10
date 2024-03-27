package com.spring.javaProjectS10.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	
	@RequestMapping(value="/message/{msgFlag}", method = RequestMethod.GET)
	public String msgGet(@PathVariable String msgFlag, Model model, String mid,
			@RequestParam(name="idx", defaultValue="0", required = false) int idx) {
		
		/* 회원가입/로그인 */
		if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("msg", "회원가입 되었습니다.");
			model.addAttribute("url", "member/memberJoin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("msg", "회원가입에 실패하였습니다. 가입양식을 확인하세요.");
			model.addAttribute("url", "member/memberJoin");
		}
		else if(msgFlag.equals("idCheckNo")) {
			model.addAttribute("msg", "중복된 아이디입니다. 다른 아이디를 사용하세요.");
			model.addAttribute("url", "member/memberJoin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("msg", mid+"님 로그인되었습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("msg", "아이디 또는 비밀번호가 틀립니다. 다시 로그인 하세요.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", mid+"님 로그아웃되었습니다.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("kakaoLoginOk")) {
			model.addAttribute("msg", mid+"님 로그인되었습니다.");
			model.addAttribute("url", "/");
		}
		/* 백엔드 체크 */
		else if(msgFlag.equals("backCheckNo")) {
			model.addAttribute("msg", "유효성 검사 오류");
			model.addAttribute("url", "/");
		}
		/* 관리자 상품등록 */
		else if(msgFlag.equals("productInputOk")) {
			model.addAttribute("msg", "상품이 등록되었습니다.");
			model.addAttribute("url", "product/productInput");
		}
		else if(msgFlag.equals("productInputNo")) {
			model.addAttribute("msg", "상품 등록에 실패하였습니다.");
			model.addAttribute("url", "product/productInput");
		}
		else if(msgFlag.equals("OptionInputOk")) {
			model.addAttribute("msg", "옵션 등록에 성공하였습니다.");
			model.addAttribute("url", "product/productOption");
		}
		else if(msgFlag.equals("OptionInputNo")) {
			model.addAttribute("msg", "옵션 등록에 실패하였습니다.");
			model.addAttribute("url", "product/productOption");
		}
		else if(msgFlag.equals("productDeleteOK")) {
			model.addAttribute("msg", "상품이 삭제되었습니다.");
			model.addAttribute("url", "product/adminProductList");
		}
		else if(msgFlag.equals("productDeleteNo")) {
			model.addAttribute("msg", "상품 삭제에 실패하였습니다.");
			model.addAttribute("url", "product/productContent?idx="+idx);
		}
		/* 장바구니 처리 */
		else if(msgFlag.equals("cartInputOk")) {
			model.addAttribute("msg", "장바구니에 상품이 등록되었습니다.\\n즐거운 쇼핑되세요.");
			model.addAttribute("url", "product/productCartList?idx="+idx);
		}
		else if(msgFlag.equals("cartOrderOk")) {
			model.addAttribute("msg", "주문창으로 이동합니다.");
			model.addAttribute("url", "product/productOrder");
		}
		else if(msgFlag.equals("cartOrderNo")) {
			model.addAttribute("msg", "상품 담기에 실패하였습니다.");
			model.addAttribute("url", "product/productContentShop?idx="+idx);
		}
		else if(msgFlag.equals("cartEmpty")) {
			model.addAttribute("msg", "장바구니가 비어있습니다.");
			model.addAttribute("url", "product/productList");
		}
		else if(msgFlag.equals("paymentResultOk")) {
			model.addAttribute("msg", "결제가 완료되었습니다.");
			model.addAttribute("url", "/");
		}
		/* 회원 정보 수정 처리 */
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("msg", "회원정보가 수정되었습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("msg", "회원정보 수정에 실패하였습니다.");
			model.addAttribute("url", "member/memberUpdate");
		}
		else if(msgFlag.equals("memberDeleteOk")) {
			model.addAttribute("msg", "회원탈퇴 되었습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberDeleteNo")) {
			model.addAttribute("msg", "회원 탈퇴에 실패하였습니다.");
			model.addAttribute("url", "member/memberUpdate");
		}
		/* 위시리스트 */
		else if(msgFlag.equals("wishDeleteOk")) {
			model.addAttribute("msg", "해당 상품이 위시리스트에서 삭제되었습니다.");
			model.addAttribute("url", "product/wishList?mid="+mid);
		}
		else if(msgFlag.equals("wishDeleteNo")) {
			model.addAttribute("msg", "삭제 실패하였습니다.");
			model.addAttribute("url", "product/wishList?mid="+mid);
		}
		/* qna */
		else if(msgFlag.equals("qnaInputOk")) {
			model.addAttribute("msg", "QnA에 글이 등록되었습니다.");
			model.addAttribute("url", "/qna/qnaList");
		}
		else if(msgFlag.equals("qnaUpdateOk")) {
			model.addAttribute("msg", "QnA에 글이 수정되었습니다.");
			model.addAttribute("url", "/qna/qnaList");
		}
		else if(msgFlag.equals("qnaDelete")) {
			model.addAttribute("msg", "QnA에 글이 삭제되었습니다.");
			model.addAttribute("url", "/qna/qnaList");
		}
		else if(msgFlag.equals("reviewInputOk")) {
			model.addAttribute("msg", "리뷰글이 저장되었습니다.");
			model.addAttribute("url", "/product/productMyOrder");
		}
		else if(msgFlag.equals("reviewInputNo")) {
			model.addAttribute("msg", "리뷰글 저장실패~~");
			model.addAttribute("url", "/product/productMyOrder");
		}
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("msg", "관리자만 이용하실수 있습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("memberNo")) {
			model.addAttribute("msg", "로그인후 사용하세요.");
			model.addAttribute("url", "member/memberLogin");
		}
		
		return "include/message";
	}
}
