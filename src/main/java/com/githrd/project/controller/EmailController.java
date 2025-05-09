package com.githrd.project.controller;

import java.util.Random;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.githrd.project.dao.OwnerMapper;
import com.githrd.project.dao.RiderMapper;
import com.githrd.project.vo.OwnerVo;
import com.githrd.project.vo.RiderVo;

import jakarta.mail.internet.MimeMessage;

@Controller
public class EmailController {

	// log4j 사용하기 위해 초기화 선언하기
	private static final Logger log = LogManager.getLogger(EmailController.class);

	@Autowired
	JavaMailSenderImpl mailSender;

	@Autowired
	RiderMapper riderMapper;

	@Autowired
	OwnerMapper ownerMapper;

	// 라이더 이메일 인증 api (google)
	@PostMapping("/EmailAuthR")
	@ResponseBody
	public int emailAuthRider(String email, RiderVo vo) {

		String rider_email = vo.getRider_email(); // DB에 이메일정보 가져오기

		int rider = riderMapper.selectOneFromEmail(email); // 이메일 select 총합(count) 수

		// 이메일 중복가입 여부 판단 조건문
		if (rider > 0) {// rider가 0보다 클 때 (중복 이메일)

			return 1; 

		}else{ //가입 아이디 없음 (가입 가능)

	

		log.info("전달 받은 이메일 주소 : " + email);

		// 난수의 범위 111111 ~ 999999 (6자리 난수)로 인증번호 생성하기
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;

		// 이메일 보낼 양식
		String setFrom = "okaqua91@gmail.com"; // 2단계 인증 x, 메일 설정에서 POP/IMAP 사용 설정에서 POP/SMTP 사용함으로 설정o
		String toMail = email;
		String title = "안녕하세요. Eatting 가입 인증 이메일 입니다.";
		String content = "인증 코드는 " + checkNum + " 입니다." +
				"<br>" +
				"해당 인증 코드를 인증 코드 확인란에 기입하여 주세요.";

		try {
			MimeMessage message = mailSender.createMimeMessage(); // Spring에서 제공하는 mail API
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);
		} catch (Exception e) {
			//log.error("이메일 발송 오류", e); // 에러 로그 확인용
		}

		log.info("랜덤숫자 : " + checkNum);

		return checkNum;
	}

	}


		//라이더 이메일 인증 아이디 비밀번호 찾기
		@PostMapping("/EmailVerifyR")
		@ResponseBody
		public int emailVerifyRider(String email, RiderVo vo) {
	
	
	
			// 이메일 중복가입 여부 판단 조건문
			int rider = riderMapper.selectOneFromEmail(email); // 이메일 select 총합(count) 수
	
			if (rider == 0) {// rider == 0일때 (가입된 이메일이 없거나 틀림)
	
				return -1; // -1 리턴

			}else{ //가입된 이메일이 존재 (해당 이메일로 인증번호 발송)
	
	
			log.info("전달 받은 이메일 주소 : " + email);
	
			// 난수의 범위 111111 ~ 999999 (6자리 난수)로 인증번호 생성하기
			Random random = new Random();
			int checkNum = random.nextInt(888888) + 111111;
	
			// 이메일 보낼 양식
			String setFrom = "okaqua91@gmail.com"; // 2단계 인증 x, 메일 설정에서 POP/IMAP 사용 설정에서 POP/SMTP 사용함으로 설정o
			String toMail = email;
			String title = "안녕하세요. Eatting 가입 인증 이메일 입니다.";
			String content = "인증 코드는 " + checkNum + " 입니다." +
					"<br>" +
					"해당 인증 코드를 인증 코드 확인란에 기입하여 주세요.";
	
			try {
				MimeMessage message = mailSender.createMimeMessage(); // Spring에서 제공하는 mail API
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
				helper.setFrom(setFrom);
				helper.setTo(toMail);
				helper.setSubject(title);
				helper.setText(content, true);
				mailSender.send(message);
			} catch (Exception e) {
				//log.error("이메일 발송 오류", e); // 에러 로그 확인용
			}
	
			log.info("랜덤숫자 : " + checkNum);
	
			return checkNum;
			
			}
		}//end : EmailVerifyRider





	//사장님 가입 이메일 인증 api (google)
	@PostMapping("/EmailAuthO")
	@ResponseBody
	public int emailAuthOwner(String email, OwnerVo vo) {



		// 이메일 중복가입 여부 판단 조건문
		int owner = ownerMapper.selectOneFromEmail(email); // 이메일 select 총합(count) 수

		if (owner > 0) {// owner가 0보다 클 때 (이미 가입된 이메일)

			return -1; // -1 리턴으로 중복 여부 판단 후 보내기
		}


		log.info("전달 받은 이메일 주소 : " + email);

		// 난수의 범위 111111 ~ 999999 (6자리 난수)로 인증번호 생성하기
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;

		// 이메일 보낼 양식
		String setFrom = "okaqua91@gmail.com"; // 2단계 인증 x, 메일 설정에서 POP/IMAP 사용 설정에서 POP/SMTP 사용함으로 설정o
		String toMail = email;
		String title = "안녕하세요. Eatting 가입 인증 이메일 입니다.";
		String content = "인증 코드는 " + checkNum + " 입니다." +
				"<br>" +
				"해당 인증 코드를 인증 코드 확인란에 기입하여 주세요.";

		try {
			MimeMessage message = mailSender.createMimeMessage(); // Spring에서 제공하는 mail API
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);
		} catch (Exception e) {
			//log.error("이메일 발송 오류", e); // 에러 로그 확인용
		}

		log.info("랜덤숫자 : " + checkNum);

		return checkNum;

	}


}