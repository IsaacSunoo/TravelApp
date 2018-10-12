package com.skilldistillery.travelapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class TravelAppRestApplication extends SpringBootServletInitializer {
	
	 @Override
	  protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
	      return application.sources(TravelAppRestApplication.class);
	  }

	public static void main(String[] args) {
		SpringApplication.run(TravelAppRestApplication.class, args);
	}
}
