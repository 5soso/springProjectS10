package com.spring.javaProjectS10.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS10.dao.ProductDAO;
import com.spring.javaProjectS10.vo.ProductBaesongVO;
import com.spring.javaProjectS10.vo.ProductCartVO;
import com.spring.javaProjectS10.vo.ProductOptionVO;
import com.spring.javaProjectS10.vo.ProductOrderVO;
import com.spring.javaProjectS10.vo.ProductVO;
import com.spring.javaProjectS10.vo.ReviewVO;
import com.spring.javaProjectS10.vo.WishListVO;

@Service
public class ProductServiceImpl implements ProductService {

	@Autowired
	ProductDAO productDAO;

	@Override
	public ProductVO getCategoryMiddleOne(ProductVO vo) {
		return productDAO.getCategoryMiddleOne(vo);
	}

	@Override
	public int setCategoryMiddleInput(ProductVO vo) {
		return productDAO.setCategoryMiddleInput(vo);
	}

	@Override
	public List<ProductVO> getCategoryMiddle() {
		return productDAO.getCategoryMiddle();
	}

	@Override
	public ProductVO getCategorySubOne(ProductVO vo) {
		return productDAO.getCategorySubOne(vo);
	}

	@Override
	public int setCategoryMiddleDelete(String categoryMiddleCode) {
		return productDAO.setCategoryMiddleDelete(categoryMiddleCode);
	}

	@Override
	public int setCategorySubInput(ProductVO vo) {
		return productDAO.setCategorySubInput(vo);
	}

	@Override
	public List<ProductVO> getCategorySub() {
		return productDAO.getCategorySub();
	}

	@Override
	public ProductVO getCategoryProductName(ProductVO vo) {
		return productDAO.getCategoryProductName(vo);
	}

	@Override
	public int setCategorySubDelete(String categorySubCode) {
		return productDAO.setCategorySubDelete(categorySubCode);
	}

	@Override
	public ArrayList<ProductVO> getCategorySubName(String categoryMiddleCode) {
		return productDAO.getCategorySubName(categoryMiddleCode);
	}

