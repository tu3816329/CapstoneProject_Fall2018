package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import edu.fpt.capstone.entity.Version;

public interface VersionRepository extends CrudRepository<Version, Integer> {
	
	@Transactional
	@Modifying
	@Query("update Version v set v.isCurrent = :isCurrent")
	public void deactiveOldVersions(@Param("isCurrent") boolean isCurrent);
	
	@Transactional
	@Query("select v from Version v where databaseVersion > :userVersion")
	public List<Version> getNewVersions(@Param("userVersion") int userCurrentVersion);
	
	@Transactional
	@Query("select max(v.id) from Version v")
	public int getBiggestVersionId();
	
	@Transactional
	@Query("select v from Version v where v.isCurrent = (1)")
	public Version getCurrentVersion();
}
