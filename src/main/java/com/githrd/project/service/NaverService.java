package com.githrd.project.service;
import com.githrd.project.vo.NaverVo;


public interface NaverService {

       
       String getNaverLogin();

       NaverVo getNaverInfo(String code) throws Exception;

       NaverVo getUserInfoWithToken(String accessToken) throws Exception;

    


} 