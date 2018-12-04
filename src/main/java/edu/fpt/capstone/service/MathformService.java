package edu.fpt.capstone.service;

import java.util.List;

import edu.fpt.capstone.data.MathformTable;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Mathform;

public interface MathformService {
	
	public List<Mathform> getAllMathforms();
	
	public List<Mathform> getMathformTreeData();

	public Mathform getMathformById(int mathformId);
	
	public void saveMathform(Mathform mathform);
	
	public void deleteMathform(int mathformId);
	
	public List<Mathform> getMathformByLesson(Lesson lesson);
	
	public List<MathformTable> getMathformTableDataByLesson(Lesson lesson);
	
	public List<Mathform> getNoneVersionMathforms();
}
