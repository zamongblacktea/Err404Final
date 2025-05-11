package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("OrderMenuVo")
public class OrderMenuVo {
    int cart_idx;
    int mem_idx;
    int shop_idx;
    int menu_idx;
    int cart_price;
    int cart_cnt;
    int order_idx;
    String menu_name;
    int menu_price;
    int amount;

}
