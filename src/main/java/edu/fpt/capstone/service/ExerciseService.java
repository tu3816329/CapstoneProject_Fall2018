package edu.fpt.capstone.service;

import java.util.List;

import edu.fpt.capstone.entity.Exercise;
import edu.fpt.capstone.entity.Solution;

public interface ExerciseService {

	public Exercise getExerciseById(int exerciseId);
	
	public List<Exercise> getExercisesBySolution(Solution solution);
	
	public void saveExercise(Exercise exercise);
	
	public void deleteExercise(int exerciseId);
	
}
