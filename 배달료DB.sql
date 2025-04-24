drop table rider_deliveryfee 

CREATE TABLE rider_deliveryfee (
    riderdeliveryfee_idx	int primary key auto_increment,
    rider_idx		int null,
    rider_name		varchar(100) null,
    order_idx       int null,
    order_check		int null,
    shop_idx	  	int null,
    shop_name       varchar(100) null,
    mem_idx			int null,
	mem_name		varchar(100) null,
    delivery_idx    int null,
    pay_date datetime
)

 select df.*,d.delivery_idx 
    from rider_deliveryfee df
    join shop_info s,delivery d,order_info o 
    where s.shop_idx = d.shop_idx and 
    where d.rider_idx = 1

-- 조인문구    
SELECT df.*, d.delivery_idx,d.delivery_fee
FROM rider_deliveryfee df
JOIN delivery d ON df.delivery_idx = d.delivery_idx
JOIN shop_info s ON s.shop_idx = d.shop_idx
JOIN order_info o ON o.order_idx = d.order_idx
WHERE d.rider_idx = 1;

select * from rider_deliveryfee
SHOW CREATE TABLE rideraddr;

ALTER TABLE rider_addr DROP FOREIGN KEY fk_mem_memberaddr;

-- 조인해서 가져올것들 
-- shop_order_info에서 order_check 
-- pay_date도 가져와야함
-- delivery테이블에서 가져올것들 : delivery_fee totalDistance delivery_status가 y인것
-- member테이블에서 mem_addr1  mem_addr2 가져와야함.
-- 



