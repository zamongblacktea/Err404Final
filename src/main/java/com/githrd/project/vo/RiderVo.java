package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Getter;
import lombok.Setter;


//@Data // @getter @setter @toString
@Getter @Setter
//@NoArgsConstructor // 기본생성자는 생성자가 없으면 자동으로 생성해서 쓰기 때문에 굳이 만들 필요 없음.
@Alias("RiderVo")
public class RiderVo {

	int    rider_idx;
	String rider_id;
	String rider_pwd;
	String rider_name;
	String rider_email; 
	String rider_ip;
	String rider_regdate;
	String rider_update;
	String rider_account;
	String rider_loc;
	String rider_type;
	String rider_approve;
	String rider_img;
	String rider_phone;
	


	
	
}
