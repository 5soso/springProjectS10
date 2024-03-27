-- 리뷰테이블
create table review (
	idx int not null auto_increment primary key, /* 리뷰 고유번호 */
	mid 					varchar(20)  not null,				 /* 구매자 아이디 */
	productCode   varchar(20)  not null,				 /* 구매한 상품의 고유코드 */
	productName   varchar(100) not null,			   /* 구매한 상품명(상품모델명) */
	orderIdx      varchar(15)  not null,			   /* 주문 번호 */
	content		    text not null,								 /* 리뷰 내용 */
	dogWeight 		int, 													 /* 리뷰 내용 : 강아지 몸무게 필수X*/
	optionName    varchar(50) , 		         		 /* 옵션 이름 필수X */		 			
	reImage				varchar(100),									 /* 리뷰 사진 */
	reStar 				int default 5,							   /* 리뷰 별점 기본값 5점 */
	reDate datetime default now(),							 /* 리뷰 작성일 기본 오늘날짜 */
	foreign key(productCode) references product(productCode),
  foreign key(mid) references member(mid)
);
drop table review;



-- 신고테이블
create table complaint(
	idx int not null auto_increment primary key, 	/* 신고테이블 고유번호  */
	part varchar(10) not null, 										/* 신고 분류(part=reveiw,QnA,..) */
	partIdx int not null, 												/* 신고분류 고유번호 */
	mid varchar(20) not null, 										/* 신고자 아이디 */
	complaint varchar(100) not null, 							/* 신고 사유 */
	foreign key(mid) references member(mid)
);
drop table complaint;


select o.*,s.categorySubName,(select idx from review where orderIdx=o.orderIdx and productName=p.productName) as reviewOk from productOrder o, product p, categorySub s where o.productName=p.productName and p.categorySubCode=s.categorySubCode and o.orderIdx = '2024012431';