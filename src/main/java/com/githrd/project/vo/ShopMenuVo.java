package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("ShopMenuVo")
public class ShopMenuVo {
    int menu_idx;
    int shop_idx;
    String menu_cate;
    String menu_name;
    String menu_img;
    int menu_price;
    String menu_regdate;
    String menu_update;
    String menu_status;
}
