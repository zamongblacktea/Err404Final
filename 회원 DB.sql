/*
--회원 테이블 생성

CREATE TABLE member (
	mem_idx	int	primary key auto_increment NOT NULL,
	mem_id	varchar(100)	UNIQUE NOT NULL COMMENT '유니크',
	mem_pwd	varchar(100)	NOT NULL,
	mem_name	varchar(100)	NOT NULL,
	mem_nickname	varchar(100)	NOT NULL,
	mem_email	varchar(100)	NOT NULL	COMMENT '인증 api',
	mem_curaddr	varchar(200)	NOT NULL,
	mem_ip	varchar(100)	NOT NULL,
	mem_regdate	DATETIME	NOT NULL,
	mem_update	DATETIME	NULL,
	mem_grade	varchar(100)	NULL	COMMENT '일반/관리자'
);


CREATE TABLE owner (
	owner_idx	int	primary key auto_increment NOT NULL,
	owner_id	varchar(100)	UNIQUE NOT NULL,
	owner_pwd	varchar(100)	NOT NULL,
	owner_name	varchar(100)	NOT NULL,
	owner_email	varchar(100)	NOT NULL,
	owner_ip	varchar(100)	NOT NULL,
	owner_regdate	DATETIME	NOT NULL,
	owner_update	DATETIME	NULL,
	owner_num	varchar(100)	NOT NULL,
	owner_account	varchar(100)	NOT NULL,
	owner_status	varchar(100)	NOT NULL	
);

CREATE TABLE rider (
	rider_idx	int	primary key auto_increment NOT NULL,
	rider_id	varchar(100)	UNIQUE NOT NULL	COMMENT '유니크',
	rider_pwd	varchar(100)	NOT NULL,
	rider_name	varchar(100)	NOT NULL,
	rider_email	varchar(100)	NOT NULL	COMMENT '인증 api',
	rider_ip	varchar(100)	NOT NULL,
	rider_regdate	DATETIME	NOT NULL,
	rider_account	varchar(100)	NOT NULL,
	rider_loc	varchar(200)	NOT NULL	COMMENT '옵션형식으로 들어가야 함',
	rider_type	varchar(200)	NOT NULL	COMMENT '자동차/자전거/도보/오토바이'
);


--테이블 삭제 

DROP TABLE member;
DROP TABLE owner;
DROP TABLE rider;


--회원 DATA insert

--운영자 계정 생성 
INSERT INTO member VALUES(
							null,
                            'admin',
                            1234,
                            '관리자',
                            '김관리',
                            'admin@admin.com',
                            '서울시 관악구 에그옐로우',
                            '127,0,0,1',
                            now(),
                            null,
                            '관리자'
)


--일반 회원 생성
INSERT INTO member VALUES(
							null,
                            'dlfrtlfehd',
                            1234,
                            '일길동',
                            '일길동',
                            'admin@admin.com',
                            '서울시 관악구 에그옐로우',
                            '127,0,0,1',
                            now(),
                            null,
                            '일반'
)


*/
