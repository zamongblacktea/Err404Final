package com.githrd.project.service;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.githrd.project.dao.PaymentMapper;
import com.githrd.project.vo.PaymentVo;

import lombok.RequiredArgsConstructor;
import util.PaymentUtil;



@Service
@RequiredArgsConstructor
public class PaymentServiceImpl implements PaymentService {



    @Autowired
    PaymentMapper paymentMapper;


	@Override
    public JSONObject verifyPayment(PaymentVo vo) throws Exception {

        //insert 변수 설정
        // int mem_idx             = vo.getMem_idx();
        // int cart_idx            = vo.getCart_idx();
        // int mcuraddr_idx        = vo.getMcuraddr_idx();
        // int menu_idx            = vo.getMenu_idx();
        // int shop_idx            = vo.getShop_idx();
        // String mem_name         = vo.getMem_name();
        // String mem_phone        = vo.getMem_phone();
        // String menu_name        = vo.getMenu_name();
           String imp_uid          = vo.getImp_uid();
        // String merchernt_uid    = vo.getMerchant_uid();
        // int amount              = vo.getAmount();


        // System.out.println("imp_uid:" + imp_uid);
        // System.out.println("mem_idx:" + mem_idx);
        // System.out.println("cart_idx:" + cart_idx);

        // 1. 포트원 API 토큰 가져오기
        String accessToken = PaymentUtil.getAccessToken();

        // 2. 결제 정보 조회
        JSONObject payment = PaymentUtil.getPaymentData(imp_uid, accessToken);

        // 3. 결제 상태 확인
        String status = payment.getJSONObject("response").getString("status");
        System.out.println(">>> 결제 상태: " + status);
        if ("paid".equals(status)) { //지불 정보가 일치할 떄 (기본 입력 카카오페이로 설정)
            System.out.println(">>> paid 상태 진입");
            
            // vo.setMem_idx(mem_idx);
            // vo.setCart_idx(cart_idx);
            // vo.setMcuraddr_idx(mcuraddr_idx);
            // vo.setMenu_idx(menu_idx);
            // vo.setShop_idx(shop_idx);
            // vo.setMem_name(mem_name);
            // vo.setMem_phone(mem_phone);
            // vo.setMenu_name(menu_name);
            // vo.setImp_uid(imp_uid);
            // vo.setMerchant_uid(merchernt_uid);
            // vo.setAmount(amount);

            try {
                System.out.println(">>> insert 호출 전");
            
                int res = paymentMapper.insert(vo); // 여기서 터질 확률 매우 높음
            
                System.out.println(">>> insert 결과: " + res);
            } catch (Exception e) {
                System.out.println(">>> insert 중 예외 발생");
                e.printStackTrace();
            }

            return new JSONObject().put("success", true).put("message", "결제 검증 완료");
        } else {
            return new JSONObject().put("success", false).put("message", "결제 상태가 완료가 아닙니다.");
        }
    }
	
	





}
