package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import edu.fpt.capstone.entity.Category;
import edu.fpt.capstone.entity.FormulaDetail;

public interface FormulaDetailRepository extends CrudRepository<FormulaDetail, Integer> {
	public List<FormulaDetail> findByCategoryId(Category categoryId);
}
