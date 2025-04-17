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

select * from rider_deliveryfee

-- 조인해서 가져올것들 
-- delivery테이블에서 가져올것들 : delivery_fee totalDistance delivery_status가 y인것

