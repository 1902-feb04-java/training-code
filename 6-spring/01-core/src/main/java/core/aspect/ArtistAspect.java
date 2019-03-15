package core.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class ArtistAspect {
	
	@Before("execution(* get*(..))")
	public void beforeGetArtists() {
		System.out.println("Before calling get");
	}

	@AfterReturning("execution(* get*(..))")
	public void afterGetArtists() {
		System.out.println("After calling get");
	}
	
	@AfterThrowing("execution(* getArtists(..))")
	public void afterGetArtistsThrowsException() {
		System.out.println("OOPS");
	}
	
	@Around("execution(* getArtists(..))")
	public void aroundGetArtists(ProceedingJoinPoint pjp) throws Throwable {
		System.out.println("Calling around method");
		System.out.println(pjp.getSignature());
		pjp.proceed();
		System.out.println("Ending around method");
	}
}
