package edu.fpt.capstone.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.entity.Exercise;
import edu.fpt.capstone.entity.Solution;
import edu.fpt.capstone.repository.ExerciseRepository;
import edu.fpt.capstone.service.ExerciseService;
import edu.fpt.capstone.service.MathFormulasAdminService;
import edu.fpt.capstone.utils.WebAdminUtils;

@Service
public class ExerciseServiceImpl implements ExerciseService {

	@Autowired
	MathFormulasAdminService service;
	
	@Autowired
	ExerciseRepository exerciseRepository;
	
	@Override
	public Exercise getExerciseById(int exerciseId) {
		return exerciseRepository.findOne(exerciseId);
	}

	@Override
	public List<Exercise> getExercisesBySolution(Solution solution) {
		return exerciseRepository.findBySolutionId(solution);
	}

	@Override
	public void saveExercise(Exercise exercise) {
		exerciseRepository.save(exercise);
	}

	@Override
	public void deleteExercise(int exerciseId) {
		exerciseRepository.delete(exerciseId);
		service.generateDeleteQuery(exerciseId, WebAdminUtils.EXERCISE_TABLE);
	}
}
