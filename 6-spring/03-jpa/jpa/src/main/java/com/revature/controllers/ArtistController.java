package com.revature.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
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
	public Artist postArtist(@RequestBody Artist a) {
		return as.postArtist(a);
	}
}
