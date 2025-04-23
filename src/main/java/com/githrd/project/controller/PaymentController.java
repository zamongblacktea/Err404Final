package com.githrd.project.controller;

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
import com.githrd.project.dao.PaymentMapper;
import com.githrd.project.service.PaymentService;
import com.githrd.project.vo.MemberAddrVo;
import com.githrd.project.vo.PaymentVo;

@RequestMapping("/order/")
@Controller
public class PaymentController {

    @Autowired
    PaymentMapper paymentMapper;

    @Autowired
    PaymentService paymentService;

    @Autowired
    MemberAddrMapper memberAddrMapper;

    // 결제 페이지 폼 불러오기
    @RequestMapping("payment_form.do")
    public String paymentForm(int mem_idx, Model model) {

        // 회원 현재주소 가져오기
        MemberAddrVo vo = memberAddrMapper.selectOneFromIdx(mem_idx);

        model.addAttribute("vo", vo);

        return "order/shop_payment";
    }

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
