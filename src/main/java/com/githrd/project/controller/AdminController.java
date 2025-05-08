package com.githrd.project.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.githrd.project.dao.MemberMapper;
import com.githrd.project.dao.OwnerMapper;
import com.githrd.project.dao.RiderMapper;
import com.githrd.project.vo.MemberVo;
import com.githrd.project.vo.OwnerVo;
import com.githrd.project.vo.RiderVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RequestMapping("/admin/")
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
	HttpServletRequest request;

	@Autowired
	HttpSession session;

	// 관리자 로그인 폼 띄우기
	@RequestMapping("admin_login_form.do")
	public String admin_login_form(Model model) {

		return "admin/admin_login_form";
	}

	// 로그인
	@RequestMapping("admin_login.do")
	public String login(String mem_id, String mem_pwd,
			@RequestParam(name = "url", defaultValue = "") String url,
			HttpServletResponse response,
			Model model) throws IOException {

		// 1.mem_id 이용해서 회원정보 검색
		MemberVo user = memberMapper.selectOneFromId(mem_id);

		if (user == null) {

			// Dispatcher Servlet이 아래과 같이 처리한다
			// Model에 넣는 데이터는 redirect인 경우에는 Parameter로 이용한다
			// viewName인 경우에는 request binding시킨다
			model.addAttribute("reason", "fail_id");
			model.addAttribute("url", url);
			// response.sendRedirect("login_form.do?reason=fail_id");
			return "redirect:admin_login_form.do?reason=fail_id";
		}

		// 3.비밀번호가 틀린경우
		if (user.getMem_pwd().equals(mem_pwd) == false) {

			// Dispatcher Servlet이 아래과 같이 처리한다
			// Model에 넣는 데이터는 redirect인 경우에는 Parameter로 이용한다
			// viewName인 경우에는 request binding시킨다
			model.addAttribute("reason", "fail_pwd");
			model.addAttribute("mem_id", mem_id);
			model.addAttribute("url", url);
			// 접속한 유저에게 비밀번호가 틀렸다는 정보를 넘기면서 다시로그인해라..
			// response.sendRedirect("login_form.do?reason=fail_pwd&mem_id=" + mem_id);
			return "redirect:admin_login_form.do?reason=fail_pwd";
		}

		// 관리자 로그인
		if (user.getMem_grade().equals("관리자")) {// 관리자 등급만 로그인 시키기

			// 4.로그인 처리(세션공간에 user저장)
			session.setAttribute("user", user);

			session.setAttribute("user", user);
			return "redirect:list.do";
		} else {// 관리자 아닌사람 접근 금지시키기

			model.addAttribute("reason", "fail_admin");
			model.addAttribute("mem_id", mem_id);
			model.addAttribute("url", url);
			// 관리자 아닌 사람이 로그인 시키면 다시 리다이렉트
			// response.sendRedirect("login_form.do?reason=fail_pwd&mem_id=" + mem_id);
			return "redirect:admin_login_form.do?reason=fail_admin";

		}

	}// end: admin_login

	// 회원 리스트
	@RequestMapping("list.do")
	public String list(Model model) {

		List<MemberVo> list = memberMapper.selectList();

		// 결과적으로 request binding
		model.addAttribute("list", list);

		return "admin/admin_list";
	}

	// 로그아웃
	@RequestMapping("logout.do")
	public String logout() {

		// 해당세션에 있는 user정보 삭제
		session.removeAttribute("user");

		return "redirect:list.do";
	}

	// 회원 수정하기
	@RequestMapping("modify.do")
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
	@RequestMapping("delete.do")
	public String delete(int mem_idx) {

		int res = memberMapper.delete(mem_idx);

		return "redirect:list.do";
	}

	// 사업자 승인 페이지
	@RequestMapping("owner_approve.do")
	public String ownerApprove(Model model) {

		// 사업자
		List<OwnerVo> owner_list = ownerMapper.selectList();

		model.addAttribute("owner_list", owner_list);

		return "admin/admin_owner_approve";
	}// end: owner_approve

	// 사업자 승인 요청
	@RequestMapping("owner_approval.do")
	public String ownerApproval(int owner_idx) {

		// 승인 update
		int res = ownerMapper.updateApproval(owner_idx);

		//승인 페이지로 리다이렉트
		return "redirect:owner_approve.do";
	}// end: owner_approve

	// 라이더 사업자 승인 페이지
	@RequestMapping("rider_approve.do")
	public String riderApprove(Model model) {

		// 라이더
		List<RiderVo> rider_list = riderMapper.selectList();

		model.addAttribute("rider_list", rider_list);
		return "admin/admin_rider_approve";
	}// end: rider_approve

	// 라이더 승인 요청
	@RequestMapping("rider_approval.do")
	public String riderApproval(int rider_idx) {

		// 승인 update
		int res = riderMapper.updateApproval(rider_idx);

		//승인 페이지로 리다이렉트
		return "redirect:rider_approve.do";
	}// end: rider_approval

}// end: class AdminController
