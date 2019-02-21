package com.revature;

public class Greeter {
    private String greet;
    private String bye;

    public Greeter(String greet, String bye) {
        this.greet = greet;
        this.bye = bye;
    }

    public String greet() {
        return greet;
    }

    public String bye() {
        return bye;
    }
}