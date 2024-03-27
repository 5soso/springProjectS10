package com.spring.javaProjectS10.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaProjectS10.vo.ProductOptionVO;
import com.spring.javaProjectS10.vo.ProductOrderVO;
import com.spring.javaProjectS10.vo.ProductVO;
import com.spring.javaProjectS10.vo.ReviewVO;
import com.spring.javaProjectS10.vo.WishListVO;
import com.spring.javaProjectS10.vo.ProductBaesongVO;
import com.spring.javaProjectS10.vo.ProductCartVO;

public interface ProductDAO {

	public ProductVO getCategoryMiddleOne(@Param("vo") ProductVO vo);

	public int setCategoryMiddleInput(@Param("vo") ProductVO vo);

	public List<ProductVO> getCategoryMiddle();

	public ProductVO getCategorySubOne(@Param("vo") ProductVO vo);

	public int setCategoryMiddleDelete(@Param("categoryMiddleCode") String categoryMiddleCode);

	public int setCategorySubInput(@Param("vo") ProductVO vo);

	public List<ProductVO> getCategorySub();

	public ProductVO getCategoryProductName(@Param("vo") ProductVO vo);

	public int setCategorySubDelete(@Param("categorySubCode") String categorySubCode);

	public ArrayList<ProductVO> getCategorySubName(@Param("categoryMiddleCode") String categoryMiddleCode);

	public int setProductInput(@Param("vo") ProductVO vo);

	public ProductVO getProductMaxIdx();

	public List<ProductVO> getAdminProductList();

	public ProductVO getProductInfo(@Param("idx") int idx);
	
	public List<ProductOptionVO> getProductOption(@Param("idx") int idx);

	public List<ProductVO> getCategoryProductNameAjax(@Param("categoryMiddleCode") String categoryMiddleCode, @Param("categorySubCode") String categorySubCode);

	public ProductVO getProductInfor(@Param("productName") String productName);

	public List<ProductOptionVO> getOptionList(@Param("productIdx") int productIdx);

	public int getOptionSame(@Param("productIdx") int productIdx, @Param("optionName") String optionName);

	public int setProductOptionInput(@Param("vo") ProductOptionVO vo);

	public int setOptionDelete(@Param("idx") int idx);

	public int setProductDelete(@Param("idx") int idx);

	public int setProductOptionDelete(@Param("idx") int idx);

	public List<ProductVO> getProductList(@Param("part") String part);

	public List<ProductVO> getMiddleTitle();

	public ProductCartVO getProductShopCartOptionSearch(@Param("productName") String productName, @Param("optionName") String optionName, @Param("mid") String mid);

	public int setProductShopCartUpdate(@Param("vo") ProductCartVO vo);

	public int setProductShopCartInput(@Param("vo") ProductCartVO vo);

	public List<ProductCartVO> getProductCartList(@Param("mid") String mid);

	public int productCartDelete(@Param("idx") int idx);

	public ProductOrderVO getOrderMaxIdx();

	public ProductCartVO getCartIdx(@Param("strIdx") int strIdx);

	public void setProductOrder(@Param("vo") ProductOrderVO vo);

	public void setProductCartDeleteAll(@Param("cartIdx") int cartIdx);

	public void setProductBaesong(@Param("baesongVO") ProductBaesongVO baesongVO);

	public void setMemberPointPlus(@Param("point") int point, @Param("mid") String mid);

	public int getTotalBaesongOrder(@Param("orderIdx") String orderIdx);

	public List<ProductBaesongVO> getAdminOrderStatus(@Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("orderStatus") String orderStatus);

	public int setOrderStatusUpdate(@Param("orderIdx") String orderIdx, @Param("orderStatus") String orderStatus);

	public List<ProductBaesongVO> getMyOrderStatus(@Param("mid") String mid, @Param("startJumun") String startJumun, @Param("endJumun") String endJumun, @Param("conditionOrderStatus") String conditionOrderStatus);

	public List<ProductBaesongVO> getOrderBaesong(@Param("orderIdx") String orderIdx);

	public int setWishListInput(@Param("productCode") String productCode, @Param("options") String options, @Param("mid") String mid, @Param("totalPrice") int totalPrice, @Param("productIdx") int productIdx);

	public List<WishListVO> getWishList();

	public int setWishDeleteOk(@Param("idx") int idx);

	public WishListVO getWishListOrder(@Param("idx") int idx);

	public List<ProductOrderVO> getMainProductList();

	public List<ProductOrderVO> getProductOrderIdx(@Param("orderIdx") String orderIdx);

	public int setReviewInput(@Param("vo") ReviewVO vo);

	public List<ReviewVO> getProductReview();

	public List<ReviewVO> getProductReviewSearch(@Param("reviewSearch") String reviewSearch);

	public List<ReviewVO> getProductReviewChange(@Param("reviewChange") String reviewChange, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int totRecCnt(@Param("part") String part);

	public List<ProductVO> getProductList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part);

	public int getGumaeInfor(@Param("mid") String mid);

	public int totRecCntReview();

	public List<ReviewVO> getProductReview(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("reviewChange") String reviewChange);

	public int totRecCntChange();

}
