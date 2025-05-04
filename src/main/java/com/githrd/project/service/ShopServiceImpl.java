package com.githrd.project.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.githrd.project.dao.MemReviewMapper;
import com.githrd.project.dao.OrderStatusMapper;
import com.githrd.project.dao.ShopInfoMapper;
import com.githrd.project.dao.ShopMenuMapper;
import com.githrd.project.vo.OwnerVo;
import com.githrd.project.vo.ShopInfoVo;
import com.githrd.project.vo.ShopMenuVo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;

@Service
public class ShopServiceImpl implements ShopService {

    @Autowired
    ShopInfoMapper shopInfoMapper;

    @Autowired
    ShopMenuMapper shopMenuMapper;

    @Autowired
    OrderStatusMapper orderStatusMapper;

    @Autowired
    MemReviewMapper memReviewMapper;

    @Autowired
    HttpSession session;

    @Autowired
    ServletContext application;

    // 가게 리스트 전체 목록
    @Override
    public List<ShopInfoVo> selectListAll() {
        return shopInfoMapper.selectListAll();
    }

    // 가게 하나 검색
    @Override
    public ShopInfoVo selectShopOne(int shop_idx) {
        return shopInfoMapper.selectShopOne(shop_idx);
    }

    // 가게 등록
    @Override
    public int shopInsert(ShopInfoVo vo, @RequestParam(name = "photo") MultipartFile[] photo_array)
            throws IllegalStateException, IOException {
        OwnerVo user = (OwnerVo) session.getAttribute("user");

        // \n -> <br>
        String shop_notice = vo.getShop_notice().replaceAll("\n", "<br>");
        String shop_intro = vo.getShop_intro().replaceAll("\n", "<br>");
        vo.setShop_notice(shop_notice);
        vo.setShop_intro(shop_intro);

        // 파일 처리
        // 웹경로 -> 절대경로 구하기
        String saveDir = application.getRealPath("/images/");
        String shop_logo = "no_file";
        String shop_img = "no_file";

        for (int i = 0; i < photo_array.length; i++) {
            MultipartFile photo = photo_array[i];
            if (!photo.isEmpty()) {
                // 업로드된 파일명 구하기
                String filename = photo.getOriginalFilename();
                File f = new File(saveDir, filename);

                // 중복파일 체크
                if (f.exists()) {
                    long tm = System.currentTimeMillis();
                    filename = String.format("%d_%s", tm, filename);
                    f = new File(saveDir, filename);
                }

                // 임시 공간에 저장된 파일 -> 내가 지정한 파일로 복사
                photo.transferTo(f);

                if (i == 0) {
                    shop_logo = filename;

                } else if (i == 1) {
                    shop_img = filename;
                }
            }
        } // end : for

        // 업로드된 파일정보 vo에 넣는다
        vo.setShop_logo(shop_logo);
        vo.setShop_img(shop_img);

        // DB insert
        int res = shopInfoMapper.shopInsert(vo);

        return res;
    }

    // 메뉴 등록
    @Override
    public int menuInsert(ShopMenuVo vo, @RequestParam MultipartFile photo) throws IllegalStateException, IOException {

        Integer shop_idx = (Integer) session.getAttribute("shop_idx");

        vo.setShop_idx(shop_idx);

        // \n -> <br>
        String menu_explain = vo.getMenu_explain().replaceAll("\n", "<br>");
        vo.setMenu_explain(menu_explain);

        // 저장위치 얻어오기
        String saveDir = application.getRealPath("/images/");

        System.out.println(saveDir);

        String filename = "no_file";

        // 업로드된 화일이 있으면
        if (photo.isEmpty() == false) { // if(!photo.isEmpty())

            // 업로드된 화일이름 얻어오기
            filename = photo.getOriginalFilename();

            File f = new File(saveDir, filename);
            // 화일존재유무체크
            if (f.exists()) {

                long tm = System.currentTimeMillis();
                // 화일이름변경 : 시간_화일명
                filename = String.format("%d_%s", tm, filename);

                f = new File(saveDir, filename);
            }

            // 임시화일(photo)을 f로 지정된 화일로 복사
            photo.transferTo(f);
        }
        vo.setMenu_img(filename);

        int res = shopMenuMapper.menuInsert(vo);

        return res;
    }

