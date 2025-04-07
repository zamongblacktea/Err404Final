package com.githrd.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.RiderVo;



@Mapper
public interface RiderMapper {
    
	
    public List<RiderVo> selectList();
		
	// rider_idx이용해서 1건 데이터 읽어오기
	public RiderVo selectOneFromIdx(int rider_idx);
		
	// rider_id를 이용해서 1건 데이터 얻어오기
	public RiderVo selectOneFromId(String rider_id);

	//추가
	public int insert(RiderVo vo);

	public int update(RiderVo vo);

	public int delete(int rider_idx);

}
