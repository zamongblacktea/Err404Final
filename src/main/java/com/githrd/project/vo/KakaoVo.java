package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
@Alias("KakaoVo")
public class KakaoVo {

    int mem_idx;
    long mem_id;
    String mem_type;
    String mem_nickname;


}
