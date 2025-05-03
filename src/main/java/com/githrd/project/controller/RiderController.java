package com.githrd.project.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.githrd.project.dao.DeliveryMapper;
import com.githrd.project.dao.MemberAddrMapper;
import com.githrd.project.dao.MemberMapper;
import com.githrd.project.dao.OrderStatusMapper;
import com.githrd.project.dao.RiderDeliveryFeeMapper;
import com.githrd.project.dao.RiderMapper;
import com.githrd.project.dao.ShopInfoMapper;
import com.githrd.project.service.CalculateSerive;
import com.githrd.project.service.KakaoMapService;
import com.githrd.project.vo.DeliveryVo;
import com.githrd.project.vo.OrderStatusVo;
import com.githrd.project.vo.OwnerVo;
import com.githrd.project.vo.RiderDeliveryFeeVo;
import com.githrd.project.vo.RiderVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
@Controller
public class RiderController {
    
    @Autowired
    CalculateSerive calculateSerive;
      
    @Autowired
    MemberAddrMapper memberAddrMapper;

	@Autowired
	MemberMapper memberMapper;

    @Autowired
    ShopInfoMapper shopInfoMapper;

    @Autowired
    RiderMapper riderMapper;

    @Autowired
    DeliveryMapper deliveryMapper;
	
	@Autowired
	HttpServletRequest request;
	
	@Autowired
	HttpSession session;

    @Autowired
    OrderStatusMapper orderStatusMapper;

    @Autowired
	SimpMessagingTemplate messagingTemplate;
    
    @Autowired
    RiderDeliveryFeeMapper riderDeliveryFeeMapper;

    @Autowired
    private KakaoMapService kakaoMapService; 


    @RequestMapping("/rider/main.do")
    public String main(){
        // 1. 로그인한 사장님 정보 꺼내오기
        RiderVo rider = (RiderVo) session.getAttribute("user");

        if (rider == null) {
            return "redirect:/member/login_form.do"; // 로그인 안 했으면 로그인 폼으로
        }

        return "rider/rider_main";
    }

    @RequestMapping("/rider/standby.do")
    public String riderStandby(Model model){

        //List<DeliveryVo> standby_list = deliveryMapper.selectList();
        List<OrderStatusVo> standby_list = orderStatusMapper.selectAcceptList();
        System.out.println(standby_list.size());

		// 결과적으로 request binding
		model.addAttribute("standby_list", standby_list);


        return "rider/rider_standby";
    }


    //parameter map으로 받기 : rider_accept.do?order_idx=1&rider_idx=5
    @Transactional(rollbackFor = Exception.class)
    @RequestMapping("/rider/rider_accept.do")
    @ResponseBody
    // public Map<String,Object> riderPrograss(@RequestParam Map<String,Object> paramMap,Model model){
    public Map<String,Object> riderPrograss(int order_idx,int rider_idx,Model model) throws Exception{
        
        int res = 0;

        //order_idx 해당되는 vo얻어오기
        OrderStatusVo orderStatusVo = orderStatusMapper.selectOrderOne(order_idx);

        //주소가져오기
        String shopAddr = shopInfoMapper.getShopAddr(orderStatusVo.getShop_idx()); 
        String memAddr = memberAddrMapper.getMemberAddr(orderStatusVo.getMem_idx());
        String riderAddr = riderMapper.getRiderAddr(rider_idx);

        // 거리와 수수료 계산
        //DeliveryCalcResult calcResult = calculateService.calculate(shopAddr, memAddr, riderAddr);
        int totalDistance = calculateSerive.getTotalDistance(shopAddr, memAddr, riderAddr);
        int deliveryFee   = calculateSerive.getFee(totalDistance);

        //ordersatus테이블 상태정보 업데이트

        //insert를 하기위한 정보 넣기
        DeliveryVo vo = new DeliveryVo();
        vo.setOrder_idx(order_idx);
        vo.setShop_idx(orderStatusVo.getShop_idx());
        vo.setMem_idx(orderStatusVo.getMem_idx());
        vo.setRider_idx(rider_idx);
        vo.setMenu_idx(orderStatusVo.getMenu_idx());
        vo.setMcuraddr_idx(orderStatusVo.getMcuraddr_idx());
        vo.setRider_request(orderStatusVo.getRider_request());
        vo.setOrder_status(orderStatusVo.getOrder_status());
        vo.setDelivery_status(orderStatusVo.getDelivery_status());
        // vo.setTotalDistance(1500);
        // vo.setDelivery_fee(3000);
        vo.setTotalDistance(totalDistance);
        vo.setDelivery_fee(deliveryFee);

        //fk 대용 무결성 검사용 select
        int count = orderStatusMapper.selectCheckOrderIdx(order_idx);

        //참조 무결성 검사
        if(count > 0){

        //delivery insert용 vo생성->insert
        res = deliveryMapper.insert(vo);
        
        //status update
        res = res * orderStatusMapper.riderStatusUpdate(vo);
        // int res = deliveryMapper.riderStatusUpdate(paramMap);
        Map<String,Object>map = new HashMap<>();
        map.put("result", res==1);
 
         //배차받기 알림을 위한 웹소캣 전송
         Map<String,Object> paramMap = new HashMap<>();
         paramMap.put("order_idx", order_idx);
         paramMap.put("shop_idx", orderStatusVo.getShop_idx());
 
         paramMap.put("rider_status","배차완료");
 
          //웹소켓으로 전송
          paramMap.put("tab_state", "rider_accept");
          messagingTemplate.convertAndSend("/topic/orders", paramMap);
    
         return map;

        }else {

            throw new IllegalArgumentException("존재하지 않는 주문번호입니다.");

        }

    }

    
    @RequestMapping("/rider/progress.do")
   // public String riderProgress(Model model,int rider_idx){
    public String riderProgress(Model model,HttpSession session){
        
        //로그인이 되면 로그인된 라이더의 idx를 세션에서 가져와야한다.
        // 로그인된 라이더 정보에서 rider_idx 가져오기
       // Integer rider_idx = (Integer) session.getAttribute("rider_idx");
        RiderVo 	user 	= (RiderVo) session.getAttribute("user");
        int rider_idx = user.getRider_idx();
        
        
        //로그인된 라이더 정보가 없을 경우 
        if (user == null) {
            return "redirect:/login_form.do";
        }

        //아래코드는 임의로 rider_idx가 1인 사람것을 가져오도록 한다.
        //List<DeliveryVo> rider_list = deliveryMapper.selectRiderList(1); ->더미데이터 테스트
        List<DeliveryVo> rider_list = deliveryMapper.selectRiderList(rider_idx);

        //rider_list는 배차완료한 라이더의 현황을 볼수 있는 리스트이다.
        // System.out.println("---------------------------");
        // System.out.println(rider_list.size());
        // System.out.println("---------------------------");
        
		// 결과적으로 request binding
		model.addAttribute("rider_list", rider_list);
        
        return "rider/rider_progress";
    }

