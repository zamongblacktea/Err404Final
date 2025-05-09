package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data //= @getter @setter @toString
//@NoArgsConstructor // 기본생성자는 생성자가 없으면 자동으로 생성해서 쓰기 때문에 굳이 만들 필요 없음.
@Alias("OwnerVo")
public class OwnerVo {

	int    owner_idx;
	String owner_id;
	String owner_pwd;
	String owner_name;
	String owner_email;
	String owner_ip;
	String owner_regdate;
	String owner_update;
	String owner_num;
	String owner_approve;
	String mem_grade;
	


	
	
}
