package com.githrd.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.githrd.project.dao.MemReviewMapper;
import com.githrd.project.dao.ShopInfoMapper;
import com.githrd.project.service.CartService;
import com.githrd.project.service.ShopService;
import com.githrd.project.vo.CartVo;
import com.githrd.project.vo.MemReviewVo;
import com.githrd.project.vo.MemberVo;
import com.githrd.project.vo.ShopInfoVo;
import com.githrd.project.vo.ShopMenuVo;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/main")
public class MainController {

    @Autowired
    ShopService shopService;

    @Autowired
    ShopInfoMapper shopInfoMapper;

    @Autowired
    MemReviewMapper memReviewMapper;

    @Autowired
    HttpSession session;

    @Autowired
    CartService cartService;

    @GetMapping("/main.do")
    public String main() {

        // 1. 로그인한 유저 정보 꺼내오기
		MemberVo user = (MemberVo) session.getAttribute("user");

		if (user == null) {
			return "redirect:/member/login_form.do"; // 로그인 안 했으면 로그인 폼으로
		}


        return "main/main";
    }

    // 가게 전체 조회
    @GetMapping("/list.do")
    public String shop_list(Model model) {

        List<ShopInfoVo> list = shopService.selectListAll();

        List<ShopInfoVo> cate_list = shopService.selectCate();

        model.addAttribute("shop_list", list);
        model.addAttribute("cate_list", cate_list);
        // System.out.println(list);

        return "main/shop_list";
    }

    // 가게 상세보기 폼
    @GetMapping("/detail.do")
    public String shop_detail(@RequestParam int shop_idx, Model model) {

        ShopInfoVo shop = shopService.selectShopOne(shop_idx);

        List<ShopMenuVo> menu = shopService.selectMenuAll(shop_idx);

        int shop_dfee = shopService.selectShopDfee(shop_idx);

        List<ShopInfoVo> cate_list = shopService.selectCate();

        // List<MemReviewVo> rate_list = memReviewMapper.selectShopRating(shop_idx);

        session.setAttribute("shop_dfee", shop_dfee);

        model.addAttribute("shop", shop);
        model.addAttribute("menu", menu);
        model.addAttribute("shop_dfee", shop_dfee);
        model.addAttribute("cate_list", cate_list);
        // model.addAttribute("rate", rating);
        // 임시 push

        // 장바구니 화면
        MemberVo user = (MemberVo) session.getAttribute("user");

        if (user == null) {
            return "redirect:/member/login_form.do"; // 로그인 안 했으면 로그인 폼으로
        }

        int mem_idx = user.getMem_idx();

        // 회원별 장바구니 목록
        List<CartVo> cart_list = cartService.selectList(mem_idx);
        Integer total_amount = cartService.selectTotalAmount(mem_idx);
        model.addAttribute("cart_list", cart_list);
        model.addAttribute("total_amount", total_amount);

        return "main/shop_detail";
    }

    // detail_info ajax 테스트
    @GetMapping("detail_info.do")
    public Map<String, Object> detail_info(@RequestParam int shop_idx) {

        Map<String, Object> map = new HashMap<>();

        ShopInfoVo shop = shopService.selectShopOne(shop_idx);

        List<ShopMenuVo> menu = shopService.selectMenuAll(shop_idx);

        int shop_dfee = shopService.selectShopDfee(shop_idx);

        map.put("shop", shop);
        map.put("menu", menu);
        map.put("shop_dfee", shop_dfee);

        return map;
    }

    // detail_menu ajax 테스트
    @GetMapping("detail_menu.do")
    public String detail_menu(@RequestParam int shop_idx, Model model) {

        ShopInfoVo shop = shopService.selectShopOne(shop_idx);

        List<ShopMenuVo> menu = shopService.selectMenuAll(shop_idx);

        int shop_dfee = shopService.selectShopDfee(shop_idx);

        session.setAttribute("shop_dfee", shop_dfee);

        model.addAttribute("shop", shop);
        model.addAttribute("menu", menu);
        model.addAttribute("shop_dfee", shop_dfee);

        return "/main/detail_menu";
    }

}
