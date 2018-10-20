package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import edu.fpt.capstone.entity.Category;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Version;

public interface LessonRepository extends CrudRepository<Lesson, Integer> {
	public List<Lesson> findByCategoryId(Category categoryId);
	
	@Transactional
	@Modifying
	@Query("update Lesson l set l.versionId = :latestVersionId where l.versionId = 0")
	public int updateFormulaVersion(@Param("latestVersionId") int latestVersionId);
	
	public List<Lesson> findByVersionId(Version version);
	
	@Transactional
	@Query("select l from Lesson l where l.versionId.id > :userVersion")
	public List<Lesson> getNewLessons(@Param("userVersion") int userVersion);
}
