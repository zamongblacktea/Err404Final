package com.githrd.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.OrderStatusVo;



@Mapper
public interface OrderStatusMapper {
    
	
    public List<OrderStatusVo> selectList(int shop_idx);

    public int insert(OrderStatusVo OrderStatus);

    public int updateStatus(OrderStatusVo vo);
		

}
