package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import edu.fpt.capstone.entity.Grade;
import edu.fpt.capstone.entity.Version;

public interface GradeRepository extends CrudRepository<Grade, Integer> {
	
	public List<Grade> findByVersionId(Version version);
	
	@Transactional
	@Query("select g from Grade g where g.versionId.id > :userVersion")
	public List<Grade> getNewGrades(@Param("userVersion") int userVersion);
}
