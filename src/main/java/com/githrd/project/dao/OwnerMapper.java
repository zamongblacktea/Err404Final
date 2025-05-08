package com.githrd.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.OwnerVo;



@Mapper
public interface OwnerMapper {
    
	
    public List<OwnerVo> selectList();
		
	// owner_idx이용해서 1건 데이터 읽어오기
	public OwnerVo selectOneFromIdx(int owner_idx);
		
	// owner_id를 이용해서 1건 데이터 얻어오기
	public OwnerVo selectOneFromId(String owner_id);

	//사업자 회원 승인 update
	public int updateApproval(int owner_idx);

	//추가
	public int insert(OwnerVo vo);

	//수정
	public int update(OwnerVo vo);

	public int delete(int owner_idx);

	//사장님 이메일 인증 api
	public int selectOneFromEmail(String email);

	//아이디 비밀번호 찾기
	public OwnerVo selectOneFindInfo(String email);

}
