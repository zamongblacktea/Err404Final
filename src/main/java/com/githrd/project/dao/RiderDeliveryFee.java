package com.githrd.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.RiderDeliveryFeeVo;

@Mapper
public interface RiderDeliveryFee {
 
     // rider_idx를 이용해서 배달 테이블 조회
     public List<RiderDeliveryFeeVo> selectList(int rider_idx);

    // void insertRiderDeliveryFee(Map<String, Object> params);

    // Double selectTotalRiderDeliveryFee(int rider_idx);

    // boolean RiderDeliveryFeeExists(int rider_idx, int delivery_idx);

    // int RiderDeliveryFeeExists(Map<String, Object> params);

    // List<RiderDeliveryFeeVo> selectPageList(int rider_idx, int offset, int blockList);

    // int getTotalFeeCount(int rider_idx);

    // List<RiderDeliveryFeeVo> selectPageList(Map<String, Object> params);

    // int getTotalCountFeeByDate(int rider_idx, String startDate, String endDate);

    // List<RiderDeliveryFeeVo> selectPageListByDate(Map<String, Object> params);

    // double selectTotalFeeByDate(int rider_id, String startDate, String endDate);
}
