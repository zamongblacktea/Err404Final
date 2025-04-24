package com.githrd.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.githrd.project.dao.MemReviewMapper;
import com.githrd.project.vo.MemReviewVo;


@RequestMapping("/main/")
@Controller
public class ReviewController {


    @Autowired
    MemReviewMapper memReviewMapper;


    //가게 리뷰 페이지 열기
    @GetMapping("detail_review.do")
    public String review_detail(@RequestParam int shop_idx, Model model) {

        List<MemReviewVo> list = memReviewMapper.selectListShop(shop_idx);


        model.addAttribute("review", list);
        return "/main/shop_detail_review";
    }
    





}
