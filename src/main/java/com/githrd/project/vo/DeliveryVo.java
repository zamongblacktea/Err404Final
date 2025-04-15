package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("DeliveryVo")
public class DeliveryVo {
    int order_idx;
    String shop_name;
    String shop_addr1;
    String shop_addr2;
    String menu_name;
    int menu_price;
    String mem_caddr;
    String mem_cdaddr;
    String rider_request;
    String order_status;
    String delivery_status;
    String rider_stauts;
    int rider_idx;
    String pay_date;
    int delivery_fee;
    int mem_idx;


    
}
