package edu.fpt.capstone.data;

import edu.fpt.capstone.entity.Version;

public class MathformTable {
	private int id;
	private String mathformTitle;
	private int numOfExercises;
	private Version versionId;
	
	public MathformTable() {}
	
	public MathformTable(int id, String mathformTitle, int numOfExercises, Version versionId) {
		super();
		this.id = id;
		this.mathformTitle = mathformTitle;
		this.numOfExercises = numOfExercises;
		this.versionId = versionId;
	}

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public String getMathformTitle() {
		return mathformTitle;
	}
	
	public void setMathformTitle(String mathformTitle) {
		this.mathformTitle = mathformTitle;
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
