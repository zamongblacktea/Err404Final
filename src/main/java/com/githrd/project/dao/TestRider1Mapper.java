package com.githrd.project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.TestRider1Vo;

@Mapper
public interface TestRider1Mapper {
    
       // 임시테이블 조회
       public List<TestRider1Vo> selectList();

       //배차받기를 누르면 배차상태가 Y로 바뀌도록하기
        int riderStatusUpdate(Map<String,Object> map);

        //배차받기를 누른 라이더에게 라이더 idx가 일치하면 배달현황에 뜨드록하기
        public List<TestRider1Vo> selectRiderList(int rider_idx);

        //배달완료를 누르면 배달상태가 y로 바뀌도록하기 
        int deliveryStatusUpdate(Map<String,Object> map);

        //배달완료한 라이더에게 라디어 idx가 일치하면 배달완료한목록에 뜨도록하기
        public List<TestRider1Vo> selectDeliveryList(int rider_idx);


    
}