    // 가게 정보 수정
    // @Override
    // public int shopModify(ShopInfoVo vo, MultipartFile[] photo_array) throws
    // IllegalStateException, IOException {
    // OwnerVo user = (OwnerVo) session.getAttribute("user");

    // // \n -> <br> 변환
    // String shop_notice = vo.getShop_notice().replaceAll("\n", "<br>");
    // String shop_intro = vo.getShop_intro().replaceAll("\n", "<br>");
    // vo.setShop_notice(shop_notice);
    // vo.setShop_intro(shop_intro);

    // // 저장 경로
    // String saveDir = application.getRealPath("/images/");

    // // 기존 이미지 가져오기 (DB에서 미리 채워둔다고 가정)
    // String shop_logo = vo.getShop_logo() != null ? vo.getShop_logo() : "no_file";
    // String shop_img = vo.getShop_img() != null ? vo.getShop_img() : "no_file";

    // for (int i = 0; i < photo_array.length; i++) {
    // MultipartFile photo = photo_array[i];
    // if (!photo.isEmpty()) {
    // String filename = photo.getOriginalFilename();
    // File f = new File(saveDir, filename);

    // // 기존 이미지 확인 및 삭제
    // File oldFile = new File(saveDir, filename);

    // if (i == 0 && !"no_file".equals(shop_logo)) {
    // File oldLogo = new File(saveDir, shop_logo);
    // if (oldLogo.exists()) oldLogo.delete();
    // }
    // if (i == 1 && !"no_file".equals(shop_img)) {
    // File oldImg = new File(saveDir, shop_img);
    // if (oldImg.exists()) oldImg.delete();
    // }

    // System.out.println("이미지 삭제 완료");

    // // 중복 파일명 처리
    // if (f.exists()) {
    // long tm = System.currentTimeMillis();
    // filename = tm + "_" + filename;
    // f = new File(saveDir, filename);
    // }

    // // 파일 복사
    // photo.transferTo(f);

    // if (i == 0) {
    // shop_logo = filename;
    // } else if (i == 1) {
    // shop_img = filename;
    // }
    // }
    // }

    // // 변경된 이미지명 세팅
    // vo.setShop_logo(shop_logo);
    // vo.setShop_img(shop_img);

    // // DB update
    // int res = shopInfoMapper.shopModify(vo);

    // return res;

    // }

    // 가게 정보 수정
    @Override
    public int shopModify(ShopInfoVo vo) {
        OwnerVo user = (OwnerVo) session.getAttribute("user");

        // \n -> <br> 변환
        String shop_notice = vo.getShop_notice().replaceAll("\n", "<br>");
        String shop_intro = vo.getShop_intro().replaceAll("\n", "<br>");
        vo.setShop_notice(shop_notice);
        vo.setShop_intro(shop_intro);

        // DB 업데이트
        int res = shopInfoMapper.shopModify(vo);
        return res;
    }

    // 메뉴 전체 조회
    @Override
    public List<ShopMenuVo> selectMenuAll(int shop_idx) {
        return shopMenuMapper.selectMenuAll(shop_idx);
    }

    // 메뉴 하나 조회
    @Override
    public ShopMenuVo selectMenuOne(int menu_idx) {
        return shopMenuMapper.selectMenuOne(menu_idx);
    }

    // 메뉴 수정
    @Override
    public int menuModify(ShopMenuVo vo) {
        ShopInfoVo shop = (ShopInfoVo) session.getAttribute("shop");

        // \n -> <br>
        String menu_explain = vo.getMenu_explain().replaceAll("\n", "<br>");
        vo.setMenu_explain(menu_explain);

        int res = shopMenuMapper.menuModify(vo);
        return res;
    }

    // 메뉴 사진 수정
    @Override
    public int menuPhotoUpload(ShopMenuVo vo, MultipartFile photo) throws IllegalStateException, IOException {

        // 저장 경로
        String saveDir = application.getRealPath("/images/");

        // 기존 이미지 파일명 (DB에서 채워져 있다고 가정)
        // String menu_img = vo.getMenu_img() != null ? vo.getMenu_img() : "no_file";

        // 기존 이미지 삭제
        if (vo.getMenu_img() != null && !"no_file".equals(vo.getMenu_img())) {
            File oldImg = new File(saveDir, vo.getMenu_img());
            if (oldImg.exists())
                oldImg.delete();
        }

        String menu_img = photo.getOriginalFilename();

        String filename = menu_img;

        // 중복 방지를 위한 파일명 처리
        File f = new File(saveDir, filename);
        if (f.exists()) {
            long tm = System.currentTimeMillis();
            filename = tm + "_" + filename;
            f = new File(saveDir, filename);
        }
        // 파일 저장
        photo.transferTo(f);

        vo.setMenu_img(filename);

        int res = shopMenuMapper.menuPhotoUpload(vo);

        return res;
    }

