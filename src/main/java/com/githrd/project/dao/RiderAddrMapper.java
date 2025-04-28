package com.githrd.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.RiderAddrVo;

@Mapper
public interface RiderAddrMapper {

    
      public List<RiderAddrVo> selectList(int rider_idx);

      public int insert(RiderAddrVo vo);
}
