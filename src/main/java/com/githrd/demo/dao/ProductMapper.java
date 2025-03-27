package com.githrd.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.demo.vo.ProductVo;

@Mapper
public interface ProductMapper {
    //public abstract 생략 가능

    //전체 상품 조회(카테고리별)
    List<ProductVo> selectList(int cate_idx); 
    
    //하나 조회
    ProductVo selectOne(int prod_idx);

    //글쓰기
    int insert(ProductVo vo);

    //수정
    int update(ProductVo vo);

    //삭제
    int delete(int prod_idx);



}
