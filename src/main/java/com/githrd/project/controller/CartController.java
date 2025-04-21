package com.githrd.project.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.githrd.project.service.CartService;
import com.githrd.project.vo.CartVo;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    CartService cartService;

    // 카트에 등록
    @GetMapping("/insert.do")
    public Map<String, Object> insert(CartVo vo) {

        // 결과
        Map<String, Object> map = new HashMap<String, Object>();

        // 장바구니에 등록되었는지 여부
        CartVo reVo = cartService.selectOneExist(vo);

        if (reVo != null) {
            map.put("result", "exist");
        } else {
            int res = cartService.insert(vo);

            if (res == 1) {
                map.put("result", " success");
            } else {
                map.put("result", "fail");
            }
        }

        return map;

    }
}
