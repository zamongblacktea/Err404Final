package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
@Alias("OwnerReplyVo")
public class OwnerReply {
    
    int owner_reply_idx;
    int review_idx;
    int mem_idx;
    int owner_idx;
    int shop_idx;
    int menu_idx;
    String reply_content;
    String reply_available;
    String reply_regdate;



}
