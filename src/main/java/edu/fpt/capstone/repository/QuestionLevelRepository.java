package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import edu.fpt.capstone.entity.QuestionLevel;
import edu.fpt.capstone.entity.Version;

public interface QuestionLevelRepository extends CrudRepository<QuestionLevel, Integer> {
	
	public List<QuestionLevel> findByVersionId(Version version);
	
	@Transactional
	@Query("select l from QuestionLevel l where l.versionId.id > :userVersion")
	public List<QuestionLevel> getNewLevels(@Param("userVersion") int userVersion);
}
