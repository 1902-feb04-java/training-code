package com.revature.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@EnableEurekaClient
@SpringBootApplication
@RestController
public class ArtistMicroApplication {

	public static void main(String[] args) {
		SpringApplication.run(ArtistMicroApplication.class, args);
	}
	
	@GetMapping("/artists/1")
	public String example() {
		return "{id:1, name:Prince}";
	}

}
