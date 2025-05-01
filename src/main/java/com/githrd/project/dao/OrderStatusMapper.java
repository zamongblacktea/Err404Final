package com.githrd.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.DeliveryVo;
import com.githrd.project.vo.OrderStatusVo;



@Mapper
public interface OrderStatusMapper {
    
	
    public List<OrderStatusVo> selectList(int shop_idx);

    public List<OrderStatusVo> selectListComp(int shop_idx);
    
    public OrderStatusVo        selectOrderOne(int order_idx);

    //주문수락 받은것 배차대기 리스트에 뜨도록하기
    public List<OrderStatusVo> selectAcceptList();

    //라이더 배차상태 업데이트
    int riderStatusUpdate(DeliveryVo vo);

    public int insert(OrderStatusVo OrderStatus);

    public int updateStatus(OrderStatusVo vo);

    //주문정보업데이트처리
     public void updateOrderStatus(int order_idx, String order_status);

    public int deleteOrder(int order_idx);

    public OrderStatusVo selectDetail(int mem_idx);





   
		

}
