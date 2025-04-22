package com.githrd.project.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.githrd.project.dao.OrderStatusMapper;
import com.githrd.project.service.ShopService;
import com.githrd.project.vo.OrderStatusVo;
import com.githrd.project.vo.OwnerVo;
import com.githrd.project.vo.ShopInfoVo;

import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;


@RequestMapping("/shop")
@Controller
public class OrderStatusController {


    @Autowired
    ShopService shopService;

    @Autowired
    OrderStatusMapper orderStatusMapper;

    @Autowired
    HttpSession session;


    //주문현황 페이지 폼 열기
    @GetMapping("/order_list.do")
    public String order_list(Model model,int shop_idx) {
        OwnerVo owner = (OwnerVo) session.getAttribute("user");
        int owner_idx = owner.getOwner_idx();
        ShopInfoVo shop = shopService.selectByOwnerIdx(owner_idx);

        List<OrderStatusVo> list = orderStatusMapper.selectList(shop_idx);

        
        if (shop == null) {
            return "redirect:/shop/insert_form.do?owner_idx=" + owner_idx;
        }

        session.setAttribute("shop_idx", shop.getShop_idx());
        model.addAttribute("shop", shop);
        model.addAttribute("status", list);
        return "shop/shop_order_list";
    }


    //주문현황 상태 ajax 업데이트
    @PostMapping("/update_status.do")
    @ResponseBody
    public Map<String , String> updateStatus(@RequestBody OrderStatusVo vo){


        int res = orderStatusMapper.updateStatus(vo);


        return Map.of("updateStatus",vo.getOrder_status());
    }//end: update_status




}
