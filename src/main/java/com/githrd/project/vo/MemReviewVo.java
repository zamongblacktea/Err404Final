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
    double review_rating;
    String review_img;
    String review_ip;
    int review_available;
    String delivery_status;
    int menu_idx;
    String menu_name;
    







}
