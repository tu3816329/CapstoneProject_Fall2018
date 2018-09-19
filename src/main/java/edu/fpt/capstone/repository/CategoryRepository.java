package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import edu.fpt.capstone.entity.Category;
import edu.fpt.capstone.entity.Division;

public interface CategoryRepository extends CrudRepository<Category, Integer> {
	public List<Category> findByDivisionId(Division division);
}
