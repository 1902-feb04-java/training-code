package core.repository;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import core.entity.Artist;

@Repository
public class ArtistRepository {
	List<Artist> artists;
	@Value("Tiffany")
	String defaultArtistName;

	public ArtistRepository() {
	}
	
	public List<Artist> getAllArtists() {
		artists = new ArrayList<>();
		artists.add(new Artist(1, "Bono"));
		artists.add(new Artist(2, "Sting"));
		artists.add(new Artist(3, "Cher"));
		artists.add(new Artist(4, "Prince"));
		artists.add(new Artist(5, defaultArtistName));
		return artists;
	}

	public void setDefaultArtistName(String defaultArtistName) {
		this.defaultArtistName = defaultArtistName;
	}
	
}
