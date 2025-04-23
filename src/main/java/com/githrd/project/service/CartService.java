package com.githrd.project.service;

import java.util.List;

import com.githrd.project.vo.CartVo;

public interface CartService {

    // 장바구니 등록여부 확인
    CartVo selectOneExist(CartVo vo);

    // 장바구니 등록
    int insert(CartVo vo);

    // 회원 별 장바구니 조회
    List<CartVo> selectList(int mem_idx);

    // 총액 구하기
    Integer selectTotalAmount(int mem_idx);

    // 메뉴 카운트 +1
    int updateCnt(CartVo reVo);

    // 메뉴 전체 삭제
    int deleteAll(int mem_idx);

}