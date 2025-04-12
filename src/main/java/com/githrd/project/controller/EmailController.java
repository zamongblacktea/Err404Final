package com.githrd.project.controller;

import java.util.Random;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.githrd.project.dao.RiderMapper;
import com.githrd.project.vo.RiderVo;

import jakarta.mail.internet.MimeMessage;








@Controller
public class EmailController {

    //log4j 사용하기 위해 초기화 선언하기
    private static final Logger log = LogManager.getLogger(EmailController.class);

    @Autowired
    JavaMailSenderImpl mailSender;

	@Autowired
	RiderMapper riderMapper;


	//이메일 인증 api (google)
	@PostMapping("/EmailAuth")
	@ResponseBody
	public int emailAuth(String email, RiderVo vo) {

		
		String rider_email = vo.getRider_email(); //DB에 이메일정보 가져오기

		int count = riderMapper.selectOneFromEmail(email); //이메일 검색 총합(count) 수

		if(count > 0){//count가 0보다 클 때 (중복 이메일)


			return -1;
		}
		
		log.info("전달 받은 이메일 주소 : " + email);
		
		//난수의 범위 111111 ~ 999999 (6자리 난수)로 인증번호 생성하기
		Random random = new Random();
		int checkNum = random.nextInt(888888)+111111;





	
		
		//이메일 보낼 양식
		String setFrom = "okaqua91@gmail.com"; //2단계 인증 x, 메일 설정에서 POP/IMAP 사용 설정에서 POP/SMTP 사용함으로 설정o
		String toMail = email;
		String title = "회원가입 인증 이메일 입니다.";
		String content = "인증 코드는 " + checkNum + " 입니다." +
						 "<br>" +
						 "해당 인증 코드를 인증 코드 확인란에 기입하여 주세요.";
		
		try {
			MimeMessage message = mailSender.createMimeMessage(); //Spring에서 제공하는 mail API
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content, true);
            mailSender.send(message);
		} catch (Exception e) {
			log.error("이메일 발송 오류",e); //에러 로그 확인용
		}
		
		log.info("랜덤숫자 : " + checkNum);

		return checkNum;
		
	}



}
