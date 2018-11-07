package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import edu.fpt.capstone.entity.Question;
import edu.fpt.capstone.entity.QuestionChoice;
import edu.fpt.capstone.entity.Version;

public interface QuestionChoiceRepository extends CrudRepository<QuestionChoice, Integer> {
	
	public List<QuestionChoice> findByVersionId(Version version);
	
	public List<QuestionChoice> findByQuestionId(Question question);
	
	@Transactional
	@Query("select qc from QuestionChoice qc where qc.versionId.id > :userVersion")
	public List<QuestionChoice> getNewQuestionChoices(@Param("userVersion") int userVersion);
}
