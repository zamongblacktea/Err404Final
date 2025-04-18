package com.githrd.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.MemReviewVo;

@Mapper
public interface MemReviewMapper {


    
    public List<MemReviewVo> selectListOne(int mem_idx);

    public int insert(MemReviewVo vo);


    
}
