<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>productContentShop.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
    'use strict';

    let idxArray = new Array();

    // 옵션박스에서, 옵션항목을 선택하였을때 처리하는 함수(고유번호/옵션명/콤마붙인가격)을 화면에 출력시켜주고 있다.
    $(function(){
      $("#selectOption").change(function(){
        let selectOption = $(this).val();
        let idx = selectOption.substring(0,selectOption.indexOf(":"));
        let optionName = selectOption.substring(selectOption.indexOf(":")+1,selectOption.indexOf("_"));
        let optionPrice = selectOption.substring(selectOption.indexOf("_")+1);
        let commaPrice = numberWithCommas(optionPrice);

        if($("#layer"+idx).length == 0 && selectOption != "") {
          idxArray[idx] = idx;

          let str = '';
          str += '<div class="layer row" id="layer'+idx+'"><div class="col">'+optionName+'</div>';
          str += '<input type="hidden" id="optionName'+idx+'" value="'+optionName+'" />';
          str += '<input type="number" class="text-center numBox" id="numBox'+idx+'" name="optionNum" onchange="numChange('+idx+')" value="1" min="1"/> &nbsp;';
          str += '<input type="text" id="imsiPrice'+idx+'" class="price" value="'+commaPrice+'" readonly />';
          str += '<input type="hidden" id="price'+idx+'" value="'+optionPrice+'"/> &nbsp;';
          str += '<input type="button" class="btn btn-outline-danger btn-sm" onclick="remove('+idx+')" value="삭제"/>';
          str += '<input type="hidden" name="statePrice" id="statePrice'+idx+'" value="'+optionPrice+'"/>';
          str += '<input type="hidden" name="optionIdx" value="'+idx+'"/>';
          str += '<input type="hidden" name="optionName" value="'+optionName+'"/>';
          str += '<input type="hidden" name="optionPrice" value="'+optionPrice+'"/>';
          str += '</div>';
          $("#product1").append(str);
          onTotal();
        }
        else {
          alert("이미 선택한 옵션입니다.");
        }
      });
    });

    // 등록(추가)시킨 옵션의 상품을 삭제처리하기
    function remove(idx) {
      $("div").remove("#layer"+idx);

      if($(".price").length) onTotal();
      else location.reload();
    }

		// 상품의 총 금액을 (재)계산처리한다.
    function onTotal() {
      let total = ${productVO.mainPrice};
      for(let i=0; i<idxArray.length; i++) {
        if($("#layer"+idxArray[i]).length != 0) {
          total +=  parseInt(document.getElementById("price"+idxArray[i]).value);
          document.getElementById("totalPriceResult").value = total;
        }
      }
      document.getElementById("totalPrice").value = numberWithCommas(total);
    }

		// 수량을 변경시 처리하는 함수
    function numChange(idx) {
      let price = document.getElementById("statePrice"+idx).value * document.getElementById("numBox"+idx).value;
      document.getElementById("imsiPrice"+idx).value = numberWithCommas(price);
      document.getElementById("price"+idx).value = price;
      onTotal();
    }

    
		// 장바구니 호출시 수행하는 함수
    function cart() {
	    if('${sMid}' == "" || '${sMid}' == null) {
	    	alert("로그인후 사용하세요.");
	    	location.href='${ctp}/member/memberLogin';
	    	return false;
	    } 
	    
	    if(!$('#selectOption > option:selected').val()) {
      	alert("필수 옵션을 선택해주세요.");
        return false;
	    }
      else {
        document.myform.submit();
      }
    }

		// 직접 주문하기
    function order() {
    	let totalPrice = document.getElementById("totalPrice").value;
			
      if(!$('#selectOption > option:selected').val() || totalPrice==0) {
      	alert("필수 옵션을 선택해주세요.");
        return false;
      }
      else {
        document.getElementById("flag").value = "order";
        document.myform.submit();
      }
    }
		
		// 위시리스트 담기
    function wish() {
      let totalPrice = document.getElementById("totalPrice").value;
    	let productCode = '${productVO.productCode}';
    	let productIdx = '${productVO.idx}';
    	alert("productIdx : " + productIdx);
			
      if(!$('#selectOption > option:selected').val() || totalPrice==0) {
      	alert("필수 옵션을 선택해주세요.");
        return false;
      }
      
      //옵션반복문돌리기
      let options = "";
      totalPrice = ${productVO.mainPrice};
      for(let i=0; i<idxArray.length; i++) {
        if($("#layer"+idxArray[i]).length != 0) {
          options +=  document.getElementById("optionName"+idxArray[i]).value +":"+ document.getElementById("numBox"+idxArray[i]).value +":"+ document.getElementById("price"+idxArray[i]).value + "/";
          totalPrice +=  parseInt(document.getElementById("price"+idxArray[i]).value);
        }
      }
      options = options.substring(0,options.length-1);
     
      $.ajax({
    	  url : '${ctp}/product/wishListInput',
    	  type : 'post',
    	  data : {
    	    productCode : productCode,
    	    options : options,
    	    totalPrice : totalPrice,
    	    productIdx : productIdx
    	  },
    	  success:function(res) {
    	    if(res != 0) alert("관심품목에 저장되었습니다.");
    	    else alert("관심품목 저장 실패!");
    	  },
    	  error : function() {
    	    alert('전송오류');
    	  }
      });
      
    }

    // 천단위마다 콤마를 표시해 주는 함수
    function numberWithCommas(x) {
      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
  </script>
  <style>
    .layer  {
      border:0px;
      width:100%;
      padding:10px;
      margin-left:1px;
      background-color:#e7e7e7;
    }
    .numBox {width:40px}
    .price  {
      width:160px;
      background-color:#e7e7e7;
      text-align:right;
      font-size:1.2em;
      border:0px;
      outline: none;
    }
    .totalPrice {
      text-align:right;
      margin-right:0px;
      color:#f63;
      font-size:1.5em;
      font-weight: bold;
      border:0px;
      outline: none;
    }
    .button, .orderBtn {
		  background-color: #04AA6D; /* Green */
		  border: #e7e7e7;;
		  color: white;
		  padding: 5px 11px 5px 11px;
		  text-decoration: none;
		  display: inline-block;
		  font-size: 16px;
		  margin: 0px 2px;
		  transition-duration: 0.4s;
		  cursor: pointer;
		  border-radius: 5px;
		}
		.button4 {
		  background-color: white;
		  color: black;
		  border: 2px solid #e7e7e7;;
		}
		.button4:hover {background-color: #ddd;}
		.orderBtn {
		  background-color: white;
		  color: black;
		  border: 2px solid black;
		}
		.orderBtn:hover {
			background-color: black;
			color: white;
			border: 2px solid black;
		}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container" style="margin-top: 130px;">
	<table class="table table-borderless m-0 p-0">
		<tr>
			<td class="m-0 p-0">
				<div style="width:120px; height:500px; overflow:auto; border:1px solid #eee">
					<!-- 상품 이미지 여러장 -->
			    <c:set var="firstImgs" value="${fn:split(productVO.FSName, '/')}" />
		  	  <c:forEach var="i" begin="0" end="${fn:length(firstImgs)-1}" varStatus="st">
		  	  	<div>
		  	  		<img src="${ctp}/product/${firstImgs[i]}" width="100px" 
					      onmouseover="document.getElementById('img').innerHTML='<img src=${ctp}/product/${firstImgs[i]} width=500px>'"/>
		  	  	</div>
					</c:forEach>
				</div>
			</td>
			<td class="m-0 p-0">
		    <div>
				  <!-- 상품메인 이미지 -->
				  <div class="mr-4" id="img">
				  	<img src="${ctp}/product/${firstImgs[0]}" width="500px;"/>
				  </div>
				</div>
			</td>
			<td class="m-0 p-0 text-right">
			  <!-- 상품 기본정보 -->
			  <div id="iteminfor">
			    <%-- <h3>${productVO.categorySubName} - ${productVO.productName}</h3> --%>
			   <%--  <h3>${productVO.detail} - ${productVO.productName}</h3> --%>
			    <h3>${productVO.categorySubName} - ${productVO.productName}</h3>
			    <h6>${productVO.detail}</h6>
			    <h3><font><fmt:formatNumber value="${productVO.mainPrice}"/>원</font></h3>
			  </div>
			  <!-- 상품주문을 위한 옵션정보 출력 -->
			  <div class="form-group mt-4">
			    <form name="optionForm">  <!-- 옵션의 정보를 보여주기위한 form -->
			      <select size="1" class="form-control" id="selectOption">
			        <option value="" disabled selected>[필수] 옵션을 선택하세요.</option>
			        <%-- <option value="0:기본품목_${productVO.mainPrice}">기본 품목</option> --%>
		          <c:set var="basicProduct" value="0:기본품목_${productVO.mainPrice}"/>
		          <c:if test="${fn:length(optionVOS) != 0}">
				        <c:forEach var="vo" items="${optionVOS}">
				          <option value="${vo.idx}:${vo.optionName}_${vo.optionPrice}">${vo.optionName} (+<fmt:formatNumber value="${vo.optionPrice}" />원)</option>
				        </c:forEach>
			        </c:if>
		          <c:if test="${fn:length(optionVOS) == 0}">
				         <option value="0:0_0">free (0원)</option>
			        </c:if>
			      </select>
			    </form>
			  </div>
			  <br/>
			  <!--  -->
			  <div>
			    <form name="myform" method="post">
			      <input type="hidden" name="mid" value="${sMid}"/>
			      <input type="hidden" name="productIdx" value="${productVO.idx}"/>
			      <input type="hidden" name="productName" value="${productVO.productName}"/>
			      <input type="hidden" name="mainPrice" value="${productVO.mainPrice}"/>
			      <input type="hidden" name="thumbImg" value="${productVO.FSName}"/>
			      <input type="hidden" name="totalPrice" id="totalPriceResult"/>
			      <input type="hidden" name="flag" id="flag"/>
			      <input type="hidden" name="categorySubName" value="${productVO.categorySubName}"/>
			      
			      <input type="hidden" name="basicProduct" value="${basicProduct}" /> 
					  <div id="product1"></div>
			    </form>
			  </div>
			</td>
		</tr>	
	</table>
  <div>
    <hr/>
    <div class="text-right"><font size="4" color="black"><b>총상품금액</b></font></div>
    <p class="text-right">
      <b><input type="text" class="totalPrice text-right" id="totalPrice" value="<fmt:formatNumber value='${productVO.mainPrice}'/>" readonly /></b>
    </p>
  </div>
  <br/>
  <div>
    <button class="orderBtn w3-right" onclick="order()">주문하기</button>&nbsp;
    <button class="button button4 w3-right mr-2" onclick="cart()">장바구니 담기</button>&nbsp;
    <c:if test="${!empty sMid}">
    	<button class="button button4 w3-right mr-2" onclick="wish()">관심상품</button>&nbsp;
    </c:if>
    <button class="button button4 w3-right mr-2" onclick="location.href='${ctp}/product/productList';">계속 쇼핑하기</button>
  </div>
  <br/><br/>
  <div id="content" class="text-center"><br/>
    ${productVO.content}
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>