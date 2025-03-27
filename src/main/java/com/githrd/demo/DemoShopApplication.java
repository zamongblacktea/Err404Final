package com.githrd.demo;



import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication

// @Configuration
// @MapperScan(basePackages = {"com.githrd.demo.dao"}, annotationClass = Mapper.class)

public class DemoShopApplication {

	public static void main(String[] args) {
		SpringApplication.run(DemoShopApplication.class, args);
	}

}
