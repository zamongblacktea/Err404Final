package com.githrd.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.githrd.project.dao.CartMapper;
import com.githrd.project.vo.CartVo;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    CartMapper cartMapper;

    // 장바구니 등록 여부 확인
    @Override
    public CartVo selectOneExist(CartVo vo) {
        CartVo reVo = cartMapper.selectIneExist(vo);
        return reVo;
    }

    // 장바구니 등록
    @Override
    public int insert(CartVo vo) {
        int res = cartMapper.insert(vo);
        return res;
    }

}
