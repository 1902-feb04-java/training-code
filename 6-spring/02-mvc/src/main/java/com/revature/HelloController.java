package com.revature;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("v1")
public class HelloController {
	@RequestMapping(value = "/hello", method = RequestMethod.GET)
	public ResponseEntity<String> helloWorld() {
		logMethod();
		return ResponseEntity.ok("Hello World");
	}

	@GetMapping("/beans")
	public String beans() {
		return "/static/beans.html";
	}

	@GetMapping("/pinto")
	public String pinto() {
		return beans();
	}

	@GetMapping("/java")
	public String java() {
		return "forward:/v1/beans";
	}

	@GetMapping("/google")
	public String google() {
		return "redirect:http://www.google.com";
	}

	@GetMapping("{name}/{id}")
	public ResponseEntity<String> helloName(@PathVariable("name") String n, @PathVariable("id") Integer i) {
		return ResponseEntity.ok(i + ") Hello, " + n);
	}

	@PostMapping(path = "/post", consumes = "text/plain")
	public ResponseEntity<String> post(@RequestBody String input) {
		System.out.println(input);
		return ResponseEntity.ok(input);
	}

	@PostMapping(path = "/person", consumes = "application/json", produces = "application/json")
	public ResponseEntity<Person> post(@RequestBody Person input) {
		System.out.println(input);
		return ResponseEntity.ok(input);
	}

	public void logMethod() {
		System.out.println("logged");
	}
}
