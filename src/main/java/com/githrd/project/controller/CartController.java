package com.githrd.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.githrd.project.service.CartService;
import com.githrd.project.service.ShopService;
import com.githrd.project.vo.CartVo;
import com.githrd.project.vo.MemberVo;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    CartService cartService;

    @Autowired
    ShopService shopService;

    @Autowired
    HttpSession session;

    // 카트에 등록
    @RequestMapping(value = "/insert.do", method = { RequestMethod.GET, RequestMethod.POST })
    @ResponseBody
    public Map<String, Object> insert(CartVo vo, @RequestParam(required = false) Boolean force) {
        // System.out.println("---------------------------------------------------------------------");

        // 결과
        Map<String, Object> map = new HashMap<String, Object>();
        // System.out.println("---------------------------------Map------------------------------------");

        // 장바구니에 등록되었는지 여부
        CartVo reVo = cartService.selectOneExist(vo);
        // 현재 유저의 장바구니 전체 조회 (shop_idx 비교용)
        List<CartVo> cartList = cartService.selectList(vo.getMem_idx());

        // CartVo cartOne = cartService.selectOneMem(vo.getMem_idx());

        // 장바구니가 비어있지 않고, 다른 가게의 상품이 담겨 있으면 장바구니 비우기
        if (!cartList.isEmpty()) {
            // int currentShop = cartOne.getShop_idx();
            int currentShop = cartList.get(0).getShop_idx();
            // System.out.println(currentShop);
            int newShopIdx = vo.getShop_idx();
            // System.out.println(newShopIdx);
            if (currentShop != newShopIdx) {
                if (force == null || !force) {
                    map.put("result", "deleted");
                    return map;
                } else {
                    cartService.deleteAll(vo.getMem_idx());
                }
            }
        }

        if (reVo != null) {
            // map.put("result", "exist");
            reVo.setCart_cnt(reVo.getCart_cnt() + 1);
            int res = cartService.updateCnt(reVo);
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

    // 장바구니 리스트 조회
    @RequestMapping(value = "/list.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String cart_list(Model model, RedirectAttributes ra) {

        MemberVo user = (MemberVo) session.getAttribute("user");
        // 세션 만료 체크
        if (session.getAttribute("user") == null) {
            ra.addAttribute("reason", "session_timeout");
            return "redirect:../member/login_form.do";
        }

        int mem_idx = user.getMem_idx();

        // 회원별 장바구니 목록
        List<CartVo> cart_list = cartService.selectList(mem_idx);

        // 임시 : cart_list가 비어있을때 가게 리스트로 리다이렉트
        // 임시라서 가능하면 alert로 장바구니가 비어있다고 안내 해주면 좋을듯
        if (cart_list.size() == 0) {
            return "redirect:/main/list.do";
        }
        Integer total_amount = cartService.selectTotalAmount(mem_idx);
        int shop_idx = cart_list.get(0).getShop_idx();
        int shop_dfee = shopService.selectShopDfee(shop_idx);
        System.out.println(shop_dfee);

        model.addAttribute("shop_idx", shop_idx);
        model.addAttribute("cart_list", cart_list);
        model.addAttribute("total_amount", total_amount);
        model.addAttribute("shop_dfee", shop_dfee);

        return "user/cart_list";
    }

    // 장바구니 리스트 조회 뷰
    @RequestMapping(value = "/list_view.do", method = { RequestMethod.GET, RequestMethod.POST })
    public String list_view(@RequestParam int mem_idx, Model model) {

        MemberVo user = (MemberVo) session.getAttribute("user");
        // int mem_idx = user.getMem_idx();

        // 회원별 장바구니 목록
        List<CartVo> cart_list = cartService.selectList(mem_idx);
        // if (cart_list == null || cart_list.isEmpty()) {
        // model.addAttribute("cart_list", new ArrayList<CartVo>());
        // }

        if (cart_list.size() == 0)
            model.addAttribute("null", "null");

        Integer total_amount = cartService.selectTotalAmount(mem_idx);
        int shop_idx = cart_list.get(0).getShop_idx();
        // int shop_dfee = shopService.selectShopDfee(shop_idx);
        System.out.println("shop_idx:" + shop_idx);

        session.getAttribute("shop_dfee");
        model.addAttribute("cart_list", cart_list);
        model.addAttribute("shop_idx", shop_idx);
        model.addAttribute("total_amount", total_amount);
        model.addAttribute("user", user);
        // model.addAttribute("dfee", shop_dfee);

        return "main/detail_cart";
    }

    // 장바구니 비우기
    @PostMapping("/delete_all.do")
    @ResponseBody
    public int deleteAll(@RequestParam int mem_idx) {

        return cartService.deleteAll(mem_idx);
    }

    // 장바구니 메뉴 삭제
    @PostMapping("/delete.do")
    @ResponseBody
    public Map<String, Object> delete_one(@RequestParam int cart_idx) {

        CartVo vo = cartService.selectOne(cart_idx);
        cartService.menuDelete(cart_idx);
        Integer total_amount = cartService.selectTotalAmount(vo.getMem_idx());
        int shop_dfee = shopService.selectShopDfee(vo.getShop_idx());

        List<CartVo> list = cartService.selectList(vo.getMem_idx());

        Map<String, Object> map = new HashMap<>();

        if (list.size() == 0)
            map.put("null", "null");

        map.put("total_amount", total_amount);
        map.put("total", total_amount + shop_dfee);
        map.put("shop_dfee", shop_dfee);
        // map.put("is_empty", list == null || list.isEmpty());

        return map;
    }

    // cart_cnt 감소
    @PostMapping("/cnt_minus.do")
    @ResponseBody
    public Map<String, Object> cnt_minus(@RequestParam int cart_idx, @RequestParam int cart_cnt) {

        cartService.cntMinus(cart_idx, cart_cnt);
        CartVo vo = cartService.selectOne(cart_idx);
        Integer total_amount = cartService.selectTotalAmount(vo.getMem_idx());
        int shop_dfee = shopService.selectShopDfee(vo.getShop_idx());

        Map<String, Object> map = new HashMap<>();
        map.put("cart_cnt", vo.getCart_cnt());
        map.put("amount", vo.getAmount());
        map.put("total_amount", total_amount);
        map.put("total", shop_dfee + total_amount);
        map.put("shop_dfee", shop_dfee);

        return map;
    }

    // cart_cnt 증가
    @PostMapping("/cnt_plus.do")
    @ResponseBody
    public Map<String, Object> cnt_plus(@RequestParam int cart_idx, @RequestParam int cart_cnt) {

        cartService.cntPlus(cart_idx, cart_cnt);
        CartVo vo = cartService.selectOne(cart_idx);
        Integer total_amount = cartService.selectTotalAmount(vo.getMem_idx());
        int shop_dfee = shopService.selectShopDfee(vo.getShop_idx());

        Map<String, Object> map = new HashMap<>();
        map.put("cart_cnt", vo.getCart_cnt());
        map.put("amount", vo.getAmount());
        map.put("total_amount", total_amount);
        map.put("total", shop_dfee + total_amount);
        map.put("shop_dfee", shop_dfee);

        return map;
    }

    // shop_idx 조회해서 다른 가게인지 비교하기
    @GetMapping("/check_shop_idx.do")
    @ResponseBody
    public Map<String, Object> check_shop_idx(int mem_idx, int shop_idx) {
        Map<String, Object> map = new HashMap<String, Object>();

        // 현재 유저의 장바구니 전체 조회 (shop_idx 비교용)
        List<CartVo> cartList = cartService.selectList(mem_idx);

        // CartVo cartOne = cartService.selectOneMem(vo.getMem_idx());

        // 2.사용유무 판단
        boolean bResult = false;

        if (!cartList.isEmpty()) {
            // int currentShop = cartOne.getShop_idx();
            int currentShop = cartList.get(0).getShop_idx();
            int newShopIdx = shop_idx;
            if (currentShop == newShopIdx) {
                bResult = true;
            }
        }

        int shop_dfee = shopService.selectShopDfee(shop_idx);
        map.put("result", bResult);
        map.put("dfee", shop_dfee);
        return map;
    }

}
