package com.githrd.project.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.githrd.project.dao.ShopInfoMapper;
import com.githrd.project.dao.ShopMenuMapper;
import com.githrd.project.service.ShopService;
import com.githrd.project.vo.ShopInfoVo;
import com.githrd.project.vo.ShopMenuVo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

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

    @GetMapping("/order_list.do")
    public String order_list() {
        return "shop/shop_order_list";
    }

    @GetMapping("/order_list_complete.do")
    public String order_list_complete() {
        return "shop/shop_order_list";
    }

    // 가게 메뉴 조회
    @GetMapping("/menu_list.do")
    public String menu_list() {
        return "shop/menu_list";
    }

    // 가게 메뉴 등록 폼
    @GetMapping("/menu_insert_form.do")
    public String menu_insert_form(@RequestParam(name = "shop_idx", defaultValue = "1") int shop_idx, Model model) {

        // ShopInfoVo shop_info_vo = shopInfoMapper.selectShopOne(shop_idx);

        // model.addAttribute("shop_list", shop_list);
        return "shop/menu_insert_form";
    }

    @PostMapping("/menu_insert.do")
    public String menu_insert(ShopMenuVo vo, @RequestParam MultipartFile photo, Model model) {

        int menu_insert_no = 0;

        // 임시로 가게 idx를 1로 고정
        vo.setShop_idx(1);

        try {
            menu_insert_no = shopService.menuInsert(vo, photo);
        } catch (IllegalStateException | IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        model.addAttribute("menu_insert_no", menu_insert_no);

        return "redirect:menu_list.do";
    }

    // 가게 등록 폼
    @GetMapping("/insert_form.do")
    public String insert_form(@RequestParam(name = "owner_idx", defaultValue = "1") int owner_idx, Model model) {

        return "shop/shop_insert_form";
    }

    @PostMapping("/insert.do")
    public String shop_insert(ShopInfoVo vo, @RequestParam(name = "photo") MultipartFile[] photo_array, Model model) {

        int shop_insert_no = 0;

        // 임시로 사장idx를 1로 고정
        vo.setOwner_idx(1);

        try {
            shop_insert_no = shopService.shopInsert(vo, photo_array);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        // Redirect시 Parameter로 이용
        model.addAttribute("shop_insert_no", shop_insert_no);

        return "redirect:menu_insert_form.do";
    }

}
