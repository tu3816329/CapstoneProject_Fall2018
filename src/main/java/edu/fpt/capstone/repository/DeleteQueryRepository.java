package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import edu.fpt.capstone.entity.DeleteQuery;
import edu.fpt.capstone.entity.Version;

public interface DeleteQueryRepository extends CrudRepository<DeleteQuery, Integer> {

	public List<DeleteQuery> findByVersionId(Version version);
	
	@Query("select q from DeleteQuery q where q.versionId.id > :userVersion")
	public List<DeleteQuery> getNewDeleteQueries(@Param("userVersion") int userVersion);
}
