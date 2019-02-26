# HTTP/HTML
Hypertext Transfer Protocol & Hypertext Markup Language, the two main technologies for a web browser. HTML provides a structure for static content on web pages. HTML documents are organized by element tags, some with attributes. Browsers don't display the element tags, but instead parse them to render content.

<html>
    <body>
        <p>Hello there!</p>
        <a src="www.google.com">Google</a>
    </body>
</html>

HTTP is all about sending and receiving documents. A document is abstracted from HTTP packet that has information like metadata, contents, status codes.

## HTTP Status Codes
- 100-199: INFO
- 200-299: OK/Success
- 300-399: Redirect
- 400-499: Error/Request Incomplete
- 500-599: Server Error

## HTTP Methods (Verbs)
 - GET: retrieves information, sends info in the URL itself, empty body
>localhost:8080/ExampleContext/example?name="bob"

 - POST: Send info as text or binary in a body
 - PUT
 - DELETE
 - PATCH
 - UPDATE
 - TRACE
 - HEAD
 - OPTIONS

# JavaEE
Java Enterprise Edition, this is a community driven collection of Specifications, APIs and Frameworks which provide enterprise functionality. We will start with Java Servlets, a JavaEE API for communicating between a Java code base and HTTP.

Found in `javax.servlet` and `javax.http` the Servlet API provides a Servlet Interface which is implemented by the GenericServlet Abstract Class, then the HTTPServlet Abstract Class, and then finally allows you to extend the HTTPServlet.

In a normal servlet process:
- The client sends an HTTP Request to a (Servlet) Web Container, which is a Java Server that is running your application. We will be using Apache Tomcat, which is Apache's lightweight implementation of the JavaEE Server and Servlet Container spec.
- Your Tomcat server will have your application in its webapps folder (as a war, usually), and this application will have the following:
    - *src/*: for the servlet and other business logic code
    - *webapp/*: for any hosted HTML-related files, as well as:
    - **Deployment Descriptor**: commonly a *web.xml* file that maps incoming requests to your Servlets.
- Java application on Tomcat will handle Request as well as the Response by creating Java objects to model the Request/Response.

## Servlet - Lifecycle
The Tomcat server will handle the control flow of your application through a servlet lifecycle process.
1. When a request comes in, the container instantiates any appropriate servlets
1. Once instantiated the container initializes the servlet by invoking its `init()` method
1. After initialization (or existing servlet is found), the container invokes `service()` to process the request.
    1. public void service (ServletRequest req, ServletResponse resp) {...} ->
    1. protected void service (HttpServletRequest req, HttpServletResponse resp) {...} ->
    1. protected void doGet (HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {...} //You write this
1. Response object is returned to client
1. When the container shuts down or needs to conserve memory or just because a servlet's stated lifespan is reached, the container will call the `destroy()` method of your servlet.

tl;dr Container calls init() once, service() many times, and eventually destroy() once.

## WAR
JEE web applications are usually packaged as `.war` files, a web archive similar to a `.jar` but with some minor changes to folder heirarchy. A `src/main/webapp` folder becomes the root directory, and the archive is usually hosted on a Java web server such as **Apache Tomcat**. Be sure to set the `packaging` property in your `pom.xml` to `war`:
#### pom.xml
```xml
...
<packaging>war</packaging>
...
```

## Dependencies
To begin using Java Servlets, include the following dependency to your Maven `pom.xml`:
#### pom.xml
```xml
...
<groupId>javax.servlet</groupId>
<artifactId>servlet-api</artifactId>
<version>2.5</version>
...
```
`Servlet` is a JEE specification which is not included in Java's standard library, so it must be imported or the project must use a JDK with JEE libraries included already.

## Deployment Descriptor
A Java server like Tomcat will deploy a web archive and register all servlets according to the *deployment descriptor* found in `src/main/webapp/WEB-INF/web.xml`:
#### web.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://java.sun.com/xml/ns/javaee" xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd" version="2.5">

...

</web-app>
```
Servlets, Filters, Context parameters, and other configurations are declared and defined in the `web.xml` 

## Servlet Mapping
Servlet classes are registered in the `web.xml` by assigning a name to both a url mapping and the fully qualified class name of the Servlet:
#### web.xml
```xml
...
<servlet>
    <servlet-name>myServlet</servlet-name>
    <servlet-class>servlets.MyServlet</servlet-class>
</servlet>

<servlet-mapping>
    <servlet-name>myServlet</servlet-name>
    <url-pattern>/myServlet</url-pattern>
</servlet-mapping>
...
```
This will provide access to the servlet through its url mapping, in the above case at `http:[hostname]:[port]/[app-context]/myServlet`

## Servlet
The Servlet API provides the `HttpServlet` abstract class which can be extended to define your own custom behavior:
#### MyServlet.java
```java
package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
            // Implements GET behavior
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
            // Implements POST behavior
	}
}
```
The `HttpServletRequest` object provides useful methods such as `getParameter(String name)` which returns the value of a Query or post body parameter. `HttpServletResponse` provides a `getWriter()` method which returns a `PrintWriter` object to append data to the response body.

## Servlet 3+
More recent versions of the Servlet API offer convenience annotations that allows configuration in a decorator over the Servlet class itself, leaving the `web.xml` blank for the most part:

#### pom.xml
```xml
...
<groupId>javax.servlet</groupId>
<artifactId>javax.servlet-api</artifactId>
<version>3.0.1</version>
<scope>provided</scope>
...
```

#### MyServlet.java
```java
package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/myServlet")
public class MyServlet extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
            // Implements GET behavior
	}
}
```