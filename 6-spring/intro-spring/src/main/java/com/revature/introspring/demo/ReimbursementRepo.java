package com.revature.introspring.demo;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel="reimbursements",path="reimbursements")
public interface ReimbursementRepo extends PagingAndSortingRepository<Reimbursement,Long>{
	
	List <Reimbursement> findByDescription(@Param("desc")String description);
	List <Reimbursement> findByAmount(@Param("amount")double amount);
	
}
