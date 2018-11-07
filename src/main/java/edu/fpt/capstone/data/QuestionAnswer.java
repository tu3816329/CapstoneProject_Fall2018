package edu.fpt.capstone.data;

import java.util.List;

import edu.fpt.capstone.entity.QuestionChoice;

public class QuestionAnswer {
	private int questionId;
	private String questionContent;
	private List<QuestionChoice> choices;
	private int lessonId; 

	public QuestionAnswer() {
	}

	public QuestionAnswer(int questionId, String questionContent, List<QuestionChoice> choices, int lessonId) {
		super();
		this.questionId = questionId;
		this.questionContent = questionContent;
		this.choices = choices;
		this.lessonId = lessonId;
	}

	public int getQuestionId() {
		return questionId;
	}
	
	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}
	
	public String getQuestionContent() {
		return questionContent;
	}
	
	public void setQuestionContent(String questionContent) {
		this.questionContent = questionContent;
	}
	
	public List<QuestionChoice> getChoices() {
		return choices;
	}
	
	public void setChoices(List<QuestionChoice> choices) {
		this.choices = choices;
	}
	
	public int getLessonId() {
		return lessonId;
	}

	public void setLessonId(int lessonId) {
		this.lessonId = lessonId;
	}
}
