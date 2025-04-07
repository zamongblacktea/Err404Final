package com.githrd.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.ShopMenuVo;

@Mapper
public interface ShopMenuMapper {
    
    // 메뉴 전체 조회
    List<ShopMenuVo> selectList();
}
