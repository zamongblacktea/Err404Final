package com.githrd.project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.githrd.project.vo.MemReviewVo;

@Mapper
public interface MemReviewMapper {


    
    public List<MemReviewVo> selectListOne(int mem_idx);

    // mem_idx이용해서 1건 데이터 읽어오기
	public MemReviewVo selectOneFromIdx(int mem_idx);

	public MemReviewVo selectMenu(int mem_idx, int order_idx);

    public int insert(MemReviewVo vo);

    public List<MemReviewVo> selectListShop(int shop_idx);

    // 별점 조회
    public List<MemReviewVo> selectShopRating(int shop_idx);

    public int updateReply(int review_idx);

    public List<MemReviewVo> selectReviewReply(int shop_idx);

    // 해당 가게 리뷰 카운트
    public int selectCountReview(int shop_idx);


    
}
