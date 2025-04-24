package com.githrd.project.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.githrd.project.dao.OrderStatusMapper;
import com.githrd.project.vo.OrderStatusVo;

@Service
public class OrderSatausSerivce {

    @Autowired
    private OrderStatusMapper orderStatusMapper;

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    // public List<OrderStatusVo> getAcceptOrderList(int owner_idx, String order_status) {
    //     Map<String, Object> params = new HashMap<>();
    //     params.put("owner_idx", owner_idx);
    //     params.put("order_status", order_status);

    //     return orderStatusMapper.getAcceptOrderList(params);
    // }

    @Transactional
    public void updateOrderStatus(int order_idx, String order_status) {

        orderStatusMapper.updateOrderStatus(order_idx, order_status);

        Map<String, Object> message = new HashMap<>();
        message.put("orderStatus", "주문 정보가 업데이트되었습니다.");
        message.put("order_idx", order_idx);

        messagingTemplate.convertAndSend("/topic/orders", message);
    }

    public void deleteOrder(int order_idx) {
        orderStatusMapper.deleteOrder(order_idx);
    }

    // public List<OrderStatusVo> getCompleteOrderList(int owner_idx, String order_status) {
    //     Map<String, Object> params = new HashMap<>();
    //     params.put("owner_idx", owner_idx);
    //     params.put("order_status", order_status);

    //     return orderStatusMapper.getCompleteOrderList(params);
    // }


    
}
