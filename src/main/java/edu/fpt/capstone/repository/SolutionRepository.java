package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Solution;
import edu.fpt.capstone.entity.Version;

public interface SolutionRepository extends CrudRepository<Solution, Integer> {
	
	public List<Solution> findByVersionId(Version version);
	
	public List<Solution> findByLessonId(Lesson lesson);
	
	@Transactional
	@Query("select s from Solution s where s.versionId.id > :userVersion")
	public List<Solution> getNewSolutions(@Param("userVersion") int userVersion);
}
