
/* 위시리스트 테이블 */
create table wishList(
	idx int not null primary key auto_increment, /* 위시리스트 고유번호 */
	mid varchar(20) not null, 									 /* 회원 아이디 */ 
	productCode varchar(20) not null, 					 /* 상품 코드 */
	productIdx int not null,										 /* 상품 고유번호 */
	options varchar(200),												 /* 옵션명 리스트 */
	wishDate datetime default now(),						 /* 위시리스트 등록날짜 */
	totalPrice int															 /* 구매총액 */
);
	foreign key(productCode) references product(productCode)

desc wishList;
drop table wishList;

select count(*) from product product, categoryMiddle midd, categorySub s
	 		where product.categoryMiddleCode=midd.categoryMiddleCode and midd.categoryMiddleCode = 'A'
	 		and product.categorySubCode=s.categorySubCode;