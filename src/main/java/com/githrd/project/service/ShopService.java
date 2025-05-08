package com.githrd.project.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.githrd.project.vo.ShopInfoVo;
import com.githrd.project.vo.ShopMenuVo;

public interface ShopService {

        // 가게 전체 리스트 출력
        List<ShopInfoVo> selectListAll();

        // 가게 카테고리 조회
        List<ShopInfoVo> selectListFromCate(int shop_cate_idx);
        

        // 가게 하나 검색
        ShopInfoVo selectShopOne(int shop_idx);

        // 가게 정보 입력
        int shopInsert(ShopInfoVo vo, @RequestParam(name = "photo") MultipartFile[] photo_array)
                        throws IllegalStateException, IOException;

        // 메뉴 등록
        int menuInsert(ShopMenuVo vo, @RequestParam MultipartFile photo) throws IllegalStateException, IOException;

        // 가게 정보 수정
        int shopModify(ShopInfoVo vo);

        // 메뉴 조회
        List<ShopMenuVo> selectMenuAll(int shop_idx);

        // 메뉴 하나 조회
        ShopMenuVo selectMenuOne(int menu_idx);

        // 메뉴 수정
        int menuModify(ShopMenuVo vo);

        // 메뉴 사진 수정
        int menuPhotoUpload(ShopMenuVo vo, MultipartFile photo) throws IllegalStateException, IOException;

        // 가게 사진 수정
        int PhotoUpload(ShopInfoVo vo, MultipartFile photo) throws IllegalStateException, IOException;

        // 가게 로고 수정
        int LogoUpload(ShopInfoVo vo, MultipartFile photo) throws IllegalStateException, IOException;

        // 가게 등록 여부
        int countShopByOwnerIdx(int owner_idx);

        // owner_idx로 가게 조회
        ShopInfoVo selectByOwnerIdx(int owner_idx);

        // 메뉴 삭제
        int menuDelete(int menu_idx);

        // 가게 배달비 조회
        int selectShopDfee(int shop_idx);

        // 가게 별점 수정
        int rateUpdate(int shop_idx);

        // 가게 리뷰 cnt 수정
        int reviewCntUpdate(int shop_idx);

        int selectOrderCount(int shop_idx);

        
        // 가게 카테고리 조회
        List<ShopInfoVo> selectCate();

        // 가게 검색
        List<ShopInfoVo> searchShopList(String keyword);
}
