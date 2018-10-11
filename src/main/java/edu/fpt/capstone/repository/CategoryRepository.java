package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import edu.fpt.capstone.entity.Category;
import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.entity.Version;

public interface CategoryRepository extends CrudRepository<Category, Integer> {
	public List<Category> findByDivisionId(Division division);
	
	@Transactional
	@Modifying
	@Query("update Category c set c.versionId =:latestVersionId where c.versionId =0")
	public int updateCategoryVersion(@Param("latestVersionId") int latestVersionId);
	
	@Transactional
	@Query("select c from Category c where c.versionId > :userVersion")
	public List<Category> getNewCategories(@Param("userVersion") int userVersion);
	
	public List<Category> findByVersionId(Version version);
}
