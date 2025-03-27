package com.githrd.demo.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.demo.vo.CartVo;

@Mapper
public interface CartMapper {

    //회원별 장바구니 리스트 조회
    List<CartVo> selectList(int mem_idx);

    //회원별 장바구니 총액 조회
    int          selectTotalAmount(int mem_idx);

    //1건 조회
    CartVo       selectOne(int cart_idx);

    //장바구니 중복 여부 확인(prod_idx/mem_idx 로 확인하기)
    CartVo       selectExist(CartVo vo);
    
    //CRUD
    int                 insert(CartVo vo);
    int                 update(CartVo vo);
    int                 delete(CartVo vo);


}
