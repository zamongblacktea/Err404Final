package com.githrd.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.githrd.project.dao.MemberMapper;
import com.githrd.project.dao.NaverMapper;
import com.githrd.project.service.KakaoServiceImpl;
import com.githrd.project.service.NaverServiceImpl;
import com.githrd.project.vo.KakaoVo;
import com.githrd.project.vo.MemberVo;
import com.githrd.project.vo.MsgEntity;
import com.githrd.project.vo.NaverVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;



//sns api 연동 로그인 callback controller
@Controller
@RequiredArgsConstructor
public class CallbackController {

    private final NaverServiceImpl naverService;

    private final KakaoServiceImpl kakaoService;

    @Autowired
    NaverMapper naverMapper;

    @Autowired
    MemberMapper memberMapper;

    // naver SNS 연동 로그인 콜백하고 유저 정보 가져오기
    @GetMapping("/naver/callback")
    public String naverCallback(@RequestParam String code,
            @RequestParam String state,
            HttpServletRequest request,
            RedirectAttributes ra,
            HttpSession session) throws Exception {

        // 연동 로그인 유저 정보 가져오기
        NaverVo naverInfo = naverService.getNaverInfo(code);

        String naver_id = naverInfo.getMem_id();
        String mem_email = naverInfo.getMem_email();
        String mem_type = naverInfo.getMem_type();
        String mem_name = naverInfo.getMem_name();

        MemberVo user = memberMapper.selectSns(naver_id);

        // user null일때 (비회원일 때)
        if (user == null) {

            // ra로 ridirect url에 정보 넣어서 보내주기
            ra.addAttribute("mem_name", mem_name);
            ra.addAttribute("mem_email", mem_email);
            ra.addAttribute("mem_type", mem_type);
            ra.addAttribute("naver_id", naver_id);
            return "redirect:../member/insert_naver.do";
        }

        if (naver_id.equals(user.getMem_id())) {// DB에 로그인 유저 정보(id)가 있을 때

            // 연동 로그인 유저 세션 부여하기
            session.setAttribute("user", user);

            // 로그인 성공 페이지로 리다이렉트
            return "redirect:../main/main.do";

        }

        return null;

    }// end : naver Callback

    //카카오 연동 로그인 api 콜백
    @GetMapping("/kakao/callback")
    public String kakaoCallback(@RequestParam String code,
            HttpServletRequest request,
            RedirectAttributes ra,
            HttpSession session) throws Exception {
        // 카카오 유저 정보 가져오기
        KakaoVo kakaoInfo = kakaoService.getKakaoInfo(code);

        // DB insert 정보
        long long_mem_id = kakaoInfo.getMem_id();
        // String 형변환 해주기
        String mem_id = String.valueOf(long_mem_id);
        String mem_nickname = kakaoInfo.getMem_nickname();
        String mem_type = "kakao";

        MemberVo user = memberMapper.selectSns(mem_id);

        // 유저 정보가 없을 때 (비회원)
        if (user == null) {

            // ra로 ridirect url에 정보 넣어서 보내주기
            ra.addAttribute("mem_nickname", mem_nickname);
            ra.addAttribute("mem_type", mem_type);
            ra.addAttribute("mem_id", mem_id);

            // 간편 회원가입 페이지로 리다이렉트
            return "redirect:../member/insert_kakao.do";
        }

        if (mem_id.equals(user.getMem_id())) {// DB에 로그인 유저 정보(id)가 있을 때

            // 연동 로그인 유저 세션 부여하기
            session.setAttribute("user", user);

            // 로그인 성공 페이지로 리다이렉트
            return "redirect:../main/main.do";

        }

        return null;
    }

}
