package com.revature;

import static org.junit.Assert.assertTrue;

import org.junit.Before;

import static org.junit.Assert.assertEquals;

import org.junit.Test;

public class AppTest 
{
    Greeter testGreeter;

    @Before
    public void setup() {
        testGreeter = new Greeter("Hello World", "Goodbye");
    }

    @Test
    public void shouldAnswerWithTrue() {
        assertTrue( true );
    }

    @Test
    public void greetShouldReturnHelloWorld() {
        assertEquals(testGreeter.greet(), "Hello World");
    }

    @Test public void greetShouldReturnHolaMundo() {
        testGreeter = new Greeter("Hola Mundo", "Adios");
        assertEquals("Hola Mundo", testGreeter.greet());
        assertEquals("Adios", testGreeter.bye());
    }

    @Test  
    public void afterGreetShouldSayGoodbye() {
        assertEquals(testGreeter.bye(), "Goodbye");
    }
}
