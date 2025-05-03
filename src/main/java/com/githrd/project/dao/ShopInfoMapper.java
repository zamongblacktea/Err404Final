package com.githrd.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.ShopInfoVo;

@Mapper
public interface ShopInfoMapper {

    // 가게 주소얻기
    String getShopAddr(int shop_idx);

    // 가게 전체 출력
    List<ShopInfoVo> selectListAll();

    //가게 카테고리 별로 출력
    List<ShopInfoVo> selectListFromCate(int shop_cate_idx);

    
    // 가게 하나만 출력
    ShopInfoVo selectShopOne(int shop_idx);

    
    // 가게 입력
    int shopInsert(ShopInfoVo vo);

    // 가게 수정
    int shopModify(ShopInfoVo vo);

    // 가게 사진 수정
    int PhotoUpload(ShopInfoVo vo);

    // 로고 수정
    int LogoUpload(ShopInfoVo vo);

    // 가게 등록 여부
    int countShopByOwnerIdx(int owner_idx);

    // owner_idx로 가게 조회
    ShopInfoVo selectByOwnerIdx(int owner_idx);

    // 가게 배달비 조회
    int selectShopDfee(int shop_idx);

    // 별점 업데이트
    int rateUpdate(int shop_idx);

    // 리뷰 수 업데이트
    int reviewCntUpdate(int shop_idx);

    int selectOrderCount(int shop_idx);

    // 카테고리 조회
    List<ShopInfoVo> selectCate();

   
}
