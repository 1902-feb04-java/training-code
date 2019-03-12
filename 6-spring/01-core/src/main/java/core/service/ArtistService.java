package core.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import core.entity.Artist;
import core.repository.ArtistRepository;

@Service
public class ArtistService {
	@Autowired
	private ArtistRepository artistRepository;

	public ArtistService() {
	}

	public void setArtistRepository(ArtistRepository artistRepository) {
		this.artistRepository = artistRepository;
	}

	public List<Artist> getArtists() {
		return this.artistRepository.getAllArtists();
	}
}
