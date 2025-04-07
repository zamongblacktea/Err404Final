package com.githrd.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/shop")
public class ShopController {
    
    @GetMapping("/insert_form.do")
    public String insert_form(@RequestParam(name="owner_idx", defaultValue = "1") int owner_idx, Model model){
        
        return "shop/shop_insert_form";
    }
    
    @GetMapping("/order_list.do")
    public String order_list(){
        return "shop/shop_order_list";
    }
    
    @GetMapping("/order_list_complete.do")
    public String order_list_complete(){
        return "shop/shop_order_list";
    }

    @GetMapping("/menu_list.do")
    public String menu_list(){
        return "shop/menu_list";
    }

    @PostMapping("/insert.do")
    public String shop_insert() {
        
        return "redirect:/shop/menu_list.do";
    }
    

    
    
}
