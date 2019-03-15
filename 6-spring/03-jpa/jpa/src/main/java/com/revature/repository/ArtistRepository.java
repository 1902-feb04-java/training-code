package com.revature.repository;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.revature.model.Artist;

@Repository
public interface ArtistRepository extends JpaRepository<Artist, Long>{

}
