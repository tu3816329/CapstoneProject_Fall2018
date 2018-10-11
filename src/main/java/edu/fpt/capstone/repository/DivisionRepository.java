package edu.fpt.capstone.repository;


import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.entity.Version;

public interface DivisionRepository extends CrudRepository<Division, Integer> {
	
	@Transactional
	@Modifying
	@Query("update Division d set d.versionId =:latestVersionId where d.versionId = 0")
	public int updateDivisionVersion(@Param("latestVersionId") int latestVersionId);
	
	@Transactional
	@Query("select d from Division d where d.versionId > :userVersion")
	public List<Division> getNewDivisions(@Param("userVersion") int userVersion);
	
	public List<Division> findByVersionId(Version version);
}
