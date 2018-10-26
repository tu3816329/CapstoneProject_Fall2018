package edu.fpt.capstone.data;

public class Quizes {
	private int lessonId;
	private String lessonTitle;
	private int numOfQuestions;
	
	public Quizes() {
		super();
	}
	
	public Quizes(int lessonId, String lessonTitle, int numOfQuestions) {
		super();
		this.lessonId = lessonId;
		this.lessonTitle = lessonTitle;
		this.numOfQuestions = numOfQuestions;
	}
	
	public int getLessonId() {
		return lessonId;
	}

	public void setLessonId(int lessonId) {
		this.lessonId = lessonId;
	}

	public String getLessonTitle() {
		return lessonTitle;
	}
	
	public void setLessonTitle(String lessonTitle) {
		this.lessonTitle = lessonTitle;
	}
	
	public int getNumOfQuestions() {
		return numOfQuestions;
	}
	
	public void setNumOfQuestions(int numOfQuestions) {
		this.numOfQuestions = numOfQuestions;
	}
}
