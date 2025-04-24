drop table delivery

CREATE TABLE delivery (
	
    delivery_idx int primary key auto_increment,
	order_idx	int NULL,
	shop_idx 	int NULL,
	mem_idx int null,
    rider_idx int null,
    menu_idx int null,
    menu_name   varchar(100)	NULL,
	menu_price	int	NOT NULL,	
	mem_addr1	varchar(100)	NULL,
	mem_addr2	varchar(100)	NULL,
	rider_request	varchar(100)	NULL,
    order_status varchar(100)	default 'N',
    rider_status varchar(100)	default 'N',
    delivery_status varchar(100)	default 'N',
    pay_date datetime,
    totalDistance double NULL,
    delivery_fee int
);
-- shop_idx로 가져와서(조인) shop_name,shop_addr1,shop_addr2,shop_phone 가져와야함 mapper 수정
-- mem_idx로 가져와서(조인) mem_phone 출력되도록 해야함

-- mcuraddr_idx를 추가하고 조인 mem_addr1 mem_addr2 mem_longitude mem_latitude 를 가져와야함
select * from delivery where rider_status='Y' and delivery_status='N' and rider_idx=1

update delivery set rider_status='N',delivery_status='N' where order_idx > 0

insert into delivery values(null,'맛나요BBQ','가게주소1','가게주소2','순살프라이드',
						10000,'고객주소1','고객주소2',
						'안전하게배달해주세요','N','N','N',now(),3000,20,0);
              
alter table delivery add constraint fk_delivery foreign key(rider_idx) references rider(rider_idx);     

alter table delivery
add constraint foreign key (mcuraddr_idx) references mem_addr(mcuraddr_idx);

-- date_format : 시간을 없애고 년월일만 가져온다.
-- 포린키는 조인을 하는 조건으로 사용 즉 포린키는 연결하는 조건임
-- inner조인 1대1조인

select date_format(now(),'%Y-%m-%d') from dual
where date_format(now(),'%Y-%m-%d')='2025-04-16'

-- order테이블에서 delivery 테이블이 만들어지는 구문
insert into delivery values(null,1,2,10,1,1,1,'조심히','조리대기','Y',now(),1500,3000)

insert into delivery values(null,#{order_idx},#{shop_idx},#{mem_idx},
							#{rider_idx},#{menu_idx},#{mcuraddr_idx},#{rider_request},#{order_status},#{delivery_status}
                            ,now(),#{totalDistance},#{delivery_fee})

select * from delivery

-- order_status테이블에서 라이더의 상태 초깃값 none
-- 배차대기 배차완료(픽업대기상태) 픽업완료 배달중 배달완료
