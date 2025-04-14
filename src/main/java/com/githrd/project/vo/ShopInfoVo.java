package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("ShopInfoVo")
public class ShopInfoVo {
    // int shop_idx;
    Integer shop_idx;
    int owner_idx;
    int shop_cate_idx;
    String shop_name;
    String shop_company;
    String shop_bnumber;
    String shop_addr1;
    String shop_addr2;
    double shop_longitude;
    double shop_latitude;
    String shop_phone;
    String shop_dfee;
    String shop_logo;
    String shop_img;
    String shop_notice;
    String shop_intro;
    int shop_minprice;
    int shop_mintime;
    int shop_maxtime;
    double shop_rating;
    int shop_favor;
    int shop_reviewcnt;
    String shop_optime;
    String shop_cltime;
    String shop_closeday;
    String shop_loc;
    String shop_regdate;
    String shop_update;
    String shop_status;

}
