package com.githrd.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.RiderDeliveryFeeVo;

@Mapper
public interface RiderDeliveryFeeMapper {
 
     // rider_idx를 이용해서 배달 테이블 조회
     public List<RiderDeliveryFeeVo> selectList(int riderdeliveryfee_idx);

   
}