     //parameter map으로 받기 :deliverypickup.do? order_idx=1
     @RequestMapping("/rider/deliverypickup.do")
     @ResponseBody
     public Map<String,Object> deliveryPickup(int order_idx,int shop_idx,int mem_idx,Model model){
         
        Map<String,Object> paramMap = new HashMap<>();
        paramMap.put("order_idx", order_idx);
        paramMap.put("shop_idx", shop_idx);
        paramMap.put("mem_idx", mem_idx);

         int res = deliveryMapper.deliveryPickupUpdate(paramMap);
         deliveryMapper.orderStatusUpdate(paramMap);
         paramMap.put("order_status","픽업완료");

         //order_status를 배달중으로 수정
         Map<String,Object>map = new HashMap<>();
         map.put("order_idx", order_idx);
         map.put("order_status","배달중");
         orderStatusMapper.updateOrderStatus(map);

         //웹소켓으로 전송
         paramMap.put("tab_state", "progress");
         messagingTemplate.convertAndSend("/topic/orders", paramMap);
 

         Map<String,Object> resultMap = new HashMap<>();
         resultMap.put("result", res==1);
 
         return resultMap;
     }

    
    //parameter map으로 받기 :deliverycomplete.do? order_idx=1&shop_idx=3&mem_idx=2
    @RequestMapping("/rider/deliverycomplete.do")
    @ResponseBody
    public Map<String,Object> deliveryComplete(int order_idx,int shop_idx,int mem_idx,Model model){
        
        Map<String,Object> paramMap = new HashMap<>();
        paramMap.put("order_idx", order_idx);
        paramMap.put("shop_idx", shop_idx);
        paramMap.put("mem_idx", mem_idx);

        int res = deliveryMapper.deliveryStatusUpdate(paramMap);

        //배달완료 ->약속된 내용
        paramMap.put("order_status","배달완료");
        deliveryMapper.orderStatusUpdate(paramMap);

        //order_status를 배달완료으로 수정
        Map<String,Object>map = new HashMap<>();
        map.put("order_idx", order_idx);
        map.put("order_status","배달완료");
        orderStatusMapper.updateOrderStatus(map);


        //웹소켓으로 전송
        paramMap.put("tab_state", "complete");
        messagingTemplate.convertAndSend("/topic/orders", paramMap);

        Map<String,Object> resultMap = new HashMap<>();
         resultMap.put("result", res==1);
 
         return resultMap;
    }

    @RequestMapping("/rider/complete.do")
    //public String riderComplete(int rider_idx,Model model){
    public String riderComplete(Model model,HttpSession session){
        //로그인이 되면 로그인된 라이더의 idx를 세션에서 가져와야한다.
       // 로그인된 라이더 정보에서 rider_idx 가져오기
       // Integer rider_idx = (Integer) session.getAttribute("rider_idx");
       RiderVo 	user 	= (RiderVo) session.getAttribute("user");
       int rider_idx = user.getRider_idx();
       
       //로그인된 라이더 정보가 없을 경우 
       if (user == null) {
           return "redirect:/login_form.do";
       }

        List<DeliveryVo> deliverycomplete_list = deliveryMapper.selectDeliveryCompleteList(rider_idx);

		// 결과적으로 request binding
		model.addAttribute("deliverycomplete_list", deliverycomplete_list);

        return "rider/rider_complete";
    }

