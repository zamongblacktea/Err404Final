package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("RiderDeliveryFeeVo")
public class RiderDeliveryFeeVo {

    int  riderdeliveryfee_idx;
    int rider_idx;
    String rider_name;
    int order_idx;
    int order_check;
    int shop_idx;
    String shop_name;
    int mem_idx;
    String mem_name;
    int delivery_idx;
    String pay_regdate;
    int delivery_fee;
    String mem_addr1;
    String mem_addr2; 

}
