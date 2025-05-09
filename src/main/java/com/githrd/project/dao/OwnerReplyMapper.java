package com.githrd.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.OwnerReplyVo;



@Mapper
public interface OwnerReplyMapper {
    
	
    public List<OwnerReplyVo> selectList();
		

	//추가
	public int insert(OwnerReplyVo vo);




}
