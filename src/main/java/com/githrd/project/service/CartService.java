package com.githrd.project.service;

import com.githrd.project.vo.CartVo;

public interface CartService {

    // 장바구니 등록여부 확인
    CartVo selectOneExist(CartVo vo);

    // 장바구니 등록
    int insert(CartVo vo);

}