package com.githrd.project.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.githrd.project.dao.OwnerMapper;
import com.githrd.project.dao.ShopInfoMapper;
import com.githrd.project.dao.ShopMenuMapper;
import com.githrd.project.service.ShopService;
import com.githrd.project.vo.OwnerVo;
import com.githrd.project.vo.ShopInfoVo;
import com.githrd.project.vo.ShopMenuVo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
@RequestMapping("/shop")
public class ShopController {

    @Autowired
    ShopService shopService;

    @Autowired
    ShopInfoMapper shopInfoMapper;

    @Autowired
    ShopMenuMapper shopMenuMapper;

    @Autowired
    HttpSession session;

    @Autowired
    HttpServletRequest request;

    @Autowired
    ServletContext application;

    // 주문현황리스트
    @GetMapping("/order_list.do")
    public String order_list() {
        return "shop/shop_order_list";
    }

    // 주문완료리스트
    @GetMapping("/order_list_complete.do")
    public String order_list_complete() {
        return "shop/shop_order_list";
    }

    // 가게 메뉴 조회
    @GetMapping("/menu_list.do")
    public String menu_list(@RequestParam int shop_idx, Model model) {

        List<ShopMenuVo> list = shopService.selectMenuAll(shop_idx);

        model.addAttribute("list", list);
        return "shop/menu_list";
    }

    // 가게 메뉴 등록 폼
    @GetMapping("/menu_insert_form.do")
    public String menu_insert_form(@RequestParam(name = "shop_idx") int shop_idx, Model model) {

        // ShopInfoVo shop_info_vo = shopInfoMapper.selectShopOne(shop_idx);

        // model.addAttribute("shop_list", shop_list);
        return "shop/menu_insert_form";
    }

    // 가게 메뉴 등록
    @PostMapping("/menu_insert.do")
    public String menu_insert(ShopMenuVo vo, @RequestParam MultipartFile photo, Model model) {

        int menu_insert_no = 0;

        // 임시로 가게 idx를 1로 고정
        // vo.setShop_idx(1);

        try {
            menu_insert_no = shopService.menuInsert(vo, photo);
        } catch (IllegalStateException | IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        model.addAttribute("menu_insert_no", menu_insert_no);

        return "redirect:menu_list.do";
    }

    // 메뉴 수정 폼
    @GetMapping("/menu_modify_form.do")
    public String menu_modify_form(@RequestParam int menu_idx,
            @RequestParam int shop_idx, Model model) {

        ShopMenuVo vo = shopService.selectMenuOne(menu_idx);

        model.addAttribute("vo", vo);

        return "shop/menu_modify_form";
    }

    // 메뉴 수정
    @PostMapping("/menu_modify.do")
    public String menu_modify(ShopMenuVo vo, Model model) {

        int menu_modify_no = 0;

        // 임시로 메뉴idx 1로 고정
        // vo.setMenu_idx(1);

        try {
            menu_modify_no = shopService.menuModify(vo);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        model.addAttribute("menu_modify_no", menu_modify_no);

        return "redirect:menu_list.do";
    }

    // 메뉴 사진 수정
    @PostMapping("/menu_photo_upload.do")
    @ResponseBody
    public Map<String, String> menu_photo_upload(ShopMenuVo vo, @RequestParam(required = false) MultipartFile photo,
            Model model)
            throws IllegalStateException, IOException {
        int res = 0;

        // 임시로 고정
        // vo.setMenu_idx(1);

        res = shopService.menuPhotoUpload(vo, photo);

        // model.addAttribute("res", res);

        Map<String, String> map = new HashMap<>();

        if (res > 0) {
            map.put("menu_img", vo.getMenu_img()); // 성공 시, 이미지 파일명 리턴
        } else {
            map.put("error", "업로드 실패");
        }

        return map;
    }

    // 가게 등록 폼
    @GetMapping("/insert_form.do")
    public String insert_form(@RequestParam int owner_idx, Model model) {

        model.addAttribute("user", session.getAttribute("user"));

        return "shop/shop_insert_form";
    }

    // 가게 등록
    @PostMapping("/insert.do")
    public String shop_insert(ShopInfoVo vo, @RequestParam(name = "photo") MultipartFile[] photo_array, Model model) {

        int shop_insert_no = 0;

        // 임시로 사장idx를 1로 고정
        // vo.setOwner_idx(1);

        try {
            shop_insert_no = shopService.shopInsert(vo, photo_array);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        // Redirect시 Parameter로 이용
        model.addAttribute("shop_insert_no", shop_insert_no);

        System.out.println("vo 등록: " + vo);

        // model.addAttribute("shop_idx", vo.getShop_idx());

        return "redirect:menu_insert_form.do";
    }

    // 가게 정보 수정 폼
    @GetMapping("/modify_form.do")
    public String shop_modify_form(@RequestParam int shop_idx, Model model) {

        ShopInfoVo shop = shopService.selectShopOne(shop_idx);

        model.addAttribute("shop", shop);

        return "shop/shop_modify_form";
    }

    // 가게 정보 수정
    @PostMapping("/modify.do")
    public String shop_modify(ShopInfoVo vo, Model model) {

        int shop_modify_no = 0;

        // 임시로 shop_idx 1로 설정
        // vo.setShop_idx(2);

        try {
            shop_modify_no = shopService.shopModify(vo);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        model.addAttribute("shop_modify_no", shop_modify_no);

        return "redirect:order_list.do";
    }

    // 가게 사진 수정
    @PostMapping("/photo_upload.do")
    @ResponseBody
    public Map<String, String> photo_upload(ShopInfoVo vo, @RequestParam(required = false) MultipartFile photo,
            Model model)
            throws IllegalStateException, IOException {
        int res = 0;

        // 임시로 고정
        // vo.setShop_idx(1);

        res = shopService.PhotoUpload(vo, photo); // shop_img 수정

        // model.addAttribute("res", res);

        Map<String, String> map = new HashMap<>();

        if (res > 0) {
            map.put("shop_img", vo.getShop_img()); // 성공 시, 이미지 파일명 리턴

        } else {
            map.put("error", "업로드 실패");
        }

        return map;
    }

    // 가게 로고 수정
    @PostMapping("/logo_upload.do")
    @ResponseBody
    public Map<String, String> logo_upload(ShopInfoVo vo, @RequestParam(required = false) MultipartFile photo,
            Model model)
            throws IllegalStateException, IOException {
        int res = 0;

        // 임시로 고정
        // vo.setShop_idx(1);

        System.out.println("shop_idx : " + vo.getShop_idx());
        res = shopService.LogoUpload(vo, photo); // shop_img 수정

        // model.addAttribute("res", res);

        Map<String, String> map = new HashMap<>();

        if (res > 0) {
            map.put("shop_logo", vo.getShop_logo()); // 성공 시, 이미지 파일명 리턴

        } else {
            map.put("error", "업로드 실패");
        }

        return map;
    }

}
