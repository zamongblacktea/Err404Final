package com.githrd.project.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class KakaoMapService {

    @Value("${kakao.api.key}")
    private String apiKey;

    //주소로 위도경도를 얻어옴 배열첫번째 0 위도 1 배열두번째 경도
    public double[] getCoordinates(String address) throws Exception {
        String url = "https://dapi.kakao.com/v2/local/search/address.json?query=" + address;
        //json을 하는 Resttemplate
        //요즘은 웹클라이언트 사용

      
         //Kakao 주소 검색 API 호출 URL.
        RestTemplate restTemplate = new RestTemplate();
       
        //HTTP요청을 보낸 객체 생성
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "KakaoAK " + apiKey);

         //Kakao API KEY를 Authorization헤더에 설정
        HttpEntity<String> entity = new HttpEntity<>(headers);
        
        //헤더를 HTTP 요청에 포함시키는 래퍼 객체 생성.
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);


        //API호출을 보내고 JSON 응답을 받아옴
        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(response.getBody());

        //응답본문 JSON을 객체로 변환
        JsonNode documents = root.path("documents");

        //"documents" 노드를 추출.
        if (documents.isArray() && documents.size() > 0) {
            JsonNode location = documents.get(0).path("road_address"); // 도로명 주소 우선 사용
            if (location.isMissingNode()) {
                location = documents.get(0).path("address"); // 지번 주소 사용
            }
            //결과가 있다면 도로명 주소 또는 지번 주소 중 사용 가능한 것을 선택.
            double latitude = location.path("y").asDouble();
            double longitude = location.path("x").asDouble();
            return new double[] { latitude, longitude };
            //배열첫번째 위도 배열두번째 경도
        }
        //위도와 경도를 double 배열로 반환.
        throw new RuntimeException("입력한 주소를 찾을 수 없습니다. 정확한 주소를 입력해주세요.");
    }
    //위도경도로 주소를 얻어옴 배열첫번째 위도 배열두번째 경도 
    //라이더위치에따라 주소구하기

    //3지점 구해야하니까 호출2번해야함
    // 좌표 간 거리 계산 (Haversine Formula)
    public double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        double earthRadius = 6371e3; // 지구 반지름 (미터)
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2)
                + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                * Math.sin(dLon / 2) * Math.sin(dLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

        double result = earthRadius * c;
     
       // 소수점 셋째 자리에서 절사 (버림)
        result = Math.floor(result * 1000) / 1000.0;
       // System.out.println(result);

        return result;
        //return earthRadius * c;  // 거리 (미터 단위)

        
    }

  


}
