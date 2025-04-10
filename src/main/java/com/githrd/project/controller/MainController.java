package com.githrd.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.githrd.project.dao.ShopInfoMapper;
import com.githrd.project.service.ShopService;
import com.githrd.project.vo.ShopInfoVo;

@Controller
@RequestMapping("/main")
public class MainController {

    @Autowired
    ShopService shopService;

    @Autowired
    ShopInfoMapper shopInfoMapper;

    @GetMapping("/main.do")
    public String main() {
        return "main/main";
    }

    // 가게 전체 조회
    @GetMapping("/list.do")
    public String shop_list(Model model) {

        List<ShopInfoVo> list = shopService.selectListAll();

        model.addAttribute("shop_list", list);

        return "main/shop_list";
    }

    @GetMapping("/detail.do")
    public String shop_detail() {

        return "main/shop_detail";
    }

    // @GetMapping("/order_form.do")
    // public String order_form() {
    // return "user/order_form";
    // }

}
