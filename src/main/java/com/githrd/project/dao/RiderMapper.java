package com.githrd.project.dao;

import java.io.IOException;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.githrd.project.vo.RiderVo;



@Mapper
public interface RiderMapper {
    
	// 라이더 주소얻기
	String getRiderAddr(int rider_idx);
	
    public List<RiderVo> selectList();
		
	// rider_idx이용해서 1건 데이터 읽어오기
	public RiderVo selectOneFromIdx(int rider_idx);
		
	// rider_id를 이용해서 1건 데이터 얻어오기
	public RiderVo selectOneFromId(String rider_id);

	//rider_email api 인증 가입
	public int selectOneFromEmail(String email);

	//rider_email 인증 아이디 찾기/비밀번호 변경
	public RiderVo selectOneFindInfo(String email);

	//추가
	public int insert(RiderVo vo) throws IllegalStateException, IOException;

	public int update(RiderVo vo);

	public int pwdUpdate(RiderVo vo);

	public int delete(int rider_idx);

    public int updateApproval(int rider_idx);

}
