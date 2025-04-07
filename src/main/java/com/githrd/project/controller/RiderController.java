package com.githrd.project.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.githrd.project.dao.MemberMapper;
import com.githrd.project.service.KakaoMapService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
@Controller
public class RiderController {
	@Autowired
	MemberMapper memberMapper;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	HttpSession session;

    @Autowired
    private KakaoMapService kakaoMapService;

    @RequestMapping("/rider/main.do")
    public String main(){

        return "rider/rider_main";
    }

    @RequestMapping("/route/route.do")
    public String showDeliveryMap(Model model) {
        try {
            // 예시 주소들 (DB나 폼 입력 등에서 받아오기)
            String shopAddress = "관악로 165 롯데리아 서울대입구역점";
            String memberAddress = "서울 관악구 관악로14나길 10 1층";
            //String riderAddress = "서울 관악구 낙성대역길 8";
            String riderAddress = "동작대로 129 1층";

            //위도경도 얻기 
            double[] storeCoords = kakaoMapService.getCoordinates(shopAddress);
            double[] customerCoords = kakaoMapService.getCoordinates(memberAddress);
            double[] riderCoords = kakaoMapService.getCoordinates(riderAddress);

            //거리계산하기(미터단위)
            double calculateDistance =  kakaoMapService.calculateDistance( storeCoords[0], storeCoords[1], customerCoords[0], customerCoords[1]);
            double calculateDistance1 =  kakaoMapService.calculateDistance( customerCoords[0], customerCoords[1],riderCoords[0], riderCoords[1]);
            double rescal = calculateDistance + calculateDistance1;
           
            
            //수수료 계산
            //1km보다 이하는 3,000원(일단 테스트용)
            //초과분부터 1001m부터 1m당 1원 
            double fee = 0;
            //Math.round(fee*1000)/1000.0;
            // if{
            //     ${rescal}> 1000 = 3000+ (${rescal} -1000);
            // }else  ${rescal}m <= 1000 
            // return ${fee}=3000;

            if(rescal>1000){
                //fee = 3000 +  (rescal-1000);
                 // 소수점 셋째 자리에서 절사 (버림)
                fee = 3000 + Math.round((rescal-1000)*1000/1000.0);
            }else fee = 3000;

            // 위도경도 requstbinding
            model.addAttribute("shop_longitude", storeCoords[1]);
            model.addAttribute("shop_latitude", storeCoords[0]);
            model.addAttribute("mem_longitude", customerCoords[1]);
            model.addAttribute("mem_latitude", customerCoords[0]);
            model.addAttribute("rider_longitude", riderCoords[1]);
            model.addAttribute("rider_latitude", riderCoords[0]);

            // 거리 및 수수료 requstbinding
            model.addAttribute("rescal", rescal);
            model.addAttribute("fee", fee);

            // 주소도 전달 (경로보기 버튼용) 가게와 배달지 경로보기 카카오맵
            model.addAttribute("shop_addr", shopAddress);
            model.addAttribute("mem_curaddr", memberAddress);

        } catch (Exception e) {
            model.addAttribute("error", "위도/경도 변환 중 오류 발생: " + e.getMessage());
        }

        return "route/distanceRoute";  // /WEB-INF/views/route/distanceRoute.jsp
    }

   


    }


