package com.githrd.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.githrd.project.dao.OrderStatusMapper;
import com.githrd.project.dao.PaymentMapper;
import com.githrd.project.vo.CartVo;
import com.githrd.project.vo.PaymentVo;

import lombok.RequiredArgsConstructor;
import util.PaymentUtil;


@Service
@RequiredArgsConstructor
public class PaymentServiceImpl implements PaymentService {

    @Autowired
	SimpMessagingTemplate messagingTemplate;

    @Autowired
    PaymentMapper paymentMapper;

    @Autowired
    OrderStatusMapper orderStatusMapper;

    @Autowired
    CartService cartService;

    //트랜잭션 처리
    @Transactional(rollbackFor = Exception.class)
	@Override
    public JSONObject verifyPayment(PaymentVo vo) throws Exception {

        //imp_uid 가져오기
        String imp_uid          = vo.getImp_uid();
        String merchant_uid     = vo.getMerchant_uid();
        int shop_idx            = vo.getShop_idx();
        int menu_idx            = vo.getMenu_idx();
        int mem_idx             = vo.getMem_idx();
        String mem_phone        = vo.getMem_phone();
        String mem_name         = vo.getMem_name();
        String order_request    = vo.getOrder_request();
        String rider_request    = vo.getRider_request();
        int amount              = vo.getAmount();
        String coupon_use       = vo.getCoupon_use();
        String mem_addr1        = vo.getMem_addr1();
        String mem_addr2        = vo.getMem_addr2();
        int mcuraddr_idx        = vo.getMcuraddr_idx();
        int order_idx           = paymentMapper.selectOrderNo();


        


        // 1. 포트원 API 토큰 가져오기
        String accessToken = PaymentUtil.getAccessToken();

        // 2. 결제 정보 조회
        JSONObject payment = PaymentUtil.getPaymentData(imp_uid, accessToken);

        // 3. 결제 상태 확인
        String status = payment.getJSONObject("response").getString("status");

        if ("paid".equals(status)) { //지불 정보가 일치할 떄 (기본 입력 카카오페이로 설정)


            //결제 정보 입력
            try {
                System.out.println("insert 호출 전");


                List<CartVo> cart_list = cartService.selectList(mem_idx);

                System.out.println("cart_list : " + cart_list);



                System.out.println("insert 넣기전 vo:" + vo);
                Map<String,Object> map = new HashMap<String,Object>();
                
                map.put("cart_list", cart_list);
                map.put("mcuraddr_idx", mcuraddr_idx);
                map.put("mem_name", mem_name);
                map.put("mem_phone", mem_phone);
                map.put("imp_uid", imp_uid);
                map.put("merchant_uid", merchant_uid);
                map.put("amount", amount);
                map.put("order_request", order_request);
                map.put("rider_request", rider_request);
                map.put("mem_addr1", mem_addr1);
                map.put("mem_addr2", mem_addr2);
                map.put("order_idx", order_idx);


                
                //Payment DB insert
                int res = paymentMapper.insert(map); 
                


                System.out.println("merchant : " + merchant_uid);

                
                //해당 회원 결제내역 api merchant_uid로 조회
                List<PaymentVo> payment_list = paymentMapper.selectListOrderNum(merchant_uid);

                //주문 현황 insert (OrderStatus)
                
                System.out.println("payment_list" + payment_list);
                
                Map<String,Object> order_status = new HashMap<String,Object>();
                
                order_status.put("payment_list", payment_list);

                

                System.out.println("입력값 : " + order_status);
                //DB insert
                int res2 = orderStatusMapper.insert(order_status);


                int del = cartService.deleteAll(mem_idx);

                //웹소캣 메시지 전송
                //웹소켓으로 전송
                 Map<String,Object> paramMap = new HashMap<>();
                 paramMap.put("shop_idx", shop_idx);
                 
                messagingTemplate.convertAndSend("/topic/orders", paramMap);

                
                //OrderStatusVo orderStatus = new OrderStatusVo(shop_idx,menu_idx,mem_idx,pay_idx,mcuraddr_idx,mem_phone,order_request,rider_request,amount,pay_type,coupon_use,mem_addr1,mem_addr2);

                // for(CartVo cartVo :cart_list){
                //     OrderStatusVo orderStatus = new OrderStatusVo();
                //     orderStatus.setShop_idx(shop_idx);
                //     orderStatus.setMenu_idx(cartVo.getMenu_idx());
                //     orderStatus.setMem_idx(mem_idx);
                //     orderStatus.setMcuraddr_idx(mcuraddr_idx);
                //     orderStatus.setMem_phone(mem_phone);
                //     orderStatus.setOrder_request(order_request);
                //     orderStatus.setRider_request(rider_request);
                //     orderStatus.setAmount(cartVo.getAmount());
                //     orderStatus.setPay_type("카카오");
                //     orderStatus.setCoupon_use(coupon_use);
                //     orderStatus.setMem_addr1(mem_addr1);
                //     orderStatus.setMem_addr2(mem_addr2);

                //     //출력
                //     System.out.println("menu_idx = " + orderStatus.getMenu_idx());
        
                //     System.out.println("입력값:"+ orderStatus);
        
        
                //     
                //    }

            } catch (Exception e) {
                System.out.println("insert 중 예외 발생");
                e.printStackTrace();
            }


            return new JSONObject().put("success", true).put("message", "결제 검증 완료");
        } else {
            return new JSONObject().put("success", false).put("message", "결제 상태가 완료가 아닙니다.");
        }
    }
	
	





}
