package com.revature.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.revature.model.Artist;
import com.revature.repository.ArtistRepository;

@Service
public class ArtistService {
	@Autowired
	ArtistRepository ar;
	
	@Transactional(readOnly=true)
	public List<Artist> getAll() {
		return ar.findAll();
	}
	
	@Transactional
	public Artist postArtist(Artist a) {
		return ar.save(a);
	}
}
