package com.githrd.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.githrd.project.service.KakaoServiceImpl;
import com.githrd.project.service.NaverServiceImpl;

import lombok.RequiredArgsConstructor;


@Controller
@RequiredArgsConstructor
@RequestMapping("/member")
public class SnsController {

    //private final AppleService appleService;
    private final KakaoServiceImpl kakaoService;
    private final NaverServiceImpl naverService;

    @GetMapping("/") 
    public String login(Model model) {
        // model.addAttribute("appleUrl", appleService.getAppleLogin());
        model.addAttribute("kakaoUrl", kakaoService.getKakaoLogin());
        model.addAttribute("naverUrl", naverService.getNaverLogin());
        

        return "/member/member_login_form";
    }
 
}