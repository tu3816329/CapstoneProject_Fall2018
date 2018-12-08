package edu.fpt.capstone.service;

import java.util.List;

import edu.fpt.capstone.data.SolutionTable;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Solution;

public interface SolutionService {
	
	public List<Solution> getAllSolutions();
	
	public List<Solution> getSolutionTreeData();

	public Solution getSolutionById(int solutionId);
	
	public void saveSolution(Solution solution);
	
	public void deleteSolution(int solutionId);
	
	public List<Solution> getSolutionByLesson(Lesson lesson);
	
	public List<SolutionTable> getSolutionTableDataByLesson(Lesson lesson);
	
	public List<Solution> getNoneVersionSolutions();
}
