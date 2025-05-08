package com.githrd.project.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.githrd.project.interceptor.LoginInterceptor;

@Configuration
public class WebMvcConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        
        registry.addInterceptor(new LoginInterceptor())
                //.addPathPatterns("/cart/**","/payment/**","/proudct/insert.do")
                .addPathPatterns("/main/detail.do",
                                            "/member/modify_form.do",
                                            "/member/modify_owner.do",
                                            "/member/modify_rider.do",
                                            "/member/order_list.do",
                                            "/member/insert_review.do",
                                            "/member/my_review.do",
                                            "/rider/main.do",
                                            "/rider/stnadby.do",
                                            "/rider/rider_accept.do",
                                            "/rider/progress.do",
                                            "/rider/deliverpickup.do",
                                            "/rider/deliverycomplete.do",
                                            "/rider/complete.do",
                                            "/rider/delvieryfee.do",
                                            "/rider/deliveryfeefiter.do",
                                            "/route/route.do",
                                            "/shop/main.do",
                                            "/shop/insert_form.do",
                                            "/shop/insert.do",
                                            "/shop/modify_form.do",
                                            "/shop/modify.do",
                                            "/order/order_list.do",
                                            "/order/order_list_complete.do",
                                            "/shop/menu_list.do",
                                            "/shop/menu_insert_form.do",
                                            "/shop/menu_insert.do",
                                            "/shop/menu_modify_form.do",
                                            "/shop/menu_modify.do",
                                            "/shop/menu_photo_upload.do",
                                            "/shop/menu_delete.do",
                                            "/member/member_main.do",
                                            "/cart/list.do")
                                            
                .excludePathPatterns("/css/**",
                                     "/images/**", 
                                     "/js/**");
                                    
                                    //  "/",
                                    //  "/index.html",
                                    //  "/main/main.do",
                                    //  "/member/login_form.do",
                                    //  "/member/insert_naver.do",
                                    //  "/member/insert_kakao.do",
                                    //  "/member/owner_form.do",
                                    //  "/member/rider_form.do",
                                    // "/EmailVerifyO",
                                    // "/EmailVerifyR",
                                    //  "/EmailAuthO",
                                    //  "/EmailAuthR",
                                    //  "/main/list.do",
                                    //  "/main/detail.do",
                                    //  "/main/detail_menu.do",
                                    //  "/main/detail_review.do",
                                    //  "/main/detail_info.do");

    }

}
