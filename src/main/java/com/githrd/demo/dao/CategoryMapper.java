package com.githrd.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.demo.vo.CategoryVo;

@Mapper
public interface CategoryMapper {
    

    public List<CategoryVo> selectList(); 



}
