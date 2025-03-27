package com.githrd.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.githrd.demo.dao.MemberMapper;
import com.githrd.demo.vo.MemberVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;



@Controller
@RequestMapping("/member/")
public class MemberController {

	
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	HttpSession session;
	
	
	@RequestMapping("list.do")
	public String list(Model model) {
		
		List<MemberVo> list = memberMapper.selectList();
		
		//결과적으로 request binding
		model.addAttribute("list", list);
		
		return "member/member_list";
	}
	
	//로그인 폼 띄우기
	@RequestMapping("login_form.do")
	public String login_form() {
		
		return "member/member_login_form";
	}
	
	//로그인 
	@RequestMapping("login.do")
	public String login(String mem_id,String mem_pwd,
			             @RequestParam(name="url",defaultValue = "") String url,
			             Model model) {
		
		//1.mem_id 이용해서 회원정보 검색
		MemberVo user = memberMapper.selectOneFromId(mem_id);
		
		//2.아이디가 틀린경우
		if(user==null) {
		
			//Dispatcher Servlet이 아래과 같이 처리한다
			//Model에 넣는 데이터는 redirect인 경우에는 Parameter로 이용한다
			//                      viewName인 경우에는 request binding시킨다 
			model.addAttribute("reason", "fail_id");
			model.addAttribute("url", url);
			//response.sendRedirect("login_form.do?reason=fail_id");
			return "redirect:login_form.do";
		}
		
		//3.비밀번호가 틀린경우
		if(user.getMem_pwd().equals(mem_pwd)==false) {
			
			//Dispatcher Servlet이 아래과 같이 처리한다
			//Model에 넣는 데이터는 redirect인 경우에는 Parameter로 이용한다
			//                      viewName인 경우에는 request binding시킨다 
			model.addAttribute("reason", "fail_pwd");
			model.addAttribute("mem_id", mem_id);
			model.addAttribute("url", url);
			//접속한 유저에게 비밀번호가 틀렸다는 정보를 넘기면서 다시로그인해라..
			//response.sendRedirect("login_form.do?reason=fail_pwd&mem_id=" + mem_id);
			return "redirect:login_form.do";
		}
		
		//4.로그인 처리(세션공간에 user저장)
		session.setAttribute("user", user);
		
		//6.메인화면으로 이동
		//DS가 다음명령 실행 : response.sendRedirect("../board/list.do");
		
		if(url.isEmpty())
		 	return "redirect:../product/list.do"; //메인화면 이동시켜라
		else
			return "redirect:" + url; //원래있던 페이지로 이동시켜라
	}
	
	
	
	//로그아웃
	@RequestMapping("logout.do")
	public String logout() {
		
		//해당세션에 있는 user정보 삭제
		session.removeAttribute("user");
		
		return "redirect:../product/list.do";
	}
	
	
	//회원가입폼 띄우기
	@RequestMapping("insert_form.do")
	public String insert_form() {
		
		return "member/member_insert_form";
	}
	
	//중복아이디 체크
	@RequestMapping("check_id.do")
	//@ResponseBody : 응답데이터를 DS가 직접 응답해라
	@ResponseBody  
	public Map<String, Boolean> check_id(String mem_id){
		
		//1.mem_id에 해당되는 사용자정보 얻어오기
		MemberVo vo = memberMapper.selectOneFromId(mem_id);
		
		//2.사용유무 판단
		boolean bResult  = false;

		//현재 아이디에 대한 회원이 없으면 사용가능하다 설정
		if(vo==null) bResult = true;
		
	//  {"result" : true} or {"result" : false}
		Map<String, Boolean> map = new HashMap<String, Boolean>();
		//       key      value
		//       String   Boolean
		map.put("result", bResult);
		
		//Map을 JSON으로 반환시켜주는 객체(jsonConverter:context-7-jsonconverter.xml)
		//DS이 받아서 MappingJackson2HttpMessageConverter에 지시
		//반환데이터(자바의 모든 데이터)를  JSON객체로 생성해서 반환해준다
		return map;
	}
	
	
	@RequestMapping("insert.do")
	public String insert(MemberVo vo) {
		
		//1.회원가입자의 IP구하기
		String mem_ip		=	request.getRemoteAddr();
		vo.setMem_ip(mem_ip);
		
		//2.DB insert
		int res = memberMapper.insert(vo);
				
		return "redirect:../product/list.do";
	}
	
	//  수정폼 띄우기
	// /member/modify_form.do?mem_idx=2
	@RequestMapping("modify_form.do")
	public String modify_form(int mem_idx,Model model) {
		
		//1.mem_idx에 대한 MemberVo 구한다
		MemberVo vo = memberMapper.selectOneFromIdx(mem_idx);
		
		//3.request binding
		model.addAttribute("vo", vo);
		
		return "member/member_modify_form";
	}
	
	// 수정하기
	@RequestMapping("modify.do")
	public String modify(MemberVo vo) {
		
		//IP구해서 vo에 넣기
		String mem_ip	=	request.getRemoteAddr();
		vo.setMem_ip(mem_ip);
		
		//수정
		int res = memberMapper.update(vo);
		
		//현재 수정한 멤버가 로그인한 멤버냐?
		MemberVo user       = (MemberVo) session.getAttribute("user");
		
		if(user.getMem_idx() == vo.getMem_idx()) {
			//수정된 정보를 다시 얻어온다
			user = memberMapper.selectOneFromIdx(vo.getMem_idx());
			//가져온 정보를 세션에 다시 넣는다
			session.setAttribute("user", user);
		}
		
		
		return "redirect:list.do";
	}
	
	// 삭제하기
	@RequestMapping("delete.do")
	public String delete(int mem_idx) {
		
		int res = memberMapper.delete(mem_idx);
		
		return "redirect:list.do";
	}
	
	
	
	
}

















