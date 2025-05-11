package com.githrd.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.PaymentVo;



@Mapper
public interface PaymentMapper {

    PaymentVo selectList(int mem_idx);

    int insert(PaymentVo vo);

    int selectOrderNo();

    List<PaymentVo> selectListOrderNum(String merchant_uid);



}
