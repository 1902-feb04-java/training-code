package com.revature.sandwich;

public class SandwichFactory {
	static SandwichFactory sf = new SandwichFactory();
	
	public static SandwichFactory getInstance() {
		return sf;
	}
	
	public Sandwich build(String fileName) {
		return new Sandwich(fileName);
	}
}
