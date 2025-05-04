package com.githrd.project.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.githrd.project.dao.OrderStatusMapper;
import com.githrd.project.dao.RiderDeliveryFeeMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Service
public class CalculateService {

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    OrderStatusMapper orderStatusMapper;

    @Autowired
    RiderDeliveryFeeMapper riderDeliveryFeeMapper;

    @Autowired
    private KakaoMapService kakaoMapService;

        
    // 거리 및 수수료 계산 결과를 담을 내부 클래스
    // 거리 및 수수료를 종합적으로 계산하는 메서드
        
    public int getTotalDistance(String shopAddress, String memberAddress, String riderAddress) throws Exception{

        return (int)calculateDistance(shopAddress, memberAddress, riderAddress);
    }

    public int getFee(int distance){

        return (int)calculateFee(distance);
    }

    // public DeliveryCalcResult calculate(String shopAddress, String memberAddress, String riderAddress) {
    //     DeliveryCalcResult result = new DeliveryCalcResult();

    //     try {
    //         // 거리 계산
    //         double totalDistance = calculateDistance(shopAddress, memberAddress, riderAddress);
    //         result.totalDistance = (int)totalDistance;

    //         // 수수료 계산
    //         result.deliveryFee = (int)calculateFee(totalDistance);

    //     } catch (Exception e) {
    //         e.printStackTrace();
    //         result.totalDistance = 0;
    //         result.deliveryFee = 0;
    //     }

    //     return result;
    // }

    
        // 주소들을 바탕으로 총 거리 계산 (가게 → 회원 → 라이더) 
    public double calculateDistance(String shopAddress, String memberAddress, String riderAddress)
            throws Exception {
        // 1. 주소 -> 위도/경도 변환

        
        System.out.println(shopAddress);


        double[] shopCoords = kakaoMapService.getCoordinates(shopAddress);
        double[] memCoords = kakaoMapService.getCoordinates(memberAddress);
        double[] riderCoords = kakaoMapService.getCoordinates(riderAddress);

        System.out.println("----------------------------------------------");
        System.out.printf("[%s] lat:%f lon:%f\n",shopAddress,shopCoords[0],shopCoords[1]);
        System.out.printf("[%s] lat:%f lon:%f\n",memberAddress,memCoords[0],memCoords[1]);
        System.out.printf("[%s] lat:%f lon:%f\n",riderAddress,riderCoords[0],riderCoords[1]);
        System.out.println("----------------------------------------------");

        // 2. 거리 계산 (미터 단위)
        double dist1 = kakaoMapService.calculateDistance(shopCoords[0], shopCoords[1], memCoords[0], memCoords[1]);
        double dist2 = kakaoMapService.calculateDistance(memCoords[0], memCoords[1], riderCoords[0], riderCoords[1]);

        return dist1 + dist2;
    }

    
    //  총 거리 값을 바탕으로 수수료 계산
    //  1000m 이하: 3000원
    //  초과 시: 1m당 1원 추가
    
    public double calculateFee(double totalDistance) {
        if (totalDistance > 1000) {
            return 3000 + Math.floor(totalDistance - 1000); // 소수점 아래 절사
        } else {
            return 3000;
        }
    }


    //리뷰 업로드기준 시간 계산
    public static String getTimeAgo(Date regDate) {
    long now = System.currentTimeMillis();
    long diffMillis = now - regDate.getTime();
    long seconds = diffMillis / 1000;

    if(diffMillis < 0) return "방금 전"; 
    if (seconds < 60) return seconds + "초 전";
    long minutes = seconds / 60;
    if (minutes < 60) return minutes + "분 전";
    long hours = minutes / 60;
    if (hours < 24) return hours + "시간 전";
    long days = hours / 24;
    if (days < 7) return days + "일 전";
    
    return new SimpleDateFormat("yyyy-MM-dd").format(regDate);  // 오래된 건 날짜 출력
}


}
