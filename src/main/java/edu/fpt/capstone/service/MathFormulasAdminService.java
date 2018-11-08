package edu.fpt.capstone.service;

import edu.fpt.capstone.data.ResponseData;

public interface MathFormulasAdminService {
	
	public void initializeData();
	
	public void updateDataDbVersion(int latestVersionId);
	
	public ResponseData getNewData(int userVersion);
	
	public void generateDeleteQuery(int id, String tableName);
}
