package core;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import core.repository.ArtistRepository;
import core.service.ArtistService;

@Configuration
public class BeanConfig {
	@Bean(name="artistrepository")
	public ArtistRepository getArtistRepository() {
		ArtistRepository bean = new ArtistRepository();
		bean.setDefaultArtistName("Tiffany");
		return bean;
	}
	
	@Bean(name="artistservice")
	public ArtistService getArtistService(@Qualifier("artistrepository") ArtistRepository ar) {
		ArtistService bean = new ArtistService();
		bean.setArtistRepository(ar);
		return bean;
	}
}
