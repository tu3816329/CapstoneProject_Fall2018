package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import edu.fpt.capstone.entity.Question;
import edu.fpt.capstone.entity.QuestionChoices;

public interface QuestionChoicesRepository extends CrudRepository<QuestionChoices, Integer> {
	public List<QuestionChoices> findByQuestionId(Question question);
}
