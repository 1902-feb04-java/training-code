package com.revature.soap;

import javax.jws.WebService;

@WebService(endpointInterface="com.revature.soap.HelloService", serviceName= "HelloService")
public class HelloServiceImpl implements HelloService {

	@Override
	public String getHello(String name) {
		return "Hello, " + name;
	}

}