    //전체 내역 정산조회
    @RequestMapping("/rider/deliveryfee.do")
    public String riderTotalDeliveryFee(int rider_idx,Model model){

        Map<String,Object> map = new HashMap<>();
        map.put("rider_idx", rider_idx);
        

        List<DeliveryVo> riderdelivery_list =deliveryMapper.selectDeliveryFeeFilterList(map);
        
         // 날짜 필터링을 걸쳐서 총배달료 조회
         int totalDeliveryFee = deliveryMapper.selectTotalDeliveryFeeFilterList(map);

        //request binding
        model.addAttribute("totalDeliveryFee", totalDeliveryFee);
        model.addAttribute("riderdelivery_list", riderdelivery_list);

        
        return "rider/rider_deliveryfee";
    }

     //날짜 필터 내역 정산조회
     @RequestMapping("/rider/deliveryfeefilter.do")
     public String riderTotalDeliveryFeeFilter(int rider_idx,String startDate,String endDate,Model model){
        
        Map<String,Object> map = new HashMap<>();
        map.put("rider_idx", rider_idx);
        map.put("startDate",startDate);
        map.put("endDate", endDate);

        List<DeliveryVo> riderdelivery_list =deliveryMapper.selectDeliveryFeeFilterList(map);
         
        // 날짜 필터링을 걸쳐서 총배달료 조회
        int totalDeliveryFee = deliveryMapper.selectTotalDeliveryFeeFilterList(map);

        //request binding
        model.addAttribute("totalDeliveryFee", totalDeliveryFee);
        model.addAttribute("riderdelivery_list", riderdelivery_list);
 
         
        return "rider/rider_deliveryfee";
     }


    //당일내역 정산
    @RequestMapping("/rider/todayfee.do")
    public String riderTodayDeliveryFee(){

        return "rider/rider_todayfee";
    }

    

    //경로 지도에 띄우기
    @RequestMapping("/route/route.do")
    public String showDeliveryMap(int order_idx, int rider_idx,Model model) {
        try {
            // 예시 주소들 (DB나 폼 입력 등에서 받아오기)
            // String shopAddress = "관악로 165 롯데리아 서울대입구역점";
            // String memberAddress = "서울 관악구 관악로14나길 10 1층";
            // String riderAddress = "서울 관악구 낙성대역길 8";
            OrderStatusVo orderStatusVo = orderStatusMapper.selectOrderOne(order_idx);
            
            String shopAddress = shopInfoMapper.getShopAddr(orderStatusVo.getShop_idx()); 
            String memAddress = memberAddrMapper.getMemberAddr(orderStatusVo.getMem_idx());
            String riderAddress = riderMapper.getRiderAddr(rider_idx);

            //위도경도 얻기 
            double[] storeCoords = kakaoMapService.getCoordinates(shopAddress);
            double[] customerCoords = kakaoMapService.getCoordinates(memAddress);
            double[] riderCoords = kakaoMapService.getCoordinates(riderAddress);

            //거리계산하기(미터단위)
            double calculateDistance =  kakaoMapService.calculateDistance( storeCoords[0], storeCoords[1], customerCoords[0], customerCoords[1]);
            double calculateDistance1 =  kakaoMapService.calculateDistance( customerCoords[0], customerCoords[1],riderCoords[0], riderCoords[1]);
            //double rescal = calculateDistance + calculateDistance1;
            double totalDistance = calculateDistance + calculateDistance1;
           
            
            //수수료 계산
            //1km보다 이하는 3,000원(일단 테스트용)
            //초과분부터 1001m부터 1m당 1원 
            double delivery_fee = 0;
            if(totalDistance>1000){
                //fee = 3000 +  (rescal-1000);
                 // 소수점 셋째 자리에서 절사 (버림)
                 delivery_fee = 3000 + Math.round((totalDistance-1000)*1000/1000.0);
            }else delivery_fee = 3000;

            // 위도경도 requstbinding
            model.addAttribute("shop_longitude", storeCoords[1]);
            model.addAttribute("shop_latitude", storeCoords[0]);
            model.addAttribute("mem_longitude", customerCoords[1]);
            model.addAttribute("mem_latitude", customerCoords[0]);
            model.addAttribute("rider_longitude", riderCoords[1]);
            model.addAttribute("rider_latitude", riderCoords[0]);

            // 거리 및 수수료 requstbinding
            model.addAttribute("totalDistance", totalDistance);
            model.addAttribute("delivery_fee", delivery_fee);

            // 주소도 전달 (경로보기 버튼용) 가게와 배달지 경로보기 카카오맵
            model.addAttribute("shop_addr", shopAddress);
            model.addAttribute("mem_curaddr", memAddress);

        } catch (Exception e) {
            model.addAttribute("error", "위도/경도 변환 중 오류 발생: " + e.getMessage());
        }

        return "route/distanceRoute";  // /WEB-INF/views/route/distanceRoute.jsp
    }

   


    }


