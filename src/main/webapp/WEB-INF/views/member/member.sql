show tables;

-- 사용한 적립금(마이페이지 회원정보에 띄우고싶음) 
-- 쿠폰(쿠폰테이블 만들기)
-- 주문건수는 주문테이블에서 가져오기
-- coupon int default 0,										  /* 사용가능 쿠폰(생일쿠폰, 등급쿠폰(silver-5%할인/1장/기간:한달, vip-5% 15%할인/각1장/기간:한달), 이벤트쿠폰) */
-- 	usedPoint int default 0,									/* 사용한 적립금 */
 
create table member (
	idx 		 int not null auto_increment, 			/* 회원 고유번호 */
	mid			 varchar(20) not null,							/* 아이디(중복불허, 수정불가능) */
	pwd 		 varchar(100) not null,							/* 회원 비밀번호(암호화 처리, 수정가능) */
	name		 varchar(15) not null,							/* 회원 성명(수정가능) */
	tel 	   varchar(15) not null,							/* 휴대전화 : 010-1234-5678(아이디 분실시에 사용, 중복불허) */
	email		 varchar(60) not null,							/* 이메일(아이디/비밀번호 분실시에 사용, 인증번호 확인) */
	address  varchar(100) not null,							/* 주소(다음 API 활용) */
	birthday datetime default now(),						/* 반려동물생일('2023-12-30') */
	level			int default 3,										/* 회원등급(0:관리자, 1:VIP, 2:Silver, 3:일반회원, 99:탈퇴신청회원)  */		
	point 	  int default 3000, 								/* 가용적립금(가입시 3000포인트 지급) */
	userCancel char(3) default 'NO',						/* 회원 탈퇴신청여부 */
	visitCount int default 0, 									/* 방문횟수 */
	lastDate	datetime default now(),						/* 마지막 접속일 */
	primary key(idx),
	unique(mid)
);
drop table member;

desc member;

insert into member values(default, 'admin', '1234', '관리자', '010-1111-1111', 'apple_1114@naver.com', '청주시', '2023-12-30', 0, default, default, default, default, default);

select * from member;