package com.githrd.project.service;

import java.util.List;

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
        CartVo reVo = cartMapper.selectOneExist(vo);
        return reVo;
    }

    // 장바구니 등록
    @Override
    public int insert(CartVo vo) {
        int res = cartMapper.insert(vo);
        return res;
    }

    @Override
    public List<CartVo> selectList(int mem_idx) {
        return cartMapper.selectList(mem_idx);
    }

    // 총액 구하기
    @Override
    public Integer selectTotalAmount(int mem_idx) {
        return cartMapper.selectTotalAmount(mem_idx);
    }

    // 같은 메뉴 넣을시 cnt +1
    @Override
    public int updateCnt(CartVo reVo) {
        return cartMapper.updateCnt(reVo);
    }

    // 메뉴 전체 삭제
    @Override
    public int deleteAll(int mem_idx) {
        return cartMapper.deleteAll(mem_idx);
    }

    // 메뉴 cnt 감소
    @Override
    public int cntMinus(int cart_idx, int cart_cnt) {
        return cartMapper.cntMinus(cart_idx, cart_cnt);
    }

    // 메뉴 1개 삭제
    @Override
    public int menuDelete(int cart_idx) {
        return cartMapper.menuDelete(cart_idx);
    }

    // 메뉴 1개 cnt 조회
    @Override
    public int selectOneCnt(int cart_idx) {
        return cartMapper.selectOneCnt(cart_idx);
    }

    // 메뉴 1개 조회
    @Override
    public CartVo selectOne(int cart_idx) {
        return cartMapper.selectOne(cart_idx);
    }

}
