package com.githrd.project;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class ProjectApplication {

	public static void main(String[] args) {
		System.out.println("=================== 애플리케이션 시작됨 ======================");
		SpringApplication.run(ProjectApplication.class, args);
	}

}
