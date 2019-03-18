package com.revature.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.revature.model.Artist;
import com.revature.services.ArtistService;

@RestController
@RequestMapping("/artists")
public class ArtistController {
	@Autowired
	ArtistService as;
	
	@GetMapping
	public List<Artist> getAllArtists() {
		return as.getAll();
	}
	
	@PostMapping
	public Artist postArtist(@RequestBody @Valid Artist a, Errors errors) throws InvalidArtistException {
		if (errors.hasErrors())
			throw new InvalidArtistException();
		return as.postArtist(a);
	}
	
	@GetMapping("/oops")
	public void oops() throws SQLException {
		throw new SQLException();
	}
	
	@GetMapping("/oopsio")
	public void oopsio() throws IOException {
		throw new IOException();
	}
	
	@ResponseStatus(value=HttpStatus.BAD_GATEWAY)
	@ExceptionHandler(IOException.class)
	public String ioexception() {
		return "IO EXCEPTION!";
	}
	
	
}
