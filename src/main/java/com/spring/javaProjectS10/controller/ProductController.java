package com.spring.javaProjectS10.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS10.pagination.PageProcess;
import com.spring.javaProjectS10.pagination.PageVO;
import com.spring.javaProjectS10.service.MemberService;
import com.spring.javaProjectS10.service.ProductService;
import com.spring.javaProjectS10.vo.MemberVO;
import com.spring.javaProjectS10.vo.ProductBaesongVO;
import com.spring.javaProjectS10.vo.ProductCartVO;
import com.spring.javaProjectS10.vo.ProductOptionVO;
import com.spring.javaProjectS10.vo.ProductOrderVO;
import com.spring.javaProjectS10.vo.ProductPayMentVO;
import com.spring.javaProjectS10.vo.ProductVO;
import com.spring.javaProjectS10.vo.ReviewVO;
import com.spring.javaProjectS10.vo.WishListVO;

@Controller
@RequestMapping("/product")
public class ProductController {

	@Autowired
	ProductService productService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	PageProcess pageProcess;
	
	// 분류 등록폼 호출 및 출력
	@RequestMapping(value = "/category", method = RequestMethod.GET)
	public String dbCategoryGet(Model model) {
		List<ProductVO> middleVOS = productService.getCategoryMiddle();	// 중분류 리스트
		List<ProductVO> subVOS = productService.getCategorySub();				// 소분류 리스트
		model.addAttribute("middleVOS", middleVOS);
		model.addAttribute("subVOS", subVOS);
		
		return "admin/product/category";
	}

	// 중분류 등록하기
	@ResponseBody
	@RequestMapping(value = "/categoryMiddleInput", method = RequestMethod.POST)
	public String categoryMiddleInputPost(ProductVO vo) {
		//현재 기존에 생성된 중분류명이 있는지 체크
		ProductVO productVO = productService.getCategoryMiddleOne(vo);
		
		if(productVO != null) return "0";
		
		int res = productService.setCategoryMiddleInput(vo); //중분류 항목 저장하기
		return res+  "";
	}
	
	// 중분류 삭제하기
	@ResponseBody
	@RequestMapping(value = "/categoryMiddleDelete", method = RequestMethod.POST)
	public String categoryMiddleDeletePost(ProductVO vo) {
		//중분류 하위항목이 있는지 체크
		ProductVO subVO = productService.getCategorySubOne(vo); //삭제할 중분류항목에 소분류데이터가 있는지 검색처리
		
		if(subVO != null) return "0";
		
		int res = productService.setCategoryMiddleDelete(vo.getCategoryMiddleCode()); //중분류 항목 삭제처리
		return res + "";
	}
	
	// 소분류 등록하기
	@ResponseBody
	@RequestMapping(value = "/categorySubInput", method = RequestMethod.POST)
	public String categorySubInputPost(ProductVO vo) {
		//기존에 생성된 같은 소분류명이 있는지 체크
		ProductVO productVO = productService.getCategorySubOne(vo);
		
		if(productVO != null) return "0";
		
		int res = productService.setCategorySubInput(vo); // 소분류 항목 저장하기
		return res+"";
	}
	
	// 소분류 삭제하기
	@ResponseBody
	@RequestMapping(value = "/categorySubDelete", method = RequestMethod.POST)
	public String categorySubDeletePost(ProductVO vo) {
	//중분류 하위항목이 있는지 체크
		ProductVO categoryProdectVO = productService.getCategoryProductName(vo); //삭제할 소분류항목에 하위상품이 있는지 검색처리
		
		if(categoryProdectVO != null) return "0";
		
		int res = productService.setCategorySubDelete(vo.getCategorySubCode()); //소분류 항목 삭제처리
		return res + "";
	}
	
	// 상품등록 폼 보여주기
	@RequestMapping(value = "/productInput", method = RequestMethod.GET)
	public String productInputGet(Model model) {
		List<ProductVO> middleVOS = productService.getCategoryMiddle();	// 중분류 리스트
		model.addAttribute("middleVOS", middleVOS);
		return "admin/product/productInput";
	}
	
