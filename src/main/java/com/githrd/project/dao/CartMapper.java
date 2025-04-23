package com.githrd.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.CartVo;

@Mapper
public interface CartMapper {

    // 장바구니 등록여부 확인
    CartVo selectOneExist(CartVo vo);

    // 장바구니 등록
    int insert(CartVo vo);

    // 장바구니 리스트 조회
    List<CartVo> selectList(int mem_idx);

    // 장바구니 총액 구하기
    Integer selectTotalAmount(int mem_idx);

    // 메뉴 +1
    int updateCnt(CartVo reVo);

    // 장바구니에 있는 메뉴의 가게와 등록할 메뉴의 가게가 같은지
    int selectShopEqual(CartVo vo);

    // 메뉴 전체 삭제
    int deleteAll(int mem_idx);

}
