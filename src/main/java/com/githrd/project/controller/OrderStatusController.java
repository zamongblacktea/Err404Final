package com.githrd.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.githrd.project.dao.DeliveryMapper;
import com.githrd.project.dao.OrderStatusMapper;
import com.githrd.project.service.CartService;
import com.githrd.project.service.OrderSatausSerivce;
import com.githrd.project.service.ShopService;
import com.githrd.project.vo.CartVo;
import com.githrd.project.vo.OrderStatusVo;
import com.githrd.project.vo.OwnerVo;
import com.githrd.project.vo.ShopInfoVo;

import jakarta.servlet.http.HttpSession;


@RequestMapping("/order")
@Controller
public class OrderStatusController {


    @Autowired
    ShopService shopService;

    @Autowired
    CartService cartService;

    @Autowired
    OrderStatusMapper orderStatusMapper;

    @Autowired
    DeliveryMapper deliveryMapper;

    @Autowired
	SimpMessagingTemplate messagingTemplate;

    @Autowired
    HttpSession session;

    @Autowired
	OrderSatausSerivce orderSatausSerivce; 


    //주문현황 페이지 폼 열기
    @GetMapping("/order_list.do")
    public String order_list(Model model,int shop_idx) {
        OwnerVo owner = (OwnerVo) session.getAttribute("user");
        int owner_idx = owner.getOwner_idx();
        ShopInfoVo shop = shopService.selectByOwnerIdx(owner_idx);

        List<OrderStatusVo> list = orderStatusMapper.selectList(shop_idx);
 
        if (shop == null) {
            return "redirect:../shop/insert_form.do?owner_idx=" + owner_idx;
        }

        session.setAttribute("shop_idx", shop.getShop_idx());
        model.addAttribute("shop", shop);
        model.addAttribute("status", list);
        return "order/shop_order_list";
    }

    //주문완료 페이지 폼 열기
    @GetMapping("/order_list_complete.do")
    public String order_list_complete(Model model,int shop_idx) {
        OwnerVo owner = (OwnerVo) session.getAttribute("user");
        int owner_idx = owner.getOwner_idx();
        ShopInfoVo shop = shopService.selectByOwnerIdx(owner_idx);

        List<OrderStatusVo> list = orderStatusMapper.selectListComp(shop_idx);
 
        if (shop == null) {
            return "redirect:../shop/insert_form.do?owner_idx=" + owner_idx;
        }

        session.setAttribute("shop_idx", shop.getShop_idx());
        model.addAttribute("shop", shop);
        model.addAttribute("status", list);
        return "order/shop_order_list_complete";
    }


    //주문현황 상태 ajax 업데이트
    @PostMapping("/update_status.do")
    @ResponseBody
    public Map<String , String> updateStatus(@RequestBody OrderStatusVo vo){

        System.out.println("--------------------------------------------------------");
        System.out.println(vo);
        System.out.println("--------------------------------------------------------");

        Map<String,Object>map = new HashMap<>();
        map.put("order_idx", vo.getOrder_idx());
        map.put("order_status",vo.getOrder_status());

        int res = orderStatusMapper.updateStatus(map);

        deliveryMapper.orderStatusUpdate(map);

        Map<String, Object> message = new HashMap<>();

        System.out.println(vo.getOrder_status());

        message.put("tab_state", "standby");
        message.put("order_status", vo.getOrder_status());
        messagingTemplate.convertAndSend("/topic/orders", message);

       

        return Map.of("updateStatus",vo.getOrder_status());
    }//end: update_status

    // 주문 접수
	@GetMapping("accept")
	public String acceptOrderList(@RequestParam("order_idx") int order_idx) {
		
		// 주문 상태를 '배차 대기'로 변경

        Map<String,Object>map = new HashMap<>();
        map.put("order_idx", order_idx);
        map.put("order_status","배차대기");
		orderStatusMapper.updateOrderStatus(map);

		// 서버 측: 주문이 들어왔을 때 전송할 메시지
        Map<String, Object> message = new HashMap<>();
        message.put("order_status", "주문 정보가 업데이트되었습니다."); // 주문 상태
        message.put("order_idx", order_idx); // 주문 IDX
        message.put("tab_state", "standby");

        messagingTemplate.convertAndSend("/topic/orders", message);

		return "redirect:/order/shop_order_list.do";
	}

	// 픽업대기 (조리완료시)
	@GetMapping("endCooking")
	public String endCooking(@RequestParam("order_idx") int order_idx) {

		// 주문 상태를 '픽업 대기'로 변경
        // OrderStatusVo vo = new OrderStatusVo();
        // vo.setOrder_idx(order_idx);
        // vo.setOrder_status("픽업대기");
		
        Map<String,Object> map = new HashMap<>();
        map.put("order_idx", order_idx);
        map.put("order_status", "픽업대기");

        orderStatusMapper.updateStatus(map);

        deliveryMapper.orderStatusUpdate(map);


        // 서버 측: 주문이 들어왔을 때 전송할 메시지
        Map<String, Object> message = new HashMap<>();
        message.put("order_status", "픽업대기"); // 주문 상태
        message.put("order_idx", order_idx); // 주문 ID

        messagingTemplate.convertAndSend("/topic/orders", message);	

		return "redirect:/order/shop_order_list.do";
	}



}
