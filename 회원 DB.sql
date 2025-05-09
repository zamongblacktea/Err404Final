/*
--회원 테이블 생성

CREATE TABLE member (
	mem_idx	int	primary key auto_increment NOT NULL,
	mem_id	varchar(100)	UNIQUE NOT NULL COMMENT '유니크',
	mem_pwd	varchar(100)	NOT NULL,
	mem_name	varchar(100)	NOT NULL,
	mem_nickname	varchar(100)	NOT NULL,
	mem_email	varchar(100)	NOT NULL	COMMENT '인증 api',
	mem_zipcode	varchar(200)	NOT NULL,
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
	owner_zipcode	varchar(100)	NOT NULL,
	owner_addr	varchar(100)	NOT NULL,
	owner_regdate	DATETIME	NOT NULL,
	owner_update	DATETIME	NULL,
	owner_num	varchar(100)	NOT NULL,
	owner_status	varchar(100)	NOT NULL default '대기'	
);

CREATE TABLE rider (
	rider_idx	int	primary key auto_increment NOT NULL,
	rider_id	varchar(100)	UNIQUE NOT NULL	COMMENT '유니크',
	rider_pwd	varchar(100)	NOT NULL,
	rider_name	varchar(100)	NOT NULL,
	rider_email	varchar(100)	NOT NULL	COMMENT '인증 api',
	rider_ip	varchar(100)	NOT NULL,
	rider_regdate	DATETIME	NOT NULL,
	rider_update	DATETIME	NOT NULL,
	rider_account	varchar(100)	NOT NULL,
	rider_loc	varchar(200)	NOT NULL	COMMENT '옵션형식으로 들어가야 함',
	rider_type	varchar(200)	NOT NULL	COMMENT '자동차/자전거/도보/오토바이',
    rider_status	varchar(200)	NOT NULL	default '대기'
);

CREATE TABLE sns (
  sns_idx int NOT NULL,
  sns_id varchar(255) NOT NULL,
  sns_type varchar(10)  NULL,
  sns_name varchar(255)  NULL,
  sns_regdate datetime  NULL,
  KEY idx01_idx (sns_idx),
  KEY idx02_sns_id (sns_id),
  CONSTRAINT fk_mem_idx FOREIGN KEY (sns_idx) REFERENCES member (mem_idx)
);

--
DROP TABLE sns

--sns 연동 member  조회
    select a.mem_name,
    a.mem_email,
    a.mem_nickname,
    a.mem_regdate,
    a.mem_update,
    b.sns_id,
    b.sns_type,
    b.sns_name,
    b.sns_regdate
    from member a,
    sns b
    where
    a.mem_idx = b.sns_idx
    AND b.sns_id = 1




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
                            '서울시 관악구 에그옐로우 1720-2',
                            '6층 글로벌 아이티',
                            '127,0,0,1',
                            now(),
                            null,
                            '관리자'
);


--일반 회원 생성
INSERT INTO member VALUES(
							null,
                            'dlfrlfehd',
                            1234,
                            '일길동',
                            '일길동',
                            'dlfrlfehd@admin.com',
                            '서울시 관악구 에그옐로우 1720-2',
                            '글로벌 아이티',
                            '127,0,0,1',
                            now(),
                            null,
                            '일반'
)


--사업자 회원 생성
INSERT INTO owner VALUES(
							null,
                            'owner',
                            1234,
                            '사장님',
                            'owner@admin.com',
							'127,0,0,1',
                            '서울시 관악구 에그옐로우 1720-2',
                            '글로벌 아이티',
                            now(),
                            null,
                            '162-214-00213',
                            '대기'
)


--라이더 회원 생성
INSERT INTO rider VALUES(
							null,
                            'rider',
                            1234,
                            '김배달',
                            'rider@admin.com',
							'127,0,0,1',
							now(),
                            null,
                            '127-912030131-78',
                            '관악구,동작구',
                            '오토바이',
                            '대기',
                            '이미지'
)


*/
