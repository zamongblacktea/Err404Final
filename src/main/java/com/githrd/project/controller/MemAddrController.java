package com.githrd.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.githrd.project.dao.MemberAddrMapper;
import com.githrd.project.vo.MemberAddrVo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
public class MemAddrController {


    @Autowired
    MemberAddrMapper memberAddrMapper;

    //회원 주소록 폼 띄우기
    @ResponseBody
    @RequestMapping("member/address.do")
    public List<MemberAddrVo> addressList(@RequestParam ("mem_idx") int mem_idx) {
        
        
        
        return memberAddrMapper.selectList(mem_idx);
    }
    










    // @GetMapping("/member/address.do")
    // public String addressList(@RequestParam int mem_idx,Model model) {
        
    //     //회원 주소록 불러오기
    //     List <MemberAddrVo> list = memberAddrMapper.selectList(mem_idx);
        

    //     model.addAttribute("list", list);
    //     return "member/member_address_list";
    // }
    


}
