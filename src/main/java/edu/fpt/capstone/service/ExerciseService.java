package edu.fpt.capstone.service;

import java.util.List;

import edu.fpt.capstone.entity.Exercise;
import edu.fpt.capstone.entity.Mathform;

public interface ExerciseService {

	public Exercise getExerciseById(int exerciseId);
	
	public List<Exercise> getExercisesByMathform(Mathform mathform);
	
	public void saveExercise(Exercise exercise);
	
	public void deleteExercise(int exerciseId);
	
}
