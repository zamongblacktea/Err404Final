package com.githrd.project.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.githrd.project.dao.DeliveryMapper;
import com.githrd.project.dao.MemReviewMapper;
import com.githrd.project.dao.MemberMapper;
import com.githrd.project.dao.OrderStatusMapper;
import com.githrd.project.dao.ShopInfoMapper;
import com.githrd.project.service.ShopService;
import com.githrd.project.vo.DeliveryVo;
import com.githrd.project.vo.MemReviewVo;
import com.githrd.project.vo.ShopInfoVo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReviewController {

	@Autowired
	MemReviewMapper memReviewMapper;

	@Autowired
	MemberMapper memberMapper;

	@Autowired
	OrderStatusMapper orderStatusMapper;

	@Autowired
	DeliveryMapper deliveryMapper;

	@Autowired
	ShopInfoMapper shopInfoMapper;

	@Autowired
	ShopService shopService;

	@Autowired
	HttpSession session;

	@Autowired
	ServletContext application;

	@Autowired
	HttpServletRequest request;

	// 회원 내 주문 내역 리스트 폼 띄우기
	@RequestMapping("/member/order_list.do")
	public String orderList(@RequestParam int mem_idx, Model model) {

		// 주문내역 전체 리뷰 selectList
		List<DeliveryVo> list = deliveryMapper.selectListReview(mem_idx);



		model.addAttribute("list", list);

		return "/member/member_order_list";
	}// end: member_order_list


	// 회원 내 주문 페이지
	@RequestMapping("/member/my_order.do")
	public String myOrderList(@RequestParam int mem_idx, Model model) {

		// 주문내역 전체 리뷰 selectList
		List<DeliveryVo> list = deliveryMapper.selectListReview(mem_idx);



		model.addAttribute("list", list);

		return "/member/member_my_order";
	}// end: my_order

	// 회원 리뷰 작성 폼 띄우기
	@RequestMapping("/member/review_form.do")
	public String reviewForm(@RequestParam int mem_idx, int order_idx, int shop_idx, Model model) {

		// 회원 idx로 정보 가져오기
		MemReviewVo member = memReviewMapper.selectOneFromIdx(mem_idx);

		// 해당 가게 리뷰할 메뉴 정보 가져오기
		MemReviewVo order = memReviewMapper.selectMenu(mem_idx, order_idx);
		// 가게 이름 가져오기
		ShopInfoVo shop = shopInfoMapper.selectShopOne(shop_idx);

		model.addAttribute("member", member);
		model.addAttribute("order", order);
		model.addAttribute("shop", shop);
		return "/member/member_review_form";
	}// end: member_review_form





	// 회원 리뷰 작성
	@ResponseBody
	@PostMapping("/member/insert_review.do")
	public int insert_review(MemReviewVo vo,
			@RequestParam(name = "photo") MultipartFile[] photo_array)
			throws IllegalStateException, IOException {
		
		// \n -> <br>
		String review_content = vo.getReview_content().replaceAll("\n", "<br>");
		vo.setReview_content(review_content);


		// 리뷰 사진 등록
		int res = 0;


		// 파일 처리
		// 웹경로 -> 절대경로 구하기
		// import ServletContext 후 Autowired application 설정
		String saveDir = application.getRealPath("/images/");
		String review_img = "no_file";

		for (int i = 0; i < photo_array.length; i++) {
			MultipartFile photo = photo_array[i];
			if (!photo.isEmpty()) {
				// 업로드된 파일명 구하기
				String filename = photo.getOriginalFilename();
				File f = new File(saveDir, filename);

				// 중복파일 체크
				if (f.exists()) {
					long tm = System.currentTimeMillis();
					filename = String.format("%d_%s", tm, filename);
					f = new File(saveDir, filename);
				}

				// 임시 공간에 저장된 파일 -> 내가 지정한 파일로 복사
				photo.transferTo(f);

				if (i == 0) {
					review_img = filename;
					vo.setReview_img(review_img);

				}
			}
		} // end : for

		// 1.회원가입자의 IP구하기
		String review_ip = request.getRemoteAddr();
		vo.setReview_ip(review_ip);

		try {
			res = memReviewMapper.insert(vo);
			res = shopService.rateUpdate(vo.getShop_idx());
			System.out.println(res);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}


		


		return res;
	}// end: member_insert_review




	// 회원 내가 쓴 리뷰 리스트 폼 띄우기
	@RequestMapping("/member/my_review.do")
	public String myReview(@RequestParam int mem_idx, Model model) {


		List<MemReviewVo> list = memReviewMapper.selectMemberReviewReply(mem_idx);

		model.addAttribute("list", list);
		return "/member/member_my_review";
	}// end: member_review


	//////////////////////////////////////////////////////// 가게//////////////////////////////////////////////////////////////


	// 가게 상세 페이지 리뷰 목록
	@GetMapping("/main/detail_review.do")
	public String detail_review(@RequestParam int shop_idx, Model model) {

        //회원 + 사장 리뷰 리스트
        List<MemReviewVo> list = memReviewMapper.selectReviewReply(shop_idx);





		ShopInfoVo shop = shopInfoMapper.selectShopOne(shop_idx);

		model.addAttribute("list", list);
		model.addAttribute("shop", shop);
		return "/main/detail_review";
	}//end: detail_review

	

}
