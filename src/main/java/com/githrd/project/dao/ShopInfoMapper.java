package com.githrd.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.ShopInfoVo;

@Mapper
public interface ShopInfoMapper {
    
    // 가게 전체 출력
    List<ShopInfoVo> selectListAll();
}
