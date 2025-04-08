package com.githrd.project.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.githrd.project.dao.MemberMapper;
import com.githrd.project.dao.NaverMapper;
import com.githrd.project.dao.OwnerMapper;
import com.githrd.project.dao.RiderMapper;
import com.githrd.project.service.KakaoServiceImpl;
import com.githrd.project.service.NaverServiceImpl;
import com.githrd.project.vo.MemberVo;
import com.githrd.project.vo.OwnerVo;
import com.githrd.project.vo.RiderVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;





@Controller
@RequiredArgsConstructor
public class AdminController {

	@Autowired
	MemberMapper memberMapper;

	@Autowired
	OwnerMapper ownerMapper;

	@Autowired
	RiderMapper riderMapper;

	@Autowired
	NaverMapper naverMapper;

	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;

	
	private final NaverServiceImpl naverService;
	private final KakaoServiceImpl kakaoService;

	//회원 리스트
	@RequestMapping("/admin/list.do")
	public String list(Model model) {

		List<MemberVo> list = memberMapper.selectList();

		// 결과적으로 request binding
		model.addAttribute("list", list);

		return "admin/member_list";
	}



	// 로그아웃
	@RequestMapping("/admin/logout.do")
	public String logout() {
	
		// 해당세션에 있는 user정보 삭제
			session.removeAttribute("user");
	
		return "redirect:../admin/list.do";
	}

	//회원 수정하기
	@RequestMapping("/admin/modify.do")
	public String modify(MemberVo vo) {

		// IP구해서 vo에 넣기
		String mem_ip = request.getRemoteAddr();
		vo.setMem_ip(mem_ip);

		// 수정
		int res = memberMapper.update(vo);

		// 현재 수정한 멤버가 로그인한 멤버냐?
		MemberVo user = (MemberVo) session.getAttribute("user");

		if (user.getMem_idx() == vo.getMem_idx()) {
			// 수정된 정보를 다시 얻어온다
			user = memberMapper.selectOneFromIdx(vo.getMem_idx());
			// 가져온 정보를 세션에 다시 넣는다
			session.setAttribute("user", user);
		}

		return "redirect:list.do";
	}

	// 회원 삭제하기
	@RequestMapping("/admin/delete.do")
	public String delete(int mem_idx) {

		int res = memberMapper.delete(mem_idx);

		return "redirect:list.do";
	}

	// 사업자 승인
	@RequestMapping("/admin/owner_approve.do")
	public String ownerApprove(Model model) {

		// 사업자
		List<OwnerVo> owner_list = ownerMapper.selectList();

		model.addAttribute("owner_list", owner_list);

		return "admin/member_owner_approve";
	}// end: owner_approve

	// 라이더 사업자 승인
	@RequestMapping("/admin/rider_approve.do")
	public String riderApprove(Model model) {

		// 라이더
		List<RiderVo> rider_list = riderMapper.selectList();

		model.addAttribute("rider_list", rider_list);
		return "admin/member_rider_approve";
	}// end: rider_approve



}//end: class AdminController
