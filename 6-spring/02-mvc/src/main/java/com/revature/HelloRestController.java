package com.revature;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("rest")
public class HelloRestController {

	@GetMapping("/hello")
	public String hello() {
		return "Hello, World!";
	}
	
	@GetMapping("/mehrab")
	public Person mehrab() {
		return new Person(1, "Mehrab", "Rahman");
	}
	
	@PostMapping("/person")
	public Person person(@RequestBody Person p) {
		System.out.println(p.toString());
		p.setFirstName("Adam");
		p.setLastName("King");
		return p;
	}
}
