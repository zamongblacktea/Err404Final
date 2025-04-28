package com.githrd.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.MemberAddrVo;



@Mapper
public interface MemberAddrMapper {
    
	
    public List<MemberAddrVo> selectList(int mem_idx);
		
	// mem_idx이용해서 1건 데이터 읽어오기
	public MemberAddrVo selectOneFromIdx(int mem_idx);

    public MemberAddrVo selectOne(int mem_idx, int mcuraddr_idx);

    public int update(MemberAddrVo vo);

    public int insert(MemberAddrVo vo);
		
	// mem주소 얻기
	String getMemberAddr(int mem_idx);

}
