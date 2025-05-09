package com.githrd.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.CartVo;
import com.githrd.project.vo.OrderMenuVo;

@Mapper
public interface OrderMenuMapper {

    int insert(Map<String, Object> map);

    List<OrderMenuVo> selectListMenu(int order_idx);


}
