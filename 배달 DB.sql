drop table delivery

CREATE TABLE delivery (
	
    delivery_idx int primary key auto_increment,
	order_idx	int NULL,
	shop_idx 	int NULL,
	mem_idx int,
    rider_idx int, 
    menu_name   varchar(100)	NULL,
	menu_price	int	NOT NULL,	
	mem_caddr	varchar(100)	NULL,
	mem_cdaddr	varchar(100)	NULL,
	rider_request	varchar(100)	NULL,
    order_status varchar(100)	default 'N',
    delivery_status varchar(100)	default 'N',
    rider_status varchar(100)	default 'N',
    pay_date datetime,
    delivery_fee int
 

);
-- shop_idx로 가져와서(조인) shop_name,shop_addr1,shop_addr2,shop_phone 가져와야함 mapper 수정
-- mem_idx로 가져와서(조인) mem_phone 출력되도록 해야함

select * from delivery where rider_status='Y' and delivery_status='N' and rider_idx=1

update delivery set rider_status='N',delivery_status='N' where order_idx > 0

insert into delivery values(null,'맛나요BBQ','가게주소1','가게주소2','순살프라이드',
						10000,'고객주소1','고객주소2',
						'안전하게배달해주세요','N','N','N',now(),3000,20,0);
              
alter table delivery add constraint fk_delivery foreign key(rider_idx) references rider(rider_idx);     