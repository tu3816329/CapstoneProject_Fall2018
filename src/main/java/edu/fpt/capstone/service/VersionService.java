package edu.fpt.capstone.service;

import java.util.List;

import edu.fpt.capstone.entity.Version;

public interface VersionService {

	public List<Version> getAllVersion();
	
	public Version getVersionById(int versionId);
	
	public Version upgradeVersion(Version version);
	
	public Version getCurrentVersion();
	
	public List<Version> getNewVersions(int userVersion);
	
	public int countVersion();
}
