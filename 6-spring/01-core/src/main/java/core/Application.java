package core;

import org.springframework.context.ApplicationContext;
//import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import core.service.ArtistService;

public class Application {

	public static void main(String[] args) {
//		ArtistRepository artistRepository = new ArtistRepository();
//		ArtistService artistService = new ArtistService(artistRepository);
		
//		ApplicationContext context = new ClassPathXmlApplicationContext("beans.xml");
//		ApplicationContext context = new AnnotationConfigApplicationContext(BeanConfig.class);
//		ApplicationContext context = new AnnotationConfigApplicationContext(AutoConfig.class);
		ApplicationContext context = new ClassPathXmlApplicationContext("autobeans.xml");
		
		ArtistService artistService = (ArtistService) context.getBean("artistservice");		
		System.out.println(artistService.getArtists());
		
		((AbstractApplicationContext) context).close();
	}

}
