package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import edu.fpt.capstone.entity.Exercises;
import edu.fpt.capstone.entity.Mathform;
import edu.fpt.capstone.entity.Version;

public interface ExercisesRepository extends CrudRepository<Exercises, Integer> {
	
	public List<Exercises> findByVersionId(Version version);
	
	public List<Exercises> findByMathformId(Mathform mathform);
	
	@Transactional
	@Query("select e from Exercises e where e.versionId.id > :userVersion")
	public List<Exercises> getNewExercises(@Param("userVersion") int userVersion);
}
