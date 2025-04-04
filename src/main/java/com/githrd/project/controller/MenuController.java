package com.githrd.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/shop")
public class MenuController {

    @GetMapping("/menu_insert_form.do")
    public String insert_form(){
        return "shop/menu_insert_form";
    }
    
}
