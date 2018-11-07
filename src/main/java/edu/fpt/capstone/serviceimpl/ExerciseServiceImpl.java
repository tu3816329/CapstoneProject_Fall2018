package edu.fpt.capstone.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.entity.Exercise;
import edu.fpt.capstone.entity.Mathform;
import edu.fpt.capstone.repository.ExerciseRepository;
import edu.fpt.capstone.service.ExerciseService;

@Service
public class ExerciseServiceImpl implements ExerciseService {

	@Autowired
	ExerciseRepository exerciseRepository;
	
	@Override
	public Exercise getExerciseById(int exerciseId) {
		return exerciseRepository.findOne(exerciseId);
	}

	@Override
	public List<Exercise> getExercisesByMathform(Mathform mathform) {
		return exerciseRepository.findByMathformId(mathform);
	}

	@Override
	public void saveExercise(Exercise exercise) {
		exerciseRepository.save(exercise);
	}

	@Override
	public void deleteExercise(int exerciseId) {
		exerciseRepository.delete(exerciseId);
	}
}
