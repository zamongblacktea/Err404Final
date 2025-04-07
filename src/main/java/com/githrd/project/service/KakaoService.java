package com.githrd.project.service;

import com.githrd.project.vo.KakaoVo;

public interface KakaoService {

       
       String getKakaoLogin();

       KakaoVo getKakaoInfo(String code) throws Exception;

       KakaoVo getUserInfoWithToken(String accessToken) throws Exception;

    


} 