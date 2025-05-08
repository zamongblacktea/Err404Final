package com.githrd.project.controller;

import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.githrd.project.dao.MemberAddrMapper;
import com.githrd.project.dao.MemberMapper;
import com.githrd.project.dao.PaymentMapper;
import com.githrd.project.service.CartService;
import com.githrd.project.service.PaymentService;
import com.githrd.project.vo.CartVo;
import com.githrd.project.vo.MemberAddrVo;
import com.githrd.project.vo.MemberVo;
import com.githrd.project.vo.PaymentVo;

import jakarta.servlet.http.HttpSession;

@RequestMapping("/order/")
@Controller
public class PaymentController {

    @Autowired
    PaymentMapper paymentMapper;

    @Autowired
    PaymentService paymentService;

    @Autowired
    MemberAddrMapper memberAddrMapper;

    @Autowired
    MemberMapper memberMapper;

    @Autowired
    CartService cartService;

    @Autowired
    HttpSession session;

    // 결제 페이지 폼 불러오기
    @PostMapping("payment_form.do")
    public String paymentForm(int mem_idx, Model model, int amount, int shop_idx) {


		// 1. 로그인한 유저 정보 꺼내오기
		MemberVo user = (MemberVo) session.getAttribute("user");

		if (user == null) {
			return "redirect:/member/login_form.do"; // 로그인 안 했으면 로그인 폼으로
		}

        // 회원 정보 가져오기
        MemberVo vo = memberMapper.selectOneFromIdx(mem_idx);

        List<CartVo> cart_list = cartService.selectList(mem_idx);

        shop_idx = cart_list.get(0).getShop_idx();

        //회원 주소록
        MemberAddrVo addr = memberAddrMapper.selectAddr(mem_idx);

        // 결제 할 총 가격 조회
        // Integer total_amount = cartService.selectTotalAmount(mem_idx);
        model.addAttribute("cart_list", cart_list);
        model.addAttribute("shop_idx", shop_idx);
        model.addAttribute("vo", vo);
        model.addAttribute("addr", addr);
        model.addAttribute("amount", amount);

        System.out.println(cart_list);
        System.out.println(cart_list.size());

        return "order/shop_payment";
    }
    
    //컨트롤러 뷰에서 받아온정보를 서비스한테 보내주는 역할 (서블렛 집합체 느낌)
    //서비스받아서 백엔드 작업들 
    //dao 호출해서 db 사용 
    //mybatis mapper sql명령어 vo를 통해서(crud) 담고 보내고 db 가져올수있게 해주는거
    // 결제 api 요청 REST API
    

    @ResponseBody
    @PostMapping("/verify.do")
    public ResponseEntity<String> verify(@RequestBody PaymentVo vo) {
        try {
            JSONObject result = paymentService.verifyPayment(vo);
            return ResponseEntity.ok(result.toString());
        } catch (Exception e) {
            e.getStackTrace();

            return ResponseEntity.badRequest()
                    .body(new JSONObject().put("success", false).put("message", "결제 검증 실패: " + e.getMessage())
                            .toString());
        }
    }

}
