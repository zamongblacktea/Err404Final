package com.githrd.project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("CategoryVo")
public class CategoryVo {
    
    int shop_cate_idx;
    String shop_cate_name;

}
