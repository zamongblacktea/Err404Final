package com.githrd.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.MemberVo;



@Mapper
public interface MemberMapper {
    

    public List<MemberVo> selectList();
		
	// mem_idx이용해서 1건 데이터 읽어오기
	public MemberVo selectOneFromIdx(int mem_idx);

	//sns 연동로그인 조회
	public MemberVo selectSns(String mem_id);
		
	// mem_id를 이용해서 1건 데이터 얻어오기
	public MemberVo selectOneFromId(String mem_id);

	//추가
	public int insert(MemberVo vo);

	public int update(MemberVo vo);

	public int delete(int mem_idx);

}
