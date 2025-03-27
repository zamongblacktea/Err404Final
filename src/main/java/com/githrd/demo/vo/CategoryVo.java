package com.githrd.demo.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("CategoryVo")
public class CategoryVo {
    int cate_idx;
    String cate_name;




}
