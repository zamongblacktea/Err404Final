package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("MemReviewVo")
public class MemReviewVo {
    
    int review_idx;
    int mem_idx;
    int order_idx;
    int shop_idx;
    int delivery_idx;
    String review_content;
    String review_regdate;
    String review_update;
    String review_pwd;
    double review_rating;
    int review_available;
    String delivery_status;
    String menu_idx;
    







}
