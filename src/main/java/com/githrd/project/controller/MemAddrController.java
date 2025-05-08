package com.githrd.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.githrd.project.dao.MemberAddrMapper;
import com.githrd.project.vo.MemberAddrVo;

@Controller
public class MemAddrController {

    @Autowired
    MemberAddrMapper memberAddrMapper;

    // 회원 주소록 폼 띄우기
    @GetMapping("/member/address.do")
    public String addressList(@RequestParam int mem_idx, Model model) {

        // 회원 주소록 불러오기
        List<MemberAddrVo> list = memberAddrMapper.selectList(mem_idx);

        model.addAttribute("list", list);
        return "member/member_address_list";
    }

    // 회원 주소록 등록 폼 띄우기
    @GetMapping("/member/address_insert_form.do")
    public String addressInsertForm(@RequestParam int mem_idx, Model model) {

        return "member/member_address_insert";
    }// end : address_form.do

    // 주소록 등록
    @PostMapping("/member/address_insert.do")
    @ResponseBody
    public int addressInsert(MemberAddrVo vo) {

        System.out.println(vo);

        int res = memberAddrMapper.insert(vo);

        return res;
    }

    // 회원 주소록 수정 폼 띄우기
    @GetMapping("/member/address_modify_form.do")
    public String addressModifyForm(@RequestParam int mem_idx, int mcuraddr_idx, Model model) {

        MemberAddrVo vo = memberAddrMapper.selectOne(mem_idx, mcuraddr_idx);

        model.addAttribute("vo", vo);
        return "member/member_address_modify";
    }// end : address_form.do

    // 주소록 수정
    @PostMapping("/member/address_modify.do")
    @ResponseBody
    public int addressModify(MemberAddrVo vo) {

        System.out.println(vo);

        int res = memberAddrMapper.update(vo);

        return res;
    }

}
