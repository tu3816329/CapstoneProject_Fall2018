package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import edu.fpt.capstone.entity.Question;
import edu.fpt.capstone.entity.QuestionChoices;
import edu.fpt.capstone.entity.Version;

public interface QuestionChoicesRepository extends CrudRepository<QuestionChoices, Integer> {
	
	public List<QuestionChoices> findByVersionId(Version version);
	
	public List<QuestionChoices> findByQuestionId(Question question);
	
	@Transactional
	@Query("select qc from QuestionChoices qc where qc.versionId.id > :userVersion")
	public List<QuestionChoices> getNewQuestionChoices(@Param("userVersion") int userVersion);
}
