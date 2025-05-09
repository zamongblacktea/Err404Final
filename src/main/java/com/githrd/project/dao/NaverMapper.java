package com.githrd.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.NaverVo;



@Mapper
public interface NaverMapper {
    
	
    public List<NaverVo> selectList();
		
	// mem_idx이용해서 1건 데이터 읽어오기
	public NaverVo selectOneFromIdx(int mem_idx);
		
	// mem_id를 이용해서 1건 데이터 얻어오기
	public NaverVo selectOneFromId(String mem_id);

}
