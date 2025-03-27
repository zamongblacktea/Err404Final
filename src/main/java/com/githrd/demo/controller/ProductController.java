package com.githrd.demo.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.githrd.demo.dao.CategoryMapper;
import com.githrd.demo.dao.ProductMapper;
import com.githrd.demo.vo.CategoryVo;
import com.githrd.demo.vo.ProductVo;

import jakarta.servlet.ServletContext;
import org.springframework.web.bind.annotation.RequestBody;



@Controller
public class ProductController {

    @Autowired
    ProductMapper productMapper;

    @Autowired
    CategoryMapper categoryMapper;

    @Autowired
    ServletContext application;

    // 상품 전체 조회 (카테고리 번호)
    @GetMapping("/product/list.do")
    // parse int Null String 방지하기위해 cate_idx 기본값 1로 설정
    public String list(@RequestParam(name = "cate_idx", defaultValue = "1") int cate_idx, Model model) {

        // 카테고리별 목록 요청
        List<CategoryVo> cate_list = categoryMapper.selectList();

        List<ProductVo> list = productMapper.selectList(cate_idx);

        model.addAttribute("list", list);
        model.addAttribute("cate_list", cate_list);
        return "product/product_list";

    }// end: list.do

    // 상품 상세보기
    @GetMapping("/product/view.do")
    public String listOne(int prod_idx, Model model) {

        // 카테고리 목록 요청
        List<CategoryVo> cate_list = categoryMapper.selectList();

        ProductVo vo = productMapper.selectOne(prod_idx);

        model.addAttribute("vo", vo);
        model.addAttribute("cate_list", cate_list);
        return "product/product_view";

    }// end product_view

    // 상품 등록 폼 요청
    @GetMapping("/product/insert_form.do")
    public String insert_form(int cate_idx, Model model) {

        // 카테고리 목록바 출력용
        List<CategoryVo> cate_list = categoryMapper.selectList();

        model.addAttribute("cate_list", cate_list);
        return "product/product_insert_form";
    }

    // 상품 등록 및 이미지 추가
    @PostMapping("/product/insert.do")
    public String insert(int cate_idx, Model model, ProductVo vo,RedirectAttributes ra,
                        @RequestParam(name = "photo") MultipartFile [] photo_array) throws IllegalStateException, IOException {


        //\n <br> 변경해서 insert
        String prod_description = vo.getProd_description().replaceAll("\n", "<br>");
        vo.setProd_description(prod_description);

        //파일 업로드 처리
        String saveDir = application.getRealPath("/images");
        String prod_image_s = "no_images";
        String prod_image_l = "no_images";

        for(int i = 0; i < photo_array.length; i++){
            MultipartFile photo =  photo_array [i];
            if( !photo.isEmpty()){
                //업로드된 파일명 구하기
                String filename = photo.getOriginalFilename();
                File f = new File(saveDir, filename);

                //중복 파일명 체크
                if(f.exists()){
                    long tm = System.currentTimeMillis();
                    filename = String.format("%d,%s", tm,filename);
                    f = new File(saveDir, filename);
                }
                //임시 폴더에 저장된 파일 지정 경로에 업로드
                photo.transferTo(f); //반드시 예외처리 해야함

                //파일 순차적으로 집어넣기
                if(i==0){
                    prod_image_s = filename;
                }else if(i==1){
                    prod_image_l = filename;
                }

            }
        }//end: for

        //업로드 된 파일정보 집어넣기
        vo.setProd_image_s(prod_image_s);
        vo.setProd_image_l(prod_image_l);

        //DB insert
        int res = productMapper.insert(vo);

        //redirect 시 param 요청용
        ra.addAttribute("cate_idx", vo.getCate_idx());
        return "redirect:list.do";
    }//end: insert.do



    
    

}
