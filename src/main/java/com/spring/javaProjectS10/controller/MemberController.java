package com.spring.javaProjectS10.controller;

import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaProjectS10.service.MemberService;
import com.spring.javaProjectS10.service.ProductService;
import com.spring.javaProjectS10.vo.MemberVO;
import com.spring.javaProjectS10.vo.ProductBaesongVO;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	@Autowired
	JavaMailSender mailSender2;
	
	@Autowired
	ProductService productService;
	
	// 회원가입폼 보여주기 
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet() {
		return "member/memberJoin";
	}
	
	// 회원가입 처리
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPost(@Validated MemberVO vo, BindingResult bindingResult) {
		if(bindingResult.hasFieldErrors()) return "redirect:/message/backCheckNo";
		
		// BackEnd 체크 완료후에 DB에 저장처리한다.
		// 아이디 중복체크
		if(memberService.getMemberIdCheck(vo.getMid()) != null) return "redirect:/message/idCheckNo";
		
		// 비밀번호 암호화
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		int res = memberService.setMemberJoinOk(vo);
		
		if(res == 1) return "redirect:/message/memberJoinOk";
		else return "redirect:/message/memberJoinNo";
	}
	
	// 아이디 중복체크 - ajax처리
	@ResponseBody
	@RequestMapping(value = "/memberIdCheck", method = RequestMethod.POST)
	public String memberIdCheckPost(String mid) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo != null) return "1";
		else return "0";
	}
	
	// 전화번호 중복체크 - ajax처리
	@ResponseBody
	@RequestMapping(value = "/memberTelCheck", method = RequestMethod.POST)
	public String memberTelCheckPost(String tel) {
		MemberVO vo = memberService.getMemberTelCheck(tel);
		
		if(vo != null) return "1";
		else return "0";
	}

	//회원가입시 인증번호 보내기
	@ResponseBody
	@RequestMapping(value = "/memberMailCheck", method = RequestMethod.POST)
	public String memberMailCheckPost(String email, HttpSession session) throws MessagingException {
		UUID uid = UUID.randomUUID();
		String mailCheck = uid.toString().substring(0,8);
		session.setAttribute("sMailCheck", mailCheck);
		
		// 새로 발급된 인증번호를 메일로 전송한다.
		mailSend(email, mailCheck, "J");
		return "";
	}
	
	//이메일 인증 확인 처리 : 메일로 전송한 인증번호와 회원가입시 입력한 인증번호가 같은지 비교한다.
	@ResponseBody
	@RequestMapping(value = "/memberMailCheckOk", method = RequestMethod.POST)
	public String memberMailCheckOkPost(String mailCheckNum, HttpSession session) {
		String mailCheck = (String) session.getAttribute("sMailCheck");
		
		if(mailCheckNum.equals(mailCheck)) return "1";
		else return "0";
	}
	
	// 로그인 폼 보여주기
	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();

		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cMid")) {
					request.setAttribute("mid", cookies[i].getValue());
					break;
				}
			}
		}
		return "member/memberLogin";
	}
	
	// 로그인 처리 
	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(HttpSession session,
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name = "mid", defaultValue = "", required = false) String mid, 
			@RequestParam(name = "pwd", defaultValue = "", required = false) String pwd,
			@RequestParam(name = "idSave", defaultValue = "on", required = false) String idSave) {
		MemberVO vo = memberService.getMemberIdCheck(mid);

		// 세션처리
		if(vo != null && vo.getUserCancel().equals("NO") && passwordEncoder.matches(pwd, vo.getPwd())) {
			String strLevel = "";
			if(vo.getLevel() == 0) strLevel = "관리자";
			else if(vo.getLevel() == 1) strLevel = "VIP";
			else if(vo.getLevel() == 2) strLevel = "Sliver";
			else if(vo.getLevel() == 3) strLevel = "일반회원";
			
			session.setAttribute("sMid", mid);
			session.setAttribute("sName", vo.getName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("strLevel", strLevel);
			
			// 2.쿠키저장/삭제
			if(idSave.equals("on")) {
				Cookie cookieMid = new Cookie("cMid", mid);
				cookieMid.setMaxAge(60*60*24*7);
				response.addCookie(cookieMid);
			}
			// 쿠키 만료시간
			else {
			  Cookie[] cookies = request.getCookies();
			  for(int i=0; i<cookies.length; i++) {
			  	if(cookies[i].getName().equals("cMid")) {
			  		cookies[i].setMaxAge(0);
			  		response.addCookie(cookies[i]);
			  		break;
			  	}
			  }
			}
			
			// 최종방문일자 저장하기
			memberService.setLastDateUpdate(mid);
			
			return "redirect:/message/memberLoginOk?mid="+mid;
		}
		else {
			return "redirect:/message/memberLoginNo";
		}
	}
	
	//카카오 회원가입/로그인처리 
	@RequestMapping(value = "/kakaoLogin", method = RequestMethod.GET)
	public String kakaoLoginGet(HttpSession session, HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name="nickName", defaultValue = "", required = false) String name,
			String email, String accessToken) throws MessagingException {
		
		session.setAttribute("sAccessToken", accessToken);
		
		// 카카오로그인한 회원이 현재 우리 회원인지를 조사한다.(넘어온 이메일의 @를 기준으로 아이디와 이메일을 분리후 member테이블의 정보와 비교한다.)
		MemberVO vo = memberService.getMemberNameCheck(name, email);
		//System.out.println("vo : " + vo);
		
		String mid = "";
		
		// 현재 카카오로그인한 회원이 우리회원이 아니었다면, 자동으로 우리 회원에 가입처리한다.(필수입력사항 : 아이디, 닉네임, 이메일) - 단 성명은 '닉네임'과 동일하게 가입처리한다.
		if(vo == null) {
			// 아이디 결정해주기
			mid = email.substring(0, email.indexOf("@"));
			
			// 만약에 기존에 같은 아이디가 존재한다면 가입처리 할 수 없도록 한다.
			MemberVO vo2 = memberService.getMemberIdCheck(mid);
			if(vo2 != null) return "redirect:/message/midSameSearch";

			// 새로 발급 받은 비밀번호로 암호화 처리후 DB에 저장처리한다.
			// 임시 비밀번호를 발급처리후 메일로 전송처리한다.
			UUID uid = UUID.randomUUID();
			String pwd = uid.toString().substring(0,8);
			session.setAttribute("sImsiPwd", pwd);
			
			// 새로 발급받은 임시비밀번호로 암호화 처리후 DB에 저장처리한다.
			// 자동 회원 가입처리(DB에 앞에서 만들어준 값들로 가입처리한다.)
			memberService.setKakaoMemberInput(mid, passwordEncoder.encode(pwd), name, email);
			
			// 새로 발급된 임시비밀번호를 메일로 전송한다.
			mailSend(email, pwd, "K");	
			
			// 새로 가입처리된 회원의 정보를 다시 vo에 담아준다.
			vo = memberService.getMemberIdCheck(mid);
		} /* if구문은 처음 들어온 사람만 해당됨. 카카오 로그인으로 들어온 회원은 일반회원(default=3)이다.*/
		else {
			mid = vo.getMid();
		}
		
		// 세션처리
		String strLevel = "";
		if(vo.getLevel() == 0) strLevel = "관리자";
		else if(vo.getLevel() == 1) strLevel = "VIP";
		else if(vo.getLevel() == 2) strLevel = "Sliver";
		else if(vo.getLevel() == 3) strLevel = "일반회원";

		session.setAttribute("sMid", vo.getMid());
		session.setAttribute("sNickName", vo.getName());
		session.setAttribute("sLevel", vo.getLevel());
		session.setAttribute("strLevel", strLevel);
		
		// 최종방문일자 저장하기
		memberService.setLastDateUpdate(mid);
		
		return "redirect:/message/kakaoLoginOk?mid="+vo.getMid();
	}
	
	// 카카오 가입완료후 임시 비밀번호 메일 전송처리
	private void mailSend(String toMail, String content, String flag) throws MessagingException {
		String title = "";
		
		if(flag.equals("J")) title = "[뮤니쿤트] 회원가입 인증번호를 발급하였습니다.";
		else if(flag.equals("K")) title = "[뮤니쿤트] 임시 비밀번호를 발급하였습니다.";
		
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메일보관함에 회원이 보내온 메세지들의 정보를 모두 저장시킨후 작업처리하자...
		messageHelper.setTo(toMail);
		messageHelper.setSubject(title);
		messageHelper.setText(content);
		
		// 메세지 보관함의 내용(content)에 필요한 정보를 추가로 담아서 전송시킬수 있도록 한다.
	
		content = "<br><hr><h3>발급번호 : <font color='red'>"+content+"</font></h3><hr><br>";
		content += "<p><img src=\"cid:mailSendImg.jpg\" width='500px'></p>";
		content += "<p>방문하기 : <a href='http://49.142.157.251:9090/javaProjectS10/'>뮤니쿤트</a></p>";
		content += "<hr>";
		messageHelper.setText(content, true);
		
		// 본문에 기재된 그림파일의 경로를 별도로 표시시켜준다. 그런후, 다시 보관함에 담아준다.
		//FileSystemResource file = new FileSystemResource("D:\\javaweb\\springframework\\works\\javawebS\\src\\main\\webapp\\resources\\images\\main.jpg");
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/mailSendImg.jpg"));
		messageHelper.addInline("mailSendImg.jpg", file);

		// 메일 전송하기
		mailSender.send(message);
	}

	// 회원 로그아웃처리
	@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
	public String memberLogoutGet(HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		session.invalidate();
		
		return "redirect:/message/memberLogout?mid="+mid;
	}	
	
	// 이메일로 아이디 찾기 
	@ResponseBody
	@RequestMapping(value = "/memberEmailSearch", method = RequestMethod.POST)
	public String memberEmailSearchPost(String email) {
		//System.out.println("email : " + email);
		
		List<MemberVO> vos = memberService.getMemberEmailSearch(email);
		String res = "";
		for(MemberVO vo : vos) {
			res += vo.getMid() + "/";
		}
		if(vos.size() == 0) return "0";
		else return res;
	}
	
	// 비밀번호 찾기
	@ResponseBody
	@RequestMapping(value = "/memberPasswordSearch", method = RequestMethod.POST)
	public String memberPasswordSearch(String mid, String email) throws MessagingException {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if(vo != null && vo.getEmail().equals(email)) {
			// 정보 확인후, 임시비밀번호를 발급받아서 메일로 전송처리한다.
			UUID uid = UUID.randomUUID();
			String pwd = uid.toString().substring(0,8);
			
			// 발급받은 비밀번호를 암호화후 DB에 저장한다.
			memberService.setMemberPasswordUpdate(mid, passwordEncoder.encode(pwd));
			
			// 발급받은 임시번호를 회원 메일주소로 전송처리한다.
			String title = "[뮤니쿤트] 임시 비밀번호를 발급하였습니다.";
			String mailFlag = "임시 비밀번호 : " + pwd;
			String res = mailSend2(email, title, mailFlag);
	
			if(res == "1") return "1";
		}
		return "0";
	}
	
	//비밀번호 찾기 임시비번 메일 전송하기
	public String mailSend2(String toMail, String title, String mailFlag) throws MessagingException {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String content = "";
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender2.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		// 메일보관함에 회원이 보내온 메세지들의 정보를 모두 저장시킨후 작업처리하자...
		messageHelper.setTo(toMail);
		messageHelper.setSubject(title);
		messageHelper.setText(content);
		
		// 메세지 보관함의 내용(content)에, 발신자의 필요한 정보를 추가로 담아서 전송시켜주면 좋다....
		content = content.replace("\n", "<br>");
		content += "<br><hr><h3>"+mailFlag+"</h3><hr><br>";
		content += "<p>로그인후 비밀번호를 새로 변경하세요.</p>";
		content += "<p><img src=\"cid:mailSendImg.jpg\" width='500px'></p>";
		content += "<p>방문하기 : <a href='http://49.142.157.251:9090/javaProjectS10/'>뮤니쿤트</p>";
		content += "<hr>";
		messageHelper.setText(content, true);
		
		// 본문에 기재된 그림파일의 경로와 파일명을 별로도 표시한다. 그런후 다시 보관함에 저장한다.
		FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/mailSendImg.jpg"));
		messageHelper.addInline("mailSendImg.jpg", file);
		
		// 메일 전송하기
		mailSender2.send(message);
		
		return "1";
	}
	
	// 마이페이지 폼 보기
	@RequestMapping(value = "/memberMyPage", method = RequestMethod.GET)
	public String memberMyPageGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberIdCheck(mid);
		int gumaeInfor = productService.getGumaeInfor(mid);
		
		model.addAttribute("vo", vo);
		model.addAttribute("gumaeInfor", gumaeInfor);
		return "member/memberMyPage";
	}
	
	// 회원정보수정 폼 보기
	@RequestMapping(value= "/memberUpdate", method = RequestMethod.GET)
	public String memberUpdateGet(Model model, String mid, HttpSession session) {
	 	mid = (String) session.getAttribute("sMid");
		
		MemberVO memberVO = memberService.getMemberIdCheck(mid);
		model.addAttribute("vo", memberVO);
		return "member/memberUpdate";
	}
	
	// 회원정보수정 처리
	@RequestMapping(value= "/memberUpdate", method = RequestMethod.POST)
	public String memberUpdatePost(MemberVO vo) {
		//수정한 비밀번호 암호화하기
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		System.out.println("vo : "  + vo);
		int res = memberService.setMemberUpdate(vo);
		
		if(res != 0) return "redirect:/message/memberUpdateOk";
		else return "redirect:/message/memberUpdateNo";
	}
	
	// 회원탈퇴처리
	@RequestMapping(value = "/memberDelete", method = RequestMethod.GET)
	public String memberDelete(HttpSession session) {
		String mid =  (String) session.getAttribute("sMid");
		
		int res = memberService.setMemberDelete(mid);
		if(res != 0) {
			session.invalidate();
			return "redirect:/message/memberDeleteOk";
		}
		else return "redirect:/message/memberDeleteNo";
	}
	
	
}
