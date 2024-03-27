package com.spring.javaProjectS10.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaProjectS10.service.ProductService;
import com.spring.javaProjectS10.vo.ProductOrderVO;
import com.spring.javaProjectS10.vo.ProductVO;

@Controller
public class HomeController {
	@Autowired 
	ProductService productservice;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	// mainHome 보여주기
	@RequestMapping(value = {"/","h"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model, ProductOrderVO vo) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		// 주문순으로 상품 내림차순 정렬하여 출력하기
		//List<ProductVO> vos = productservice.getAdminProductList();
		List<ProductOrderVO> vos = productservice.getMainProductList();
		
		model.addAttribute("vos", vos);
		
		return "home";
	}
	
	@RequestMapping(value="/imageUpload")
	public void imageUploadGet(MultipartFile upload,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		String oFileName = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		oFileName = sdf.format(date) + "_" + oFileName;
		
		byte[] bytes = upload.getBytes();
		FileOutputStream fos = new FileOutputStream(new File(realPath+oFileName));
		fos.write(bytes);
		
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + oFileName;
		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();
		fos.close();
	}	
	
}
