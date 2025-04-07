package com.githrd.project.service;

import java.util.List;

import com.githrd.project.vo.ShopInfoVo;

public interface ShopService {
    
        // 가게 전체 리스트 출력
        List<ShopInfoVo> selectListAll();
}
