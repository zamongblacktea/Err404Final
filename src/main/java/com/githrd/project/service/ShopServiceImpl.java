package com.githrd.project.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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

    @Override
    public int menuInsert(ShopMenuVo vo, @RequestParam MultipartFile photo) throws IllegalStateException, IOException {

        ShopInfoVo shop = (ShopInfoVo) session.getAttribute("shop");

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

}
