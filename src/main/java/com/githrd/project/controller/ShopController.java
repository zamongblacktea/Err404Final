package com.githrd.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/shop")
public class ShopController {
    
    @GetMapping("/shop_insert_form.do")
    public String shop_insert(){
        return "shop/shop_insert_form";
    }
}
