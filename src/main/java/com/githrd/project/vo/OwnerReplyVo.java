package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Builder;
import lombok.Data;

@Data
@Alias("OwnerReplyVo")
public class OwnerReplyVo {
    
    int owner_reply_idx;
    int mem_idx;
    int review_idx;
    int owner_idx;
    int shop_idx;
    int order_idx;
    String reply_content;
    String reply_available;
    String reply_regdate;



}
