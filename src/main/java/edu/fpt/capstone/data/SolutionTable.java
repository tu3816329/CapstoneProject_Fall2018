package edu.fpt.capstone.data;

import edu.fpt.capstone.entity.Version;

public class SolutionTable {
	private int id;
	private String title;
	private int numOfExercises;
	private Version versionId;
	
	public SolutionTable() {}
	
	public SolutionTable(int id, String title, int numOfExercises, Version versionId) {
		super();
		this.id = id;
		this.title = title;
		this.numOfExercises = numOfExercises;
		this.versionId = versionId;
	}

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public int getNumOfExercises() {
		return numOfExercises;
	}
	
	public void setNumOfExercises(int numOfExercises) {
		this.numOfExercises = numOfExercises;
	}
	
	public Version getVersionId() {
		return versionId;
	}
	
	public void setVersionId(Version versionId) {
		this.versionId = versionId;
	}
}
