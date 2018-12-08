package edu.fpt.capstone.serviceimpl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.data.SolutionTable;
import edu.fpt.capstone.entity.Exercise;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Solution;
import edu.fpt.capstone.entity.Version;
import edu.fpt.capstone.repository.SolutionRepository;
import edu.fpt.capstone.service.ExerciseService;
import edu.fpt.capstone.service.MathFormulasAdminService;
import edu.fpt.capstone.service.SolutionService;
import edu.fpt.capstone.service.VersionService;
import edu.fpt.capstone.utils.WebAdminUtils;

@Service
public class SolutionServiceImpl implements SolutionService {

	@Autowired
	MathFormulasAdminService service;

	@Autowired
	SolutionRepository solutionRepository;

	@Autowired
	ExerciseService exerciseService;
	
	@Autowired
	VersionService versionService;

	public List<Solution> getAllSolutions() {
		Iterator<Solution> iterator = solutionRepository.findAll().iterator();
		List<Solution> solutions = new ArrayList<Solution>();
		for (Solution solution; iterator.hasNext();) {
			solution = iterator.next();
			solutions.add(solution);
		}
		return solutions;
	}

	@Override
	public List<Solution> getSolutionTreeData() {
		List<Solution> solutions = getAllSolutions();
		int index = 0;
		for (Solution solution : solutions) {
			solution = new Solution(solution.getId(), solution.getTitle(), solution.getLessonId());
			solutions.set(index++, solution);
		}
		return solutions;
	}

	@Override
	public Solution getSolutionById(int solutionId) {
		return solutionRepository.findOne(solutionId);
	}

	@Override
	public void saveSolution(Solution solution) {
		solutionRepository.save(solution);
	}

	@Override
	public void deleteSolution(int solutionId) {
		Solution solution = getSolutionById(solutionId);
		List<Exercise> exercises = exerciseService.getExercisesBySolution(solution);
		for (Exercise e : exercises) {
			exerciseService.deleteExercise(e.getId());
		}
		solutionRepository.delete(solution);
		service.generateDeleteQuery(solutionId, WebAdminUtils.SOLUTION_TABLE);
	}

	@Override
	public List<SolutionTable> getSolutionTableDataByLesson(Lesson lesson) {
		List<Solution> solutions = solutionRepository.findByLessonId(lesson);
		List<SolutionTable> solutionTables = new ArrayList<SolutionTable>();
		for (Solution solution : solutions) {
			int numOfExs = exerciseService.getExercisesBySolution(solution).size();
			SolutionTable data = new SolutionTable(solution.getId(), solution.getTitle(), numOfExs,
					solution.getVersionId());
			solutionTables.add(data);
		}
		return solutionTables;
	}

	@Override
	public List<Solution> getSolutionByLesson(Lesson lesson) {
		return solutionRepository.findByLessonId(lesson);
	}
	
	@Override
	public List<Solution> getNoneVersionSolutions() {
		Version noneVersion = versionService.getVersionById(0);
		List<Solution> solutions = solutionRepository.findByVersionId(noneVersion);
		
		int index = 0;
		for(Solution solution : solutions) {
			solution.setContent(null);
			solutions.set(index++, solution);
		}
		return solutions;
	}
}