    // 가게 사진 수정
    @Override
    public int PhotoUpload(ShopInfoVo vo, MultipartFile photo) throws IllegalStateException, IOException {
        // 저장 경로
        String saveDir = application.getRealPath("/images/");

        // 기존 이미지 파일명 (DB에서 채워져 있다고 가정)
        // String menu_img = vo.getMenu_img() != null ? vo.getMenu_img() : "no_file";

        // 기존 이미지 삭제
        if (vo.getShop_img() != null && !"no_file".equals(vo.getShop_img())) {
            File oldImg = new File(saveDir, vo.getShop_img());
            if (oldImg.exists())
                oldImg.delete();
        }

        String shop_img = photo.getOriginalFilename();

        String filename = shop_img;

        // 중복 방지를 위한 파일명 처리
        File f = new File(saveDir, filename);
        if (f.exists()) {
            long tm = System.currentTimeMillis();
            filename = tm + "_" + filename;
            f = new File(saveDir, filename);
        }
        // 파일 저장
        photo.transferTo(f);

        vo.setShop_img(filename);

        int res = shopInfoMapper.PhotoUpload(vo);

        return res;
    }

    // 가게 로고 수정
    @Override
    public int LogoUpload(ShopInfoVo vo, MultipartFile photo) throws IllegalStateException, IOException {
        // 저장 경로
        String saveDir = application.getRealPath("/images/");

        // 기존 이미지 파일명 (DB에서 채워져 있다고 가정)
        // String menu_img = vo.getMenu_img() != null ? vo.getMenu_img() : "no_file";

        // 기존 이미지 삭제
        if (vo.getShop_logo() != null && !"no_file".equals(vo.getShop_logo())) {
            File oldImg = new File(saveDir, vo.getShop_logo());
            if (oldImg.exists())
                oldImg.delete();
        }

        String shop_logo = photo.getOriginalFilename();

        String filename = shop_logo;

        // 중복 방지를 위한 파일명 처리
        File f = new File(saveDir, filename);
        if (f.exists()) {
            long tm = System.currentTimeMillis();
            filename = tm + "_" + filename;
            f = new File(saveDir, filename);
        }
        // 파일 저장
        photo.transferTo(f);

        vo.setShop_logo(filename);

        int res = shopInfoMapper.LogoUpload(vo);

        return res;
    }

    // 로그인한 유저가 가게 등록했는지 체크
    @Override
    public int countShopByOwnerIdx(int owner_idx) {
        OwnerVo user = (OwnerVo) session.getAttribute("user");

        return shopInfoMapper.countShopByOwnerIdx(user.getOwner_idx());
    }

    // owner_idx로 가게 조회
    @Override
    public ShopInfoVo selectByOwnerIdx(int owner_idx) {
        return shopInfoMapper.selectByOwnerIdx(owner_idx);
    }

    // 메뉴 삭제
    @Override
    public int menuDelete(int menu_idx) {
        return shopMenuMapper.menuDelete(menu_idx);
    }

    // 가게 배달비 조회
    @Override
    public int selectShopDfee(int shop_idx) {
        return shopInfoMapper.selectShopDfee(shop_idx);
    }

    // 가게 별점 수정
    @Override
    public int rateUpdate(int shop_idx) {
        return shopInfoMapper.rateUpdate(shop_idx);
    }

    @Override
    public int reviewCntUpdate(int shop_idx) {
        return shopInfoMapper.reviewCntUpdate(shop_idx);
    }

    @Override
    public int selectOrderCount(int shop_idx) {
        return orderStatusMapper.selectOrderCount(shop_idx);
    }

    // 카테고리 조회
    @Override
    public List<ShopInfoVo> selectListFromCate(int shop_cate_idx) {
        return shopInfoMapper.selectListFromCate(shop_cate_idx);

    }
        
     

    public List<ShopInfoVo> selectCate() {
        return shopInfoMapper.selectCate();
    }

}
