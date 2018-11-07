package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import edu.fpt.capstone.entity.Chapter;
import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.entity.Version;

public interface ChapterRepository extends CrudRepository<Chapter, Integer> {
	
	public List<Chapter> findByDivisionId(Division division);
	
	@Transactional
	@Modifying
	@Query("update Chapter c set c.versionId =:latestVersionId where c.versionId =0")
	public int updateChapterVersion(@Param("latestVersionId") int latestVersionId);
	
	@Transactional
	@Query("select c from Chapter c where c.versionId.id > :userVersion")
	public List<Chapter> getNewChapters(@Param("userVersion") int userVersion);
	
	public List<Chapter> findByVersionId(Version version);
}
