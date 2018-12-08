package edu.fpt.capstone.repository;


import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import edu.fpt.capstone.entity.Subject;
import edu.fpt.capstone.entity.Version;

public interface SubjectRepository extends CrudRepository<Subject, Integer> {
	
	@Transactional
	@Modifying
	@Query("update Solution s set s.versionId = :latestVersionId where s.versionId = 0")
	public int updateSolutionVersion(@Param("latestVersionId") int latestVersionId);
	
	@Transactional
	@Query("select s from Solution s where s.versionId.id > :userVersion")
	public List<Subject> getNewSolutions(@Param("userVersion") int userVersion);
	
	public List<Subject> findByVersionId(Version version);
}
