package com.githrd.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;



@Controller
@RequestMapping("/main")
public class MainController {

    @GetMapping("/main.do")
    public String main() {
        return "main/main";
    }
    
    
    @GetMapping("/list.do")
    public String shopList() {
        return "main/shop_list";
    }
    
    @GetMapping("/detail.do")
    public String shopDetail() {
        return "main/shop_detail";
    }
    
    @GetMapping("/order_form.do")
    public String order_form() {
        return "main/order_form";
    }
    
}
