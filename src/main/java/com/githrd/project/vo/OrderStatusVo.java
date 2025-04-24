package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Alias("OrderStatusVo")
//기본 생성자 생성 (constructor로 원하는 값만 getter/setter 설정했을 땐 넣어줘야 함)
@NoArgsConstructor


public class OrderStatusVo {


    
    public OrderStatusVo(int shop_idx, int menu_idx, int mem_idx, int pay_idx,int mcuraddr_idx, String mem_phone,
            String order_request, String rider_request, int amount, String pay_type, String coupon_use,
            String mem_addr1, String mem_addr2) {
        //TODO Auto-generated constructor stub
    }
    @JsonProperty("orderIdx")
    Integer order_idx;
    Integer shop_idx;
    Integer menu_idx;
    Integer mem_idx;
    Integer pay_idx;
    Integer delivery_idx;
    int mcuraddr_idx;
    String order_regdate;
    @JsonProperty("orderStatus")
    String order_status;
    String order_reason;
    String mem_phone;
    String order_request;
    String rider_request;
    Integer amount;
    String pay_type;
    String coupon_use;
    String mem_addr1;
    String mem_addr2;
    String delivery_status;
    //주문정보 standby_list출력 내용 추가(20250423)
    String shop_name;
    String shop_addr1;
    String shop_addr2;
    String menu_name;
    int    menu_price;
    //delivery 테이블 칼럼
    String pay_regdate;
    int totalDistance;
    int delivery_fee;


}
