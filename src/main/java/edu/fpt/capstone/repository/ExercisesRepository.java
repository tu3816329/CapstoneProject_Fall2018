package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import edu.fpt.capstone.entity.Exercises;
import edu.fpt.capstone.entity.Mathform;

public interface ExercisesRepository extends CrudRepository<Exercises, Integer> {
	public List<Exercises> findByMathformId(Mathform mathform);
}
