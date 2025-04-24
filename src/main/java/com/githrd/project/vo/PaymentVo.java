package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("PaymentVo")
public class PaymentVo {

    int pay_idx;
    int mem_idx;
    // int cart_idx;
    int mcuraddr_idx;
    int menu_idx;
    int shop_idx;
    String mem_name;
    String mem_phone;
    String menu_name;
    String pay_type;
    String pay_status;
    String pay_regdate;
    String imp_uid;
    String merchant_uid;
    int amount;
    String shop_request;
    String rider_request;
    String coupon_use;
    String mem_addr1;
    String mem_addr2;

}