	@Override
	public int setProductInput(ProductVO vo, MultipartHttpServletRequest mFile) {
	  // 서비스 객체에서 파일 업로드를 한다. 정상적으로 업로드되면 vo에 담아 보낸다.
		int res = 0;
		
		try {
			List<MultipartFile> fileList = mFile.getFiles("file");
			String sFileNames = "";
			
			for(MultipartFile file : fileList) {
				String sFileName = saveFileName(file.getOriginalFilename());
			
				writeFile(file, sFileName); //뒤에 변수이름으로 file 하나를 저장한다.
				
				sFileNames += sFileName + "/";
			}
			sFileNames = sFileNames.substring(0, sFileNames.length()-1);
			
			vo.setFSName(sFileNames);
			
			// 상품 고유번호 만들기 위한 idx값 결정하기
			int maxIdx = 1;
	    ProductVO maxVo = productDAO.getProductMaxIdx();
	    if(maxVo != null) maxIdx = maxVo.getIdx() + 1;
	    
	    vo.setIdx(maxIdx);
			vo.setProductCode(vo.getCategoryMiddleCode()+vo.getCategorySubCode()+vo.getIdx());
			
			res = productDAO.setProductInput(vo);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	private void writeFile(MultipartFile file, String sFileName) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/admin/product/");
		
		byte[] data = file.getBytes();
		FileOutputStream fos = new FileOutputStream(realPath + sFileName); //저장은 output, 클라이언트에서 사진을 보내서 저장하는 중
		fos.write(data);
		fos.close();
	}

	// file명 중복방지를 위한 서버에 저장될 실제 파일명 만들기
	private String saveFileName(String oFileName) {
		String fileName = "";
		
		Calendar cal = Calendar.getInstance();
		fileName += cal.get(Calendar.YEAR);
		fileName += cal.get(Calendar.MONTH);
		fileName += cal.get(Calendar.DATE);
		fileName += cal.get(Calendar.HOUR);
		fileName += cal.get(Calendar.MINUTE);
		fileName += cal.get(Calendar.SECOND);
		fileName += cal.get(Calendar.MILLISECOND);
		fileName += "_" + oFileName;
		
		return fileName;
	}

	@Override
	public List<ProductVO> getAdminProductList() {
		return productDAO.getAdminProductList();
	}

	@Override
	public ProductVO getProductInfo(int idx) {
		return productDAO.getProductInfo(idx);
	}

	@Override
	public List<ProductVO> getCategoryProductNameAjax(String categoryMiddleCode, String categorySubCode) {
		return productDAO.getCategoryProductNameAjax(categoryMiddleCode, categorySubCode);
	}

	@Override
	public ProductVO getProductInfor(String productName) {
		return productDAO.getProductInfor(productName);
	}

	@Override
	public List<ProductOptionVO> getProductOption(int idx) {
		return productDAO.getProductOption(idx);
	}
	
	@Override
	public List<ProductOptionVO> getOptionList(int productIdx) {
		return productDAO.getOptionList(productIdx);
	}

	@Override
	public int getOptionSame(int productIdx, String optionName) {
		return productDAO.getOptionSame(productIdx, optionName);
	}

	@Override
	public int setProductOptionInput(ProductOptionVO vo) {
		return productDAO.setProductOptionInput(vo);
	}

	@Override
	public int setOptionDelete(int idx) {
		return productDAO.setOptionDelete(idx);
	}

	@Transactional
	@Override
	public int setProductDelete(int idx) {
		//파일 지우기
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/admin/product/");
		
		ProductVO vo = productDAO.getProductInfo(idx);
		
		// 파일 삭제 처리
		String[] fSNames = vo.getFSName().split("/");
		
		// 서버에 저장된 실제 파일을 삭제처리
		for(int i=0; i<fSNames.length; i++) {
				System.out.println("fSNames[i] : "  + fSNames[i]);
			new File(realPath+fSNames[i]).delete();
		}
		
//	      0					1					2					3					4					5					
//				012345678901234567890123456789012345678901234567890
//<p><img src="/javaProjectS10/data/admin/product/240111191846_c2_c.jpg" style="height:8190px; width:308px" /></p>
		
		//상세정보(이미지) 지우기
		int position = 40;
		String nextImg = vo.getContent().substring(vo.getContent().indexOf("src=\"/") + position);
		String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
		new File(realPath+imgFile).delete();
		System.out.println("imgFile : "  + imgFile);
		
		// 선택 상품 옵션 지우고 상품 지우기
		int res = 0;
		res = productDAO.setProductOptionDelete(idx);
		if(res != 0) res = productDAO.setProductDelete(idx);
		
		return res;
	}
	
	/* 사용자... */

	@Override
	public List<ProductVO> getProductList(String part) {
		return productDAO.getProductList(part);
	}

	@Override
	public List<ProductVO> getMiddleTitle() {
		return productDAO.getMiddleTitle();
	}

	@Override
	public ProductCartVO getProductShopCartOptionSearch(String productName, String optionName, String mid) {
		return productDAO.getProductShopCartOptionSearch(productName, optionName, mid);
	}

	@Override
	public int setProductShopCartUpdate(ProductCartVO vo) {
		return productDAO.setProductShopCartUpdate(vo);
	}

	@Override
	public int setProductShopCartInput(ProductCartVO vo) {
		return productDAO.setProductShopCartInput(vo);
	}

	@Override
	public List<ProductCartVO> getProductCartList(String mid) {
		return productDAO.getProductCartList(mid);
	}

	@Override
	public int productCartDelete(int idx) {
		return productDAO.productCartDelete(idx);
	}

	@Override
	public ProductOrderVO getOrderMaxIdx() {
		return productDAO.getOrderMaxIdx();
	}

	@Override
	public ProductCartVO getCartIdx(int strIdx) {
		return productDAO.getCartIdx(strIdx);
	}

	@Override
	public void setProductOrder(ProductOrderVO vo) {
		productDAO.setProductOrder(vo);
	}

	@Override
	public void setProductCartDeleteAll(int cartIdx) {
		productDAO.setProductCartDeleteAll(cartIdx);
	}

	@Override
	public void setProductBaesong(ProductBaesongVO baesongVO) {
		productDAO.setProductBaesong(baesongVO);
	}

	@Override
	public void setMemberPointPlus(int point, String mid) {
		productDAO.setMemberPointPlus(point, mid);
	}

	@Override
	public int getTotalBaesongOrder(String orderIdx) {
		return productDAO.getTotalBaesongOrder(orderIdx);
	}

	@Override
	public List<ProductBaesongVO> getAdminOrderStatus(String startJumun, String endJumun, String orderStatus) {
		return productDAO.getAdminOrderStatus(startJumun, endJumun, orderStatus);
	}

	@Override
	public int setOrderStatusUpdate(String orderIdx, String orderStatus) {
		return productDAO.setOrderStatusUpdate(orderIdx, orderStatus);
	}

	@Override
	public List<ProductBaesongVO> getMyOrderStatus(String mid, String startJumun, String endJumun,
			String conditionOrderStatus) {
		return productDAO.getMyOrderStatus(mid, startJumun, endJumun, conditionOrderStatus);
	}

	@Override
	public List<ProductBaesongVO> getOrderBaesong(String orderIdx) {
		return productDAO.getOrderBaesong(orderIdx);
	}

	@Override
	public int setWishListInput(String productCode, String options, String mid, int totalPrice, int productIdx) {
		return productDAO.setWishListInput(productCode, options, mid, totalPrice, productIdx);
	}

	@Override
	public List<WishListVO> getWishList() {
		return productDAO.getWishList();
	}

	@Override
	public int setWishDeleteOk(int idx) {
		return productDAO.setWishDeleteOk(idx);
	}

	@Override
	public WishListVO getWishListOrder(int idx) {
		return productDAO.getWishListOrder(idx);
	}

	@Override
	public List<ProductOrderVO> getMainProductList() {
		return productDAO.getMainProductList();
	}

	@Override
	public List<ProductOrderVO> getProductOrderIdx(String orderIdx) {
		return productDAO.getProductOrderIdx(orderIdx);
	}

	@Override
	public int setReviewInput(ReviewVO vo, MultipartFile reImg) {
		int res = 0;
		
		if(reImg != null) {
			UUID uid = UUID.randomUUID();
			String oFileName = reImg.getOriginalFilename();
			String sFileName = vo.getMid() + "_" + uid + "_" + oFileName;
			System.out.println("sFileName : " + sFileName);
			// 파일복사처리(서버 메모리에 올라와 있는 파일의 정보를 실제 서버 파일시스템에 저장시킨다.)
			try {
				writeFile2(reImg, sFileName);
				vo.setReImage(sFileName);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		res = productDAO.setReviewInput(vo);
		
		return res;
	}

	private void writeFile2(MultipartFile reImage, String sFileName) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/admin/review/");
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		if((reImage.getBytes().length) != -1) {
			fos.write(reImage.getBytes());
		}
		fos.flush();
		fos.close();
	}

	@Override
	public List<ReviewVO> getProductReview() {
		return productDAO.getProductReview();
	}

	@Override
	public List<ReviewVO> getProductReviewSearch(String reviewSearch) {
		return productDAO.getProductReviewSearch(reviewSearch);
	}

	@Override
	public List<ReviewVO> getProductReviewChange(String reviewChange, int startIndexNo, int pageSize) {
		return productDAO.getProductReviewChange(reviewChange, startIndexNo, pageSize);
	}

	@Override
	public List<ProductVO> getProductList(int startIndexNo, int pageSize, String part) {
		return productDAO.getProductList(startIndexNo, pageSize, part);
	}

	@Override
	public int getGumaeInfor(String mid) {
		return productDAO.getGumaeInfor(mid);
	}

	@Override
	public List<ReviewVO> getProductReview(int startIndexNo, int pageSize, String reviewChange) {
		return productDAO.getProductReview(startIndexNo, pageSize, reviewChange);
	}

}
