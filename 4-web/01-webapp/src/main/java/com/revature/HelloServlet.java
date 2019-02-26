package com.revature;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class HelloServlet extends HttpServlet {
	@Override
	public void init() {
		System.out.println("Starting up");
	}
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		System.out.println("Hitting doGet");
		String user = (String) session.getAttribute("user");
		if (user == null) {
			user = request.getParameter("user");
			String password = request.getParameter("password");
			session.setAttribute("user", user);
			System.out.println(password);
		}
		
		if (user.equals("Mehrab")) {
			request.getRequestDispatcher("WEB-INF/secret.html").forward(request, response);
		}
		
		PrintWriter out = response.getWriter();
		out.println("<h1>Hello there, " + user + "</h1>");
		out.println("<a href='logout'>Logout</a>");
		out.close();
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	@Override
	public void destroy() {
		System.out.println("Shutting down");
	}
}
