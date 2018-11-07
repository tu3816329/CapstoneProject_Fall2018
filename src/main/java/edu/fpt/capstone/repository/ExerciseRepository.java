package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import edu.fpt.capstone.entity.Exercise;
import edu.fpt.capstone.entity.Mathform;
import edu.fpt.capstone.entity.Version;

public interface ExerciseRepository extends CrudRepository<Exercise, Integer> {
	
	public List<Exercise> findByVersionId(Version version);
	
	public List<Exercise> findByMathformId(Mathform mathform);
	
	@Transactional
	@Query("select e from Exercise e where e.versionId.id > :userVersion")
	public List<Exercise> getNewExercises(@Param("userVersion") int userVersion);
}
