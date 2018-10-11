package edu.fpt.capstone.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Mathform;

public interface MathFormRepository extends CrudRepository<Mathform, Integer> {
	public List<Mathform> findByLessonId(Lesson lesson);
}
