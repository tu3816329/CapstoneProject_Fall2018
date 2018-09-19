package edu.fpt.capstone.repository;

import org.springframework.data.repository.CrudRepository;
import edu.fpt.capstone.entity.Division;

public interface DivisionRepository extends CrudRepository<Division, Integer> {
	
}
