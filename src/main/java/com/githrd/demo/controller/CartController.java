package com.githrd.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.githrd.demo.dao.CartMapper;
import com.githrd.demo.vo.CartVo;



@Controller
public class CartController {
    
    @Autowired
    CartMapper cartMapper;

    //constructor injection으로 생성
    // @Autowired
    // public CartController(CartMapper cartMapper) {
    //     this.cartMapper = cartMapper;
    // }
    
    //setter injection
    // @Autowired
    // public void setCartMapper(CartMapper cartMapper) {
    //     this.cartMapper = cartMapper;
    // }
    


    //장바구니 등록
    //전송 방식을 2개 이상 쓸 때는 { }로 묶어서 사용한다.
    @RequestMapping(value = "/cart/insert.do", method={RequestMethod.GET , RequestMethod.POST})
    @ResponseBody //JSON converter 설정
    public Map<String, Object> insert(CartVo vo) {

        Map<String, Object> map = new HashMap<>();

        //장바구니 중복 여부 확인
        CartVo existVo = cartMapper.selectExist(vo);
        if(existVo != null){
            map.put("result", "exist");
        }else{
            int res = cartMapper.insert(vo);

            //중복없이 성공했을 때 1 리턴
            if(res==1){
                map.put("result", "success");
            }else{
                map.put("result", "fail");
            }
        }
        return map;
    }
    

    //장바구니 목록 조회
    @GetMapping("/cart/list.do")
    public String list(int mem_idx , Model model) {

        List<CartVo> list = cartMapper.selectList(mem_idx);

        int total_amount = cartMapper.selectTotalAmount(mem_idx);

        model.addAttribute("total_amount", total_amount);
        model.addAttribute("list", list);
        return "cart/cart_list";
    }


 
}
