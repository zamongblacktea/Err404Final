drop table order

CREATE TABLE order (
	
    order_idx	int primary key auto_increment,
    pay_idx		int null,
    mem_idx     int null,
    shop_idx    int null,
    menu_idx	int null,
    order_status varchar(100) null,
    order_regdate datetime

);

-- order_check 주문확인 번호 가게 주문정보에도 있어야함(shop_order테이블에서 가져와야함)

-- shop_order테이블에서 sorder_staus가 y 인것만 출력되도록 해야함

-- order_status A:조리중 B:조리완료 C:배차완료 D: 배달완료 
-- delivery 테이블에서 B 인것이 픽업완료 버튼이 나오도록 출력되도록해야함  
 
select * from order

insert into order values(null,1,1,1,1,'C',now());