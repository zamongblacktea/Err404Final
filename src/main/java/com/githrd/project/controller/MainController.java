package com.githrd.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class MainController {
    
    @GetMapping("/main/list.do")
    public String shopList() {
        return "main/shop_list";
    }
    
}
