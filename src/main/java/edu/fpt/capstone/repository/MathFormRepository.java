package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Mathform;
import edu.fpt.capstone.entity.Version;

public interface MathFormRepository extends CrudRepository<Mathform, Integer> {
	
	public List<Mathform> findByVersionId(Version version);
	
	public List<Mathform> findByLessonId(Lesson lesson);
	
	@Transactional
	@Query("select m from Mathform m where m.versionId.id > :userVersion")
	public List<Mathform> getNewMathforms(@Param("userVersion") int userVersion);
}
