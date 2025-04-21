package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("CartVo")
public class CartVo {
    int cart_idx;
    int mem_idx;
    int shop_idx;
    int menu_idx;
    int cart_price;
    int cart_cnt;

}
