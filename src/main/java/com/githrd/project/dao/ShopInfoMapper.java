package com.githrd.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.ShopInfoVo;

@Mapper
public interface ShopInfoMapper {

    // 가게 전체 출력
    List<ShopInfoVo> selectListAll();

    // 가게 하나만 출력
    ShopInfoVo selectShopOne(int shop_idx);

    // 가게 입력
    int shopInsert(ShopInfoVo vo);

}
