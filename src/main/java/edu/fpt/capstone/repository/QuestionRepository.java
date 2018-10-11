package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import edu.fpt.capstone.entity.Category;
import edu.fpt.capstone.entity.Question;

public interface QuestionRepository extends CrudRepository<Question, Integer> {
	public List<Question> findByCategoryId(Category category);
}
