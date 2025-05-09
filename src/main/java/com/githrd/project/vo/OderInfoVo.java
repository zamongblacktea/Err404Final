package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("OrderInfoVo")
public class OderInfoVo {
    int order_idx;
    int pay_idx;
    int mem_idx;
    int shop_idx;
    int menu_idx;
    String order_status;
    String order_regdate;

    
}
