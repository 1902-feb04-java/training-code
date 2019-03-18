package com.revature.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value=HttpStatus.BAD_GATEWAY, reason="Follow the rules!")
public class InvalidArtistException extends Exception {
	
}
