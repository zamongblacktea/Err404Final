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
    @Builder
    public OrderStatusVo(int shop_idx, int menu_idx, int mem_idx, int pay_idx,
            String mem_phone, String order_request, String rider_request,
            int amount, String pay_type, String coupon_use) {
        this.shop_idx = shop_idx;
        this.menu_idx = menu_idx;
        this.mem_idx = mem_idx;
        this.pay_idx = pay_idx;
        this.mem_phone = mem_phone;
        this.order_request = order_request;
        this.rider_request = rider_request;
        this.amount = amount;
        this.pay_type = pay_type;
        this.coupon_use = coupon_use;
    }

    @JsonProperty("orderIdx")
    Integer order_idx;
    Integer shop_idx;
    Integer menu_idx;
    Integer mem_idx;
    Integer pay_idx;
    Integer delivery_idx;
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

}
