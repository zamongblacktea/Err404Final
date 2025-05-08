
package com.githrd.project.interceptor;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.githrd.project.vo.MemberVo;
import com.githrd.project.vo.OwnerVo;
import com.githrd.project.vo.RiderVo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginInterceptor implements HandlerInterceptor {

    // /cart/** or /pqyment/** or /product/insert.do

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
      
        log.info("===============================================");
        log.info("==================== BEGIN ====================");
        // log.info("Request URI ===> " + request.getRequestURI());
        // log.info("Request URL ===> " + request.getRequestURL().toString());

        String uri  = request.getRequestURI();
        String host = request.getRequestURL().toString().replace(uri, "/");

        log.info("Request URI ===> " + uri);
        log.info("Request URL ===> " + host);


        //로그인 체크 
        HttpSession session =  request.getSession();

        //형변환
        // MemberVo user = (MemberVo) session.getAttribute("user");
        // RiderVo rider = (RiderVo) session.getAttribute("user");
        // OwnerVo owner = (OwnerVo) session.getAttribute("user");

        if(session.getAttribute("user")==null){

            // response.sendRedirect("../member/login_form.do?reason=session_timeout");
            response.sendRedirect(host + "member/login_form.do");

            return false;
        } 

        return HandlerInterceptor.super.preHandle(request, response, handler);
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        //log.info("==================== END ======================");
        //log.info("===============================================");
        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }

}
