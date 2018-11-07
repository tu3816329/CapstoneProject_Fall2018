package edu.fpt.capstone.service;

import edu.fpt.capstone.data.ResponseData;

public interface MathFormulasAdminService {
	
	public void initializeData();
	
	public void updateDataDbVersion(int latestVersionId);
	 
//	public List<Division> getNewDivisions(int userVersion);
//	
//	public List<Lesson> getNewLessons(int userVersion);
	
	public ResponseData getNewData(int userVersion);
}