	// 중분류 선택시에 소분류항목명을 가져오기
	@ResponseBody
	@RequestMapping(value = "/categorySubName", method = RequestMethod.POST)
	public ArrayList<ProductVO> categorySubNamePost(String categoryMiddleCode) {
		ArrayList<ProductVO> vos = productService.getCategorySubName(categoryMiddleCode);
		return vos;
	}
	
	//관리자 상품등록시에 ckeditor에 그림을 올린다면 /admin/product폴더에 저장되고, 저장된 파일을 브라우저 textarea상자에 보여준다.
	// 파일 업로드
	@ResponseBody
	@RequestMapping("/imageUpload")
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response, @RequestParam MultipartFile upload) throws Exception {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String originalFilename = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		originalFilename = sdf.format(date) + "_" + originalFilename;
		
		byte[] bytes = upload.getBytes();
		
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/admin/product/");
		OutputStream outStr = new FileOutputStream(new File(uploadPath + originalFilename));
		outStr.write(bytes);
		
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/admin/product/" + originalFilename;
		out.println("{\"originalFilename\":\""+originalFilename+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();
		outStr.close();
	}
	
	// 상품 등록하기 처리
	@RequestMapping(value = "/productInput", method = RequestMethod.POST)
	public String productInputPost(ProductVO vo, MultipartHttpServletRequest mFile) {
		int res = productService.setProductInput(vo, mFile);
		
		if(res == 1) return "redirect:/message/productInputOk";
		else return "redirect:/message/productInputNo";
	}
	
	// 상품 리스트 보여주기
	@RequestMapping(value = "/adminProductList", method = RequestMethod.GET)
	public String adminProductListGet(Model model) {
		List<ProductVO> productVOS = productService.getAdminProductList();
		model.addAttribute("productVOS" , productVOS);
		return "admin/product/adminProductList";
	}
	
	// 관리자에서 진열된 상품을 클릭하였을경우에 해당 상품의 상세내역 보여주기
	@RequestMapping(value = "/productContent", method = RequestMethod.GET)
	public String productContentGet(Model model, int idx) {
		ProductVO productVO = productService.getProductInfo(idx);			// 상품 1건의 정보를 불러온다.
		List<ProductOptionVO> optionVOS = productService.getProductOption(idx);	// 해당 상품의 모든 옵션 정보를 가져온다.
		
		model.addAttribute("productVO", productVO);
		model.addAttribute("optionVOS", optionVOS);
		 
		return "admin/product/productContent";
	}
	
	// 옵션 등록창 보여주기(관리자 왼쪽메뉴에서 선택시 처리)
	@RequestMapping(value = "/productOption", method = RequestMethod.GET)
	public String productOptionGet(Model model) {
		List<ProductVO> middleVos = productService.getCategoryMiddle();
		model.addAttribute("middleVOS", middleVos);
		return "admin/product/productOption";
	}
	
	// 소분류 선택시에 해당 상품명(모델명)을 가져오기
	@ResponseBody
	@RequestMapping(value = "/categoryProductName", method = RequestMethod.POST)
	public List<ProductVO> categoryProductNameGet(String categoryMiddleCode, String categorySubCode) {
		return productService.getCategoryProductNameAjax(categoryMiddleCode, categorySubCode);
	}
	
	//옵셥보기에서 상품선택 콤보상자에서 상품을 선택시 해당 상품의 정보를 보여준다.
	@ResponseBody
	@RequestMapping(value = "/getProductInfor", method = RequestMethod.POST)
	public ProductVO getProductInforGet(String productName) {
		return productService.getProductInfor(productName);
	}
	
	//옵셥보기에서 '옵션보기'버튼 클릭시 해당 상품의 옵션리스트를 보여준다.
	@ResponseBody
	@RequestMapping(value = "/getOptionList", method = RequestMethod.POST)
	public List<ProductOptionVO> getOptionListPost(int productIdx) {
		List<ProductOptionVO> vos = productService.getOptionList(productIdx); 
		return vos;
	}
	
	//옵션에 기록한 내용들을 등록처리하기
	@RequestMapping(value = "/productOption", method = RequestMethod.POST)  
	public String productOptionInputPost(Model model, ProductOptionVO vo, String[] optionName, int[] optionPrice) {
		int res = 0;
		for(int i=0; i<optionName.length; i++) {
			int optionCnt = productService.getOptionSame(vo.getProductIdx(), optionName[i]);
			if(optionCnt != 0) continue;
			
			// 동일한 옵션이 없다면 vo에 현재 옵션 이름과 가격을 set시킨후 옵션테이블에 등록처리한다.
			vo.setProductIdx(vo.getProductIdx());
			vo.setOptionName(optionName[i]);
			vo.setOptionPrice(optionPrice[i]);
			
			res = productService.setProductOptionInput(vo);
		}
		if(res != 0) return "redirect:/message/OptionInputOk";
		else return "redirect:/message/OptionInputNo";
	}
	
	// 옵션항목 삭제 처리
	@ResponseBody
	@RequestMapping(value = "/optionDelete", method = RequestMethod.POST)
	public String optionDeletePost(int idx) {
		int res = productService.setOptionDelete(idx);
		return res + "";
	}
	
	// 상품 삭제 처리
	@RequestMapping(value = "/productDelete", method = RequestMethod.GET)
	public String productDeleteGet(int idx) {
		int res = productService.setProductDelete(idx);
		if(res != 0) return "redirect:/message/productDeleteOK";
		else return "redirect:/message/productDeleteNo?idx="+idx;
	}
	
	// 주문확인 폼 보기
	@RequestMapping(value="/adminOrderStatus", method = RequestMethod.GET)
	public String dbOrderProcessGet(Model model,
    @RequestParam(name="startJumun", defaultValue="", required=false) String startJumun,
    @RequestParam(name="endJumun", defaultValue="", required=false) String endJumun,
    @RequestParam(name="orderStatus", defaultValue="전체", required=false) String orderStatus
    //@RequestParam(name="pag", defaultValue="1", required=false) int pag,
    //@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize
    ) {

		List<ProductBaesongVO> vos = null;
		//PageVO pageVO = null;
		String strNow = "";
		if(startJumun.equals("")) {
			Date now = new Date();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    strNow = sdf.format(now);
	    
	    startJumun = strNow;
	    endJumun = strNow;
		}
    
    //String strOrderStatus = startJumun + "@" + endJumun + "@" + orderStatus;
    
    //pageVO = pageProcess.totRecCnt(pag, pageSize, "adminDbOrderProcess", "", strOrderStatus);

		//vos = productService.getAdminOrderStatus(pageVO.getStartIndexNo(), pageSize, startJumun, endJumun, orderStatus);
		//System.out.println("초기값 : " + startJumun +","+ endJumun +","+ orderStatus);
    vos = productService.getAdminOrderStatus(startJumun, endJumun, orderStatus);
	  //System.out.println("vos : " + vos);
	  model.addAttribute("startJumun", startJumun);
	  model.addAttribute("endJumun", endJumun);
	  model.addAttribute("orderStatus", orderStatus);
	  model.addAttribute("vos", vos);
	  //model.addAttribute("pageVO", pageVO);
	
		return "admin/product/productOrderProcess";
	}
	
	// 주문관리에서, 관리자가 주문상태를 변경처리하는것
	@ResponseBody
	@RequestMapping(value="/goodsStatus", method=RequestMethod.POST)
	public String goodsStatusGet(String orderIdx, String orderStatus) {
		int res = productService.setOrderStatusUpdate(orderIdx, orderStatus);
		return res + "";
	}

	
	
	
	// 관리자
	/*===========================================================================================*/
	// 사용자
	
	
	

	// 사용자 상품 리스트 폼 보여주기
	@RequestMapping(value = "/productList", method = RequestMethod.GET)
	public String productListGet(Model model,
			@RequestParam(name="part", defaultValue = "ALL", required = false) String part,
			@RequestParam(name="search", defaultValue = "title", required = false) String search, 
  		@RequestParam(name="searchString", defaultValue = "", required = false) String searchString, 
  		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
  		@RequestParam(name="pageSize", defaultValue = "12", required = false) int pageSize) {
			// 중분류명을 가져온다.
			PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "productList", part, searchString);
		
			List<ProductVO> middleTitleVOS = productService.getMiddleTitle();
			model.addAttribute("middleTitleVOS", middleTitleVOS);
			
			// 전체(부분,part) 상품리스트 가져오기
			List<ProductVO> productVOS = productService.getProductList(pageVO.getStartIndexNo(), pageSize, part);
			model.addAttribute("productVOS", productVOS);
			model.addAttribute("pageVO", pageVO);
			
		return "product/productList";
	}
	
	//진열된 상품클릭시 해당상품의 상세정보 보여주기(사용자(고객)화면에서 보여주기)
	@RequestMapping(value="/productContentShop", method=RequestMethod.GET)
	public String dbProductContentShopGet(int idx, Model model) {
		ProductVO productVO = productService.getProductInfo(idx);			// 상품의 상세정보 불러오기
		List<ProductOptionVO> optionVOS = productService.getProductOption(idx);	// 옵션의 모든 정보 불러오기
		
		model.addAttribute("productVO", productVO);
		model.addAttribute("optionVOS", optionVOS);
		
		return "product/productContentShop";
	}

	// 상품 상세정보보기창에서 '장바구니'버튼을 클릭시에 처리하는곳
	@RequestMapping(value="/productContentShop", method=RequestMethod.POST)
	public String productContentShopPost(ProductCartVO vo, HttpSession session, String flag) {
		if(flag.equals("order")) {
			session.setAttribute("sProductCartVO", vo);
			return "redirect:/message/cartOrderOk";
		}
		String mid = (String) session.getAttribute("sMid");
		ProductCartVO resVo = productService.getProductShopCartOptionSearch(vo.getProductName(), vo.getOptionName(), mid);
		
		// 기존 장바구니에 담긴 상품이 있을 경우, 해당 상품의 옵션수량을 업데이트처리
		int res = 0;
		if(resVo != null) {
			String[] voOptionNums = vo.getOptionNum().split(",");
			String[] resOptionNums = resVo.getOptionNum().split(",");
			int[] nums = new int[99];
			String strNums = "";
			for(int i=0; i<voOptionNums.length; i++) {
				nums[i] += (Integer.parseInt(voOptionNums[i]) + Integer.parseInt(resOptionNums[i]));
				strNums += nums[i];
				if(i < nums.length - 1) strNums += ",";
			}
			vo.setOptionNum(strNums);
			res = productService.setProductShopCartUpdate(vo);
		}
		// 기존 장바구니에 담긴 상품이 없을 경우 추가하기
		else {
			res = productService.setProductShopCartInput(vo);
		}
		
		if(res != 0) {
			if(flag.equals("order")) {
				return "redirect:/message/cartOrderOk";
			}
			else {
				return "redirect:/message/cartInputOk?idx="+vo.getProductIdx();
			}
		}
		else return "redirect:/message/cartOrderNo?idx="+vo.getProductIdx();
	}
	  
	// 장바구니 보기
	@RequestMapping(value="/productCartList", method=RequestMethod.GET)
	public String dbCartGet(HttpSession session, ProductCartVO vo, Model model) {
		String mid = (String) session.getAttribute("sMid");
		List<ProductCartVO> vos = productService.getProductCartList(mid);
		
		if(vos.size() == 0) {
			return "redirect:/message/cartEmpty";
		}
		
		model.addAttribute("cartListVOS", vos);
		return "product/productCartList";
	} 
	
	
	//장바구니에서 주문 취소한 상품을 장바구니에서 삭제시켜주기
	@ResponseBody
	@RequestMapping(value="/productCartDelete", method=RequestMethod.POST)
	public String productCartDeleteGet(int idx) {
		int res = productService.productCartDelete(idx);
		return res + "";
	}
	
	//장바구니에서 '주문하기' 버튼을 클릭시에 처리할 부분
	@RequestMapping(value="/productCartList", method=RequestMethod.POST)
	public String productCartListPost(HttpServletRequest request, HttpSession session, Model model,
			@RequestParam(name="baesong", defaultValue="0", required=false) int baesong) {
		String mid = (String) session.getAttribute("sMid");
		
	 // 주문한 상품에 대한 '고유번호'를 만들어준다.
	 ProductOrderVO maxIdx = productService.getOrderMaxIdx();
	 int idx = 1;
   if(maxIdx != null) idx = maxIdx.getMaxIdx() + 1;

   Date today = new Date();
   SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
   String orderIdx = sdf.format(today) + idx;

   // 장바구니에서 구매를 위해 선택한 모든 항목들은 배열로 넘어온다.
   String[] idxChecked = request.getParameterValues("idxChecked");

   ProductCartVO cartVo = new ProductCartVO();
   List<ProductOrderVO> orderVOS = new ArrayList<ProductOrderVO>();
   
		for (String strIdx : idxChecked) {
     cartVo = productService.getCartIdx(Integer.parseInt(strIdx));
     ProductOrderVO orderVo = new ProductOrderVO();
     orderVo.setProductIdx(cartVo.getProductIdx());
     orderVo.setProductName(cartVo.getProductName());
     orderVo.setMainPrice(cartVo.getMainPrice());
     orderVo.setThumbImg(cartVo.getThumbImg());
     orderVo.setOptionName(cartVo.getOptionName());
     orderVo.setOptionPrice(cartVo.getOptionPrice());
     orderVo.setOptionNum(cartVo.getOptionNum());
     orderVo.setTotalPrice(cartVo.getTotalPrice());
     orderVo.setCartIdx(cartVo.getIdx());
     orderVo.setBaesong(baesong);
     orderVo.setOrderIdx(orderIdx); 
     orderVo.setMid(mid);

     orderVo.setCategorySubName(cartVo.getCategorySubName());
     orderVOS.add(orderVo);
   }
   session.setAttribute("sOrderVOS", orderVOS);
   
   // 배송처리를 위한 현재 로그인한 아이디에 해당하는 고객의 정보를 member에서 가져온다.
   MemberVO memberVO = memberService.getMemberIdCheck(mid);
   model.addAttribute("memberVO", memberVO);
		return "product/productOrder";
	}
	
	// 상품페이지에서 '주문하기' 버튼을 클릭시에 처리할 부분 (바로 주문창으로 가기:주문1건만 담김)
	@RequestMapping(value="/productOrder", method=RequestMethod.GET)
	public String productOrderGet(HttpServletRequest request, HttpSession session, Model model,
			@RequestParam(name="baesong", defaultValue="0", required=false) int baesong) {
		String mid = (String) session.getAttribute("sMid");
		ProductCartVO vo = (ProductCartVO) session.getAttribute("sProductCartVO");
		//session.removeAttribute("sProductCartVO");
		
		//productService.getCategorySubName(cVo.getCategorySubName());
		
		// 주문한 상품에 대한 '고유번호'를 만들어준다.
		ProductOrderVO maxIdx = productService.getOrderMaxIdx();
		int idx = 1;
		if(maxIdx != null) idx = maxIdx.getMaxIdx() + 1;
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String orderIdx = sdf.format(today) + idx;
		
		vo.setOrderIdx(orderIdx);
		model.addAttribute("vo" , vo);
	
		// 배송처리를 위한 현재 로그인한 아이디에 해당하는 고객의 정보를 member에서 가져온다.
		MemberVO memberVO = memberService.getMemberIdCheck(mid);
		model.addAttribute("memberVO", memberVO);
		
		return "product/productOrderDirect";
	}
	
	// 결제시스템(결제창 호출) - 결제 API이용
	@RequestMapping(value="/payment", method=RequestMethod.POST)
	public String paymentPost(ProductOrderVO orderVo, ProductPayMentVO payMentVO, ProductBaesongVO baesongVO, HttpSession session, Model model) {
		ProductCartVO vo = (ProductCartVO) session.getAttribute("sProductCartVO");
		if(vo == null) payMentVO.setName(payMentVO.getName());
		else payMentVO.setName(vo.getProductName());
		
		model.addAttribute("payMentVO", payMentVO);
		
		session.setAttribute("sPayMentVO", payMentVO);
		session.setAttribute("sBaesongVO", baesongVO);
		
		return "product/productPaymentOk";
	}
	
	// 결제완료후 주문내역을 '주문테이블'에 저장처리한다. - 주문/결제된 물품은 장바구니에서 제거시켜준다. 사용한 세션은 제거시킨다.
	@Transactional
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/productPaymentResult", method=RequestMethod.GET)
	public String paymentResultGet(HttpSession session, ProductPayMentVO receivePayMentVO, Model model) {
		List<ProductOrderVO> orderVOS = (List<ProductOrderVO>) session.getAttribute("sOrderVOS");
		ProductPayMentVO payMentVO = (ProductPayMentVO) session.getAttribute("sPayMentVO");
		ProductBaesongVO baesongVO = (ProductBaesongVO) session.getAttribute("sBaesongVO");
		session.removeAttribute("sBaesongVO");
		
		ProductCartVO productCartVO = (ProductCartVO) session.getAttribute("sProductCartVO");
		session.removeAttribute("sProductCartVO");
		
		if(productCartVO != null) {
//			vo.setIdx(Integer.parseInt(vo.getOrderIdx().substring(8)));	
//			vo.setOrderIdx(vo.getOrderIdx());
//			vo.setMid(vo.getMid());							
//			
			ProductOrderVO vo = new ProductOrderVO();
			vo.setOrderIdx(productCartVO.getOrderIdx());
			vo.setMid(productCartVO.getMid());
			vo.setProductIdx(productCartVO.getProductIdx());
			vo.setProductName(productCartVO.getProductName());
			vo.setMainPrice(productCartVO.getMainPrice());
			vo.setThumbImg(productCartVO.getThumbImg());
			vo.setOptionName(productCartVO.getOptionName());
			vo.setOptionPrice(productCartVO.getOptionPrice());
			vo.setOptionNum(productCartVO.getOptionNum());
			vo.setTotalPrice(productCartVO.getTotalPrice());
			
			if(productCartVO.getTotalPrice() < 60000) baesongVO.setOrderTotalPrice(productCartVO.getTotalPrice() + 3000);
			else baesongVO.setOrderTotalPrice(productCartVO.getTotalPrice());
			
			productService.setMemberPointPlus((int)(productCartVO.getTotalPrice() * 0.01), productCartVO.getMid());
			
			baesongVO.setOIdx(Integer.parseInt(productCartVO.getOrderIdx().substring(8)));	
			baesongVO.setOrderIdx(productCartVO.getOrderIdx());
			baesongVO.setName(productCartVO.getProductName());
			
			productService.setProductOrder(vo);		// 주문/결제 처리된 내용을 주문테이블(dbOrder)에 저장시킨다.
//			productService.setProductCartDeleteAll(vo.getCartIdx());	// 주문이 완료되었기에 장바구니테이블에서 주문한 내역을 삭제한다.
		}
		else {
			for(ProductOrderVO vo : orderVOS) {
				vo.setIdx(Integer.parseInt(vo.getOrderIdx().substring(8)));	
				vo.setOrderIdx(vo.getOrderIdx());
				vo.setMid(vo.getMid());							
				
				productService.setProductOrder(vo);		// 주문/결제 처리된 내용을 주문테이블(dbOrder)에 저장시킨다.
				productService.setProductCartDeleteAll(vo.getCartIdx());	// 주문이 완료되었기에 장바구니테이블에서 주문한 내역을 삭제한다.
				
			}
			// 주문된 정보중 누락된 정보를 배송테이블에 담기위한 처리작업
			baesongVO.setOIdx(orderVOS.get(0).getIdx());
			baesongVO.setOrderIdx(orderVOS.get(0).getOrderIdx());
			baesongVO.setBuyer_addr(payMentVO.getBuyer_addr());
			baesongVO.setBuyer_tel(payMentVO.getBuyer_tel());
			
			int totalBaesongOrder = 0;
			for(int i=0; i<orderVOS.size(); i++) {
				totalBaesongOrder += orderVOS.get(i).getTotalPrice();
			}
		
			// 총 주문금액이 6만원 미만이면, 배송비를 3000원으로 추가시킨다.
			if(totalBaesongOrder < 60000) baesongVO.setOrderTotalPrice(totalBaesongOrder + 3000);
			else baesongVO.setOrderTotalPrice(totalBaesongOrder);
			
			productService.setMemberPointPlus((int)(baesongVO.getOrderTotalPrice() * 0.01), orderVOS.get(0).getMid());
		}
		
		productService.setProductBaesong(baesongVO);	// 배송내역을 배송테이블(dbBaesong)에 저장한다.
		
		payMentVO.setImp_uid(receivePayMentVO.getImp_uid());
		payMentVO.setMerchant_uid(receivePayMentVO.getMerchant_uid());
		payMentVO.setPaid_amount(receivePayMentVO.getPaid_amount());
		payMentVO.setApply_num(receivePayMentVO.getApply_num());
		
		// 오늘 주문에 들어간 정보들을 확인해주기위해 다시 session에 담아서 넘겨주고 있다.
		session.setAttribute("sPayMentVO", payMentVO);
		session.setAttribute("orderTotalPrice", baesongVO.getOrderTotalPrice());
		
		return "redirect:/message/paymentResultOk";
	}
	
	// 결제처리 
	@SuppressWarnings({ "unchecked" })
	@RequestMapping(value="/paymentResultOk", method=RequestMethod.GET)
	public String paymentResultOkGet(HttpSession session, Model model) {
		List<ProductOrderVO> orderVOS = (List<ProductOrderVO>) session.getAttribute("sOrderVOS");
		model.addAttribute("orderVOS", orderVOS);
		session.removeAttribute("sOrderVOS");
		
		int totalBaesongOrder = productService.getTotalBaesongOrder(orderVOS.get(orderVOS.size()-1).getOrderIdx());
		model.addAttribute("totalBaesongOrder", totalBaesongOrder);
		
		return "product/productPaymentResult";
	}
	
	// 사용자 주문 조회 폼 보기
	@RequestMapping(value="/productMyOrder", method=RequestMethod.GET)
	public String myOrderStatusGet(Model model, HttpServletRequest request, HttpSession session, 
			String startJumun, String endJumun, 
//			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
//			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
  	  @RequestParam(name="conditionOrderStatus", defaultValue="전체", required=false) String conditionOrderStatus) {
		String mid = (String) session.getAttribute("sMid");
		int level = (int) session.getAttribute("sLevel");
		
		Date today = new Date();
		SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd");
		String strDate = sdf.format(today);
		if(startJumun == null) startJumun = strDate;
		if(endJumun == null) endJumun = strDate;
		
		if(level == 0) mid = "전체";
//		String searchString = startJumun + "@" + endJumun + "@" + conditionOrderStatus;
//		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myOrderStatus", mid, searchString);  // 4번째인자에 '아이디/조건'(을)를 넘겨서 part를 아이디로 검색처리하게 한다.
//		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myOrderStatus", mid, searchString);  // 4번째인자에 '아이디/조건'(을)를 넘겨서 part를 아이디로 검색처리하게 한다.
		//System.out.println("초기값 : " + startJumun +","+ endJumun);
//		List<DbBaesongVO> vos = dbShopService.getMyOrderStatus(pageVO.getStartIndexNo(), pageSize, mid, startJumun, endJumun, conditionOrderStatus);
		List<ProductBaesongVO> vos = productService.getMyOrderStatus(mid, startJumun, endJumun, conditionOrderStatus);
		//System.out.println("VOS : " + vos);
		model.addAttribute("vos", vos);				
		model.addAttribute("startJumun", startJumun);
		model.addAttribute("endJumun", endJumun);
		model.addAttribute("conditionOrderStatus", conditionOrderStatus);
		//model.addAttribute("pageVO", pageVO);
		
		return "product/productMyOrder";
	}	
	
	// 배송지 출력
	@RequestMapping(value="/productOrderBaesong", method=RequestMethod.GET)
	public String productOrderBaesongGet(String orderIdx, Model model) {
		List<ProductBaesongVO> vos = productService.getOrderBaesong(orderIdx);
		
		ProductBaesongVO vo = vos.get(0);
		String payMethod = "";
		if(vo.getPayment().substring(0,1).equals("C")) payMethod = "카드결제";
		else payMethod = "은행(무통장)결제";
		
		model.addAttribute("payMethod", payMethod);
		model.addAttribute("vo", vo);
		
		return "product/productOrderBaesong";
	}
	
	// 위시리스트 폼 보기
	@RequestMapping(value="/wishList", method = RequestMethod.GET)
	public String wishListGet(Model model) {
		List<WishListVO> vos = productService.getWishList();
		model.addAttribute("vos", vos);
		return "product/wishList";
	}
	
	// 위시리스트 저장하기
	@ResponseBody
	@RequestMapping(value = "/wishListInput", method = RequestMethod.POST)
	public String wishListInputGet(HttpSession session, String productCode, String options, int totalPrice, int productIdx) {
		String mid = (String) session.getAttribute("sMid");
		int res = productService.setWishListInput(productCode, options, mid, totalPrice, productIdx);
		return res + "";
	}
	
	// 위시리스트 삭제하기
	@RequestMapping(value = "/wishDeleteOk", method = RequestMethod.GET)
	public String wishDeleteOkGet(int idx, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		int res = productService.setWishDeleteOk(idx);
		
		if(res != 0) return "redirect:/message/wishDeleteOk?mid="+mid;
		else return "redirect:/message/wishDeleteNo?mid="+mid;
	}
	
	// 위시리스트에서 주문하기 처리
	@RequestMapping(value="/wishOrder", method=RequestMethod.GET)
	public String wishOrderPost(Model model,
			@RequestParam(name="idx", defaultValue = "0", required = false) int wIdx) {
		WishListVO wVo = productService.getWishListOrder(wIdx);
		//System.out.println("wVo : " + wVo);
		
		String optionNames = "";
		String optionNums = "";
		String optionPrices = "";
		//int cnt = 0;
		String[] optionGroup = wVo.getOptions().split("/");
		for(String option:optionGroup) {
			String[] options = option.split(":");
			optionNames += options[0] + ",";
			optionNums += options[1] + ",";
			optionPrices += options[2] + ",";
			//cnt++;
		}
		optionNames = optionNames.substring(0,optionNames.length()-1);
		optionNums = optionNums.substring(0,optionNums.length()-1);
		optionPrices = optionPrices.substring(0,optionPrices.length()-1);
		
		
		ProductCartVO vo = new ProductCartVO();
		vo.setMid(wVo.getMid());
		vo.setProductIdx(wVo.getProductIdx());
		vo.setProductName(wVo.getProductName());
		vo.setMainPrice(wVo.getMainPrice());
		vo.setThumbImg(wVo.getFSName());
		vo.setOptionName(optionNames);
		vo.setOptionPrice(optionPrices);
		vo.setOptionNum(optionNums);
		vo.setTotalPrice(wVo.getTotalPrice());
		vo.setCategorySubName(wVo.getCategorySubName());
		
		// 주문한 상품에 대한 '고유번호'를 만들어준다.
		ProductOrderVO maxIdx = productService.getOrderMaxIdx();
		int idx = 1;
		if(maxIdx != null) idx = maxIdx.getMaxIdx() + 1;
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String orderIdx = sdf.format(today) + idx;
		
		vo.setOrderIdx(orderIdx);
		model.addAttribute("vo" , vo);
		
		// 배송처리를 위한 현재 로그인한 아이디에 해당하는 고객의 정보를 member에서 가져온다.
		MemberVO memberVO = memberService.getMemberIdCheck(wVo.getMid());
		model.addAttribute("memberVO", memberVO);
		
		return "product/productOrderDirect";
	}
	
	// 주문조회창에서 배송완료상품 구매확정 버튼 눌렀을 때, 주문상태 '구매확정'으로 변경하기
	@ResponseBody
	@RequestMapping(value = "/productOrderOk", method = RequestMethod.POST)
	public String productOrderOkPost(String orderIdx) {
		int res = productService.setOrderStatusUpdate(orderIdx, "구매확정");
		return res+"";
	}

	
}
