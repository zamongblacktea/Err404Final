drop table menu;
drop table shop_info;


CREATE TABLE shop_info (
	shop_idx	int	NOT NULL auto_increment primary key,
	owner_idx	int	NOT NULL,
	shop_cate_idx	int	NOT NULL,
	shop_name	varchar(100)	NULL,
	shop_company	varchar(100)	NULL,
	shop_bnumber	varchar(100)	NULL,
	shop_addr1	varchar(300)	NULL,
    shop_addr2 varchar(100) NULL,
	shop_longitude	DECIMAL(10,7)	NULL,
	shop_latitude	DECIMAL(10,7)	NULL,
	shop_phone	varchar(100)	NULL,
	shop_dfee	int	NULL,
	shop_logo	varchar(500)	NULL,
	shop_img	varchar(500)	NULL,
	shop_notice	varchar(1000)	NULL,
	shop_intro	varchar(1000)	NULL,
	shop_minprice	int	NULL,
	shop_mintime	int	NULL,
	shop_maxtime	int	NULL,
	shop_rating	decimal(2,1)	NULL,
	shop_favor	int	NULL,
	shop_reviewcnt	int	NULL,
	shop_optime	varchar(100)	NULL,
	shop_cltime	varchar(100)	NULL,
	shop_closeday	varchar(100)	NULL,
	shop_loc	varchar(500)	NULL,
	shop_regdate	DATETIME	NULL,
	shop_update	DATETIME	NULL,
	shop_status	varchar(100)	NULL
);

CREATE TABLE menu (
	menu_idx	int	NOT NULL auto_increment primary key,
	shop_idx	int	NOT NULL,
	menu_cate	varchar(100)	NULL,
	menu_name	varchar(500)	NOT NULL,
	menu_img	varchar(500)	NOT NULL,
	menu_price	int	NOT NULL,
	menu_regdate	DATETIME	NOT NULL,
	menu_update	DATETIME	NULL,
	menu_status	varchar(100)	NOT NULL
);

ALTER TABLE shop_info ADD CONSTRAINT PK_SHOP_INFO PRIMARY KEY (
	shop_idx
);

ALTER TABLE menu ADD CONSTRAINT PK_MENU PRIMARY KEY (
	menu_idx
);

ALTER TABLE shop_info 
ADD CONSTRAINT fk_shop_cate_idx
FOREIGN KEY (shop_cate_idx) REFERENCES shop_category (shop_cate_idx) 
ON DELETE CASCADE;


ALTER TABLE shop_info 
ADD CONSTRAINT fk_owner_idx
FOREIGN KEY (owner_idx) REFERENCES owner (owner_idx) 
ON DELETE CASCADE;

ALTER TABLE menu 
ADD CONSTRAINT fk_shop_idx
FOREIGN KEY (shop_idx) REFERENCES shop_info(shop_idx) 
ON DELETE CASCADE;

SELECT * FROM final.shop_info;

INSERT INTO shop_info 
(shop_idx, owner_idx, shop_cate_idx, shop_name, shop_company, shop_bnumber, shop_addr1,shop_addr2, shop_longitude, shop_latitude, shop_phone, shop_dfee, shop_logo, shop_img, shop_notice, shop_intro, shop_minprice, shop_mintime, shop_maxtime, shop_rating, shop_favor, shop_reviewcnt, shop_optime, shop_cltime, shop_closeday, shop_loc, shop_regdate, shop_update, shop_status)
VALUES 
(NULL, 1, 1, '테스트', '테스트', '123-4123-32', '서울시 관악구','101호', NULL, NULL, '02-305-3065', 3000, NULL, NULL, '정상영업', '합니다', 10000, 20, 50, NULL, NULL, NULL, NULL, NULL, NULL, '서울', NOW(), NULL, '영업중');
