package com.spring.javaProjectS10.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaProjectS10.vo.ProductOptionVO;
import com.spring.javaProjectS10.vo.ProductOrderVO;
import com.spring.javaProjectS10.vo.ProductVO;
import com.spring.javaProjectS10.vo.ReviewVO;
import com.spring.javaProjectS10.vo.WishListVO;
import com.spring.javaProjectS10.vo.ProductBaesongVO;
import com.spring.javaProjectS10.vo.ProductCartVO;

public interface ProductService {

	public ProductVO getCategoryMiddleOne(ProductVO vo);

	public int setCategoryMiddleInput(ProductVO vo);

	public List<ProductVO> getCategoryMiddle();

	public ProductVO getCategorySubOne(ProductVO vo);

	public int setCategoryMiddleDelete(String categoryMiddleCode);

	public int setCategorySubInput(ProductVO vo);

	public List<ProductVO> getCategorySub();

	public ProductVO getCategoryProductName(ProductVO vo);

	public int setCategorySubDelete(String categorySubCode);

	public ArrayList<ProductVO> getCategorySubName(String categoryMiddleCode);

	public int setProductInput(ProductVO vo, MultipartHttpServletRequest mFile);

	public List<ProductVO> getAdminProductList();

	public ProductVO getProductInfo(int idx);
	
	public List<ProductOptionVO> getProductOption(int idx);

	public List<ProductVO> getCategoryProductNameAjax(String categoryMiddleCode, String categorySubCode);

	public ProductVO getProductInfor(String productName);

	public List<ProductOptionVO> getOptionList(int productIdx);

	public int getOptionSame(int productIdx, String optionName);

	public int setProductOptionInput(ProductOptionVO vo);

	public int setOptionDelete(int idx);

	public int setProductDelete(int idx);

	public List<ProductVO> getProductList(String part);

	public List<ProductVO> getMiddleTitle();

	public ProductCartVO getProductShopCartOptionSearch(String productName, String optionName, String mid);

	public int setProductShopCartUpdate(ProductCartVO vo);

	public int setProductShopCartInput(ProductCartVO vo);

	public List<ProductCartVO> getProductCartList(String mid);

	public int productCartDelete(int idx);

	public ProductOrderVO getOrderMaxIdx();

	public ProductCartVO getCartIdx(int strIdx);

	public void setProductOrder(ProductOrderVO vo);

	public void setProductCartDeleteAll(int cartIdx);

	public void setProductBaesong(ProductBaesongVO baesongVO);

	public void setMemberPointPlus(int point, String mid);

	public int getTotalBaesongOrder(String orderIdx);

	public List<ProductBaesongVO> getAdminOrderStatus(String startJumun, String endJumun, String orderStatus);

	public int setOrderStatusUpdate(String orderIdx, String orderStatus);

	public List<ProductBaesongVO> getMyOrderStatus(String mid, String startJumun, String endJumun,
			String conditionOrderStatus);

	public List<ProductBaesongVO> getOrderBaesong(String orderIdx);

	public int setWishListInput(String productCode, String options, String mid, int totalPrice, int productIdx);

	public List<WishListVO> getWishList();

	public int setWishDeleteOk(int idx);

	public WishListVO getWishListOrder(int idx);

	public List<ProductOrderVO> getMainProductList();

	public List<ProductOrderVO> getProductOrderIdx(String orderIdx);

	public int setReviewInput(ReviewVO vo, MultipartFile reImage);

	public List<ReviewVO> getProductReview();

	public List<ReviewVO> getProductReviewSearch(String reviewSearch);

	public List<ReviewVO> getProductReviewChange(String reviewChange, int startIndexNo, int pageSize);

	public List<ProductVO> getProductList(int startIndexNo, int pageSize, String part);

	public int getGumaeInfor(String mid);

	public List<ReviewVO> getProductReview(int startIndexNo, int pageSize, String reviewChange);


}
