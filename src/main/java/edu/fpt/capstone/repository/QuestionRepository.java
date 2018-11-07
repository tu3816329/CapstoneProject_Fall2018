package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Question;
import edu.fpt.capstone.entity.Version;

public interface QuestionRepository extends CrudRepository<Question, Integer> {
	
	public List<Question> findByVersionId(Version version);
	
	public List<Question> findByLessonId(Lesson lesson);
	
	@Transactional
	@Query("select q from Question q where q.versionId.id > :userVersion")
	public List<Question> getNewQuestions(@Param("userVersion") int userVersion);
}
