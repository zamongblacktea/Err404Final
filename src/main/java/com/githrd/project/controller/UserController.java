package com.githrd.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserController {
    // @GetMapping("/list.do")
    // public String shopList() {
    //     return "user/shop_list";
    // }
    
    // @GetMapping("/detail.do")
    // public String shopDetail() {
    //     return "user/shop_detail";
    // }
    
    @GetMapping("/order_form.do")
    public String order_form() {
        return "user/order_form";
    }

    @GetMapping("/order_detail.do")
    public String order_detail(){
        return "user/order_detail";
    }

    @GetMapping("/order_list.do")
    public String order_list(){
        return "user/order_list";
    }

    @GetMapping("/cart_list.do")
    public String cart_list(){
        return "user/cart_list";
    }


}
