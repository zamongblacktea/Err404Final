package com.githrd.project.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.githrd.project.dao.ShopInfoMapper;
import com.githrd.project.dao.ShopMenuMapper;
import com.githrd.project.service.ShopService;
import com.githrd.project.vo.OwnerVo;
import com.githrd.project.vo.ShopInfoVo;
import com.githrd.project.vo.ShopMenuVo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/shop")
public class ShopController {

    @Autowired
    ShopService shopService;

    @Autowired
    ShopInfoMapper shopInfoMapper;

    @Autowired
    ShopMenuMapper shopMenuMapper;

    @Autowired
    HttpSession session;

    @Autowired
    HttpServletRequest request;

    @Autowired
    ServletContext application;

    // 가게 main
    @GetMapping("/main.do")
    public String main(Model model) {
        // 1. 로그인한 사장님 정보 꺼내오기
        OwnerVo owner = (OwnerVo) session.getAttribute("user");

        if (owner == null) {
            return "redirect:/member/login_form.do"; // 로그인 안 했으면 로그인 폼으로
        }

        int owner_idx = owner.getOwner_idx();

        // 2. 사장님이 등록한 가게 정보 가져오기
        ShopInfoVo shop = shopService.selectByOwnerIdx(owner_idx);

        // 3. shop이 null이면 → 아직 가게 등록 안 한 상태
        if (shop == null) {
            return "redirect:/shop/insert_form.do?owner_idx=" + owner_idx;
        }

        // 4. 세션에 shop_idx 저장 (필요 시)
        session.setAttribute("shop_idx", shop.getShop_idx());

        // 5. 모델에 담기
        model.addAttribute("owner_idx", owner.getOwner_idx());
        model.addAttribute("shop_idx", shop.getShop_idx());

        return "shop/shop_main";
    }

    // 가게 메뉴 조회
    @GetMapping("/menu_list.do")
    public String menu_list(@RequestParam(required = false) Integer shop_idx, Model model) {
        // shop_idx가 없는 경우 세션에서 가져오기
        if (shop_idx == null) {
            shop_idx = (Integer) session.getAttribute("shop_idx");
            if (shop_idx == null) {
                return "redirect:/shop/main.do"; // 세션에도 없으면 메인으로 리다이렉트
            }
        }

        List<ShopMenuVo> list = shopService.selectMenuAll(shop_idx);
        model.addAttribute("list", list);
        return "shop/menu_list";
    }

    // 가게 메뉴 등록 폼
    @GetMapping("/menu_insert_form.do")
    public String menu_insert_form(@RequestParam int shop_idx, Model model) {

        session.setAttribute("shop_idx", shop_idx);

        model.addAttribute("shop_idx", shop_idx);
        return "shop/menu_insert_form";
    }

    // 가게 메뉴 등록
    @PostMapping("/menu_insert.do")
    @ResponseBody
    public Map<String, Object> menu_insert(ShopMenuVo vo, @RequestParam MultipartFile photo) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 세션에서 shop_idx 가져오기
            Integer shop_idx = (Integer) session.getAttribute("shop_idx");
            if (shop_idx == null) {
                response.put("success", false);
                response.put("message", "가게 정보를 찾을 수 없습니다.");
                return response;
            }
            
            vo.setShop_idx(shop_idx);
            int result = shopService.menuInsert(vo, photo);
            
            if (result > 0) {
                response.put("success", true);
                response.put("message", "메뉴가 성공적으로 등록되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "메뉴 등록에 실패했습니다.");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "오류가 발생했습니다: " + e.getMessage());
        }
        
        return response;
    }

    // 메뉴 수정 폼
    @GetMapping("/menu_modify_form.do")
    public String menu_modify_form(@RequestParam int menu_idx, Model model) {
        // 세션에서 shop_idx 가져오기
        Integer shop_idx = (Integer) session.getAttribute("shop_idx");
        if (shop_idx == null) {
            return "redirect:/shop/main.do";
        }

        // 메뉴 정보 조회
        ShopMenuVo vo = shopService.selectMenuOne(menu_idx);
        model.addAttribute("vo", vo);
        
        return "shop/menu_modify_form";
    }

