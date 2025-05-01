package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("DeliveryVo")
public class DeliveryVo {

    int delivery_idx;
    int order_idx;
    int shop_idx;
    int mcuraddr_idx;
    int menu_idx;
    String shop_name;
    String shop_addr1;
    String shop_addr2;
    String shop_phone;
    String menu_name;
    int menu_price;
    String mem_addr1;
    String mem_addr2;
    String mem_phone;
    String rider_request;
    String order_status;
    String delivery_status;
    int rider_idx;
    String pay_regdate;
    int delivery_fee;
    int mem_idx;
    int totalDistance;
    String rider_status;
    String order_regdate;
    int amount;

    String order_request;
    int review_available;
    
    
}
