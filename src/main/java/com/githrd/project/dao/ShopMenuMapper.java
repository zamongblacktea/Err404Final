package com.githrd.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.ShopMenuVo;

@Mapper
public interface ShopMenuMapper {

    // 메뉴 전체 조회
    List<ShopMenuVo> selectMenuAll(int shop_idx);

    // 메뉴 하나 조회
    ShopMenuVo selectMenuOne(int menu_idx);

    // 메뉴 등록
    int menuInsert(ShopMenuVo vo);

    // 메뉴 수정
    int menuModify(ShopMenuVo vo);

    // 메뉴 사진 수정
    int menuPhotoUpload(ShopMenuVo vo);

    // 메뉴 삭제
    int menuDelete(int menu_idx);

}
