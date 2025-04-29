package com.githrd.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.DeliveryVo;

@Mapper
public interface DeliveryMapper {
    
       // 배달 테이블 조회
       public List<DeliveryVo> selectList();

       //전체 정산내역 조회
       public List<DeliveryVo> selectDeliveryFeeList(int rider_idx);

       //날짜 필터링해서 정산리스트 조회
       public List<DeliveryVo> selectDeliveryFeeFilterList(Map<String, Object> map);

       //필터링한 정산내역 더해서 총배달료 조회
       public List<DeliveryVo> selectDeliveryTotalFeeFilterList(Map<String, Object> map);

       //배차받기를 누르면 배차상태가 Y로 바뀌도록하기
        // int riderStatusUpdate(Map<String,Object> map);

        //배차받기를 누른 라이더에게 라이더 idx가 일치하면 배달현황에 뜨드록하기
        public List<DeliveryVo> selectRiderList(int rider_idx);

        //픽업완료를 누르면 배달상태가 배달중으로 바뀌도록하기
        int deliveryPickupUpdate(Map<String,Object> map);

        int orderStatusUpdate(Map<String,Object> map);

        int insert(DeliveryVo vo);

        //배달완료를 누르면 배달상태가 배달완료로 바뀌도록하기 
        int deliveryStatusUpdate(Map<String,Object> map);

        //배달완료한 라이더에게 라이더 idx가 일치하면 배달완료한목록에 뜨도록하기
        public List<DeliveryVo> selectDeliveryCompleteList(int rider_idx);

        public List<DeliveryVo> selectListReview(int mem_idx);

        



    
}