    // 메뉴 수정
    @PostMapping("/menu_modify.do")
    @ResponseBody
    //@RequestParam(required = false) MultipartFile photo 나중에 사진 수정 시 사용되면 쓰기
    public Map<String, Object> menu_modify(ShopMenuVo vo) {

        Map<String, Object> response = new HashMap<>();
        
        try {
            int result = shopService.menuModify(vo);
            
            if (result > 0) {
                response.put("success", true);
                response.put("message", "메뉴가 성공적으로 수정되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "메뉴 수정에 실패했습니다.");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "오류가 발생했습니다: " + e.getMessage());
        }
        
        return response;
    }

    // 메뉴 사진 수정
    @PostMapping("/menu_photo_upload.do")
    @ResponseBody
    public Map<String, String> menu_photo_upload(ShopMenuVo vo, @RequestParam(required = false) MultipartFile photo,
            Model model)
            throws IllegalStateException, IOException {
        int res = 0;

        // 임시로 고정
        // vo.setMenu_idx(1);

        res = shopService.menuPhotoUpload(vo, photo);

        // model.addAttribute("res", res);

        Map<String, String> map = new HashMap<>();

        if (res > 0) {
            map.put("menu_img", vo.getMenu_img()); // 성공 시, 이미지 파일명 리턴
        } else {
            map.put("error", "업로드 실패");
        }

        return map;
    }

    // 메뉴 삭제
    @PostMapping("/menu_delete.do")
    public String menu_delete(@RequestParam int menu_idx) {
        int res = 0;

        res = shopService.menuDelete(menu_idx);

        return "redirect:/shop/menu_list.do";
    }

    // 가게 등록 폼
    @GetMapping("/insert_form.do")
    public String insert_form(@RequestParam int owner_idx, Model model) {

        model.addAttribute("user", session.getAttribute("user"));

        return "shop/shop_insert_form";
    }

    // 가게 등록
    @PostMapping("/insert.do")
    public String shop_insert(ShopInfoVo vo, @RequestParam(name = "photo") MultipartFile[] photo_array,
            RedirectAttributes ra) {

        int shop_insert_no = 0;

        // 임시로 사장idx를 1로 고정
        // vo.setOwner_idx(1);

        try {
            shop_insert_no = shopService.shopInsert(vo, photo_array);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        session.setAttribute("shop_idx", shop_insert_no);

        // Redirect시 Parameter로 이용
        ra.addAttribute("shop_idx", shop_insert_no);

        System.out.println("vo 등록: " + vo);

        // model.addAttribute("shop_idx", vo.getShop_idx());

        return "redirect:menu_insert_form.do";
    }

    // 가게 정보 수정 폼
    @GetMapping("/modify_form.do")
    public String shop_modify_form(@RequestParam int shop_idx, Model model) {

        ShopInfoVo shop = shopService.selectShopOne(shop_idx);

        model.addAttribute("shop", shop);
        model.addAttribute("shop_cate_idx", shop.getShop_cate_idx());

        return "shop/shop_modify_form";
    }

    // 가게 정보 수정
    @PostMapping("/modify.do")
    public String shop_modify(ShopInfoVo vo, RedirectAttributes ra) {

        // vo.getShop_idx();
        System.out.println("넘어온 휴무일: " + vo.getShop_closeday());


        int shop_modify_no = 0;

        // 임시로 shop_idx 1로 설정
        // vo.setShop_idx(2);

        try {
            shop_modify_no = shopService.shopModify(vo);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        ra.addAttribute("shop_idx", vo.getShop_idx());

        return "redirect:order_list.do";
        // return "redirect:main.do";
    }

    // 가게 사진 수정
    @PostMapping("/photo_upload.do")
    @ResponseBody
    public Map<String, String> photo_upload(ShopInfoVo vo, @RequestParam(required = false) MultipartFile photo,
            Model model)
            throws IllegalStateException, IOException {
        int res = 0;

        // 임시로 고정
        // vo.setShop_idx(1);

        res = shopService.PhotoUpload(vo, photo); // shop_img 수정

        // model.addAttribute("res", res);

        Map<String, String> map = new HashMap<>();

        if (res > 0) {
            map.put("shop_img", vo.getShop_img()); // 성공 시, 이미지 파일명 리턴

        } else {
            map.put("error", "업로드 실패");
        }

        return map;
    }

    // 가게 로고 수정
    @PostMapping("/logo_upload.do")
    @ResponseBody
    public Map<String, String> logo_upload(ShopInfoVo vo, @RequestParam(required = false) MultipartFile photo,
            Model model)
            throws IllegalStateException, IOException {
        int res = 0;

        // 임시로 고정
        // vo.setShop_idx(1);

        System.out.println("shop_idx : " + vo.getShop_idx());
        res = shopService.LogoUpload(vo, photo); // shop_img 수정

        // model.addAttribute("res", res);

        Map<String, String> map = new HashMap<>();

        if (res > 0) {
            map.put("shop_logo", vo.getShop_logo()); // 성공 시, 이미지 파일명 리턴

        } else {
            map.put("error", "업로드 실패");
        }

        return map;
    }


    // 주문완료리스트
    @GetMapping("/order_list_complete.do")
    public String order_list_complete() {
        return "shop/shop_order_list";
    }

    // 사장 정보
    @GetMapping("/owner_info.do")
    public String owner_info() {
        return "shop/owner_info";
    }

    // 가게 정보
    @GetMapping("/shop_info.do")
    public String shop_info() {
        return "shop/shop_info";
    }

    // 리뷰 목록
    @GetMapping("/review_list.do")
    public String review_list() {
        return "shop/review_list";
    }

}
