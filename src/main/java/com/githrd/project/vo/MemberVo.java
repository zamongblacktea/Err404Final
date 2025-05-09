package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data //= @getter @setter @toString
//@NoArgsConstructor // 기본생성자는 생성자가 없으면 자동으로 생성해서 쓰기 때문에 굳이 만들 필요 없음.
@Alias("MemberVo")
public class MemberVo {

	int    mem_idx;
	String mem_id;
	String mem_pwd;
	String mem_name;
	String mem_nickname;
	String mem_email;
	String mem_zipcode;
	String mem_addr;
	String mem_ip;
	String mem_regdate;
	String mem_update;
	String mem_grade;
	String mem_type;
	String mem_phone;
	int mcuraddr_idx;
	String mem_addr1;
	String mem_addr2;
	double mem_latitude;
    double mem_longitude;
	String addr_name; 

	//관리자용
	int owner_idx;
	int rider_idx;
	String rider_id;
	String rider_name;
	String rider_phone;
	


	


	
	
}
