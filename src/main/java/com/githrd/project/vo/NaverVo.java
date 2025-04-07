package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
@Alias("NaverVo")
public class NaverVo {

    int mem_idx;
    String mem_id;
    String mem_email;
    String mem_type;
    String mem_name;
    String mem_regdate;


}
