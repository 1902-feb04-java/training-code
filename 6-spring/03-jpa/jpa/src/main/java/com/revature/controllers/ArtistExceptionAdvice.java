package com.revature.controllers;

import java.sql.SQLException;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice
public class ArtistExceptionAdvice {
	@ResponseStatus(HttpStatus.I_AM_A_TEAPOT)
	@ExceptionHandler(SQLException.class)
	@ResponseBody
	public String sqlexcatch() {
		return "SQL EXCEPTION!!!";
	}
}
