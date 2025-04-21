package com.githrd.project.dao;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.CartVo;

@Mapper
public interface CartMapper {

    // 장바구니 등록여부 확인
    CartVo selectIneExist(CartVo vo);

    // 장바구니 등록
    int insert(CartVo vo);

}
