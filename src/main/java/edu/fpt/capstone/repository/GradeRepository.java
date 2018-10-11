package edu.fpt.capstone.repository;

import org.springframework.data.repository.CrudRepository;

import edu.fpt.capstone.entity.Grade;

public interface GradeRepository extends CrudRepository<Grade, Integer> {

}
