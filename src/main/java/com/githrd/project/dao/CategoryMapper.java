package com.githrd.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.CategoryVo;

@Mapper
public interface CategoryMapper {
    
    List<CategoryVo> selectCategoryList();
}
