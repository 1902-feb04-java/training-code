package com.revature.introspring.demo;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel="artists", path="artists")
public interface ArtistRepo extends PagingAndSortingRepository<Artist, Long>{

}
