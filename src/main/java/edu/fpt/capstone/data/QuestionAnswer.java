package edu.fpt.capstone.data;

import java.util.List;

import edu.fpt.capstone.entity.QuestionChoices;

public class QuestionAnswer {
	private int questionId;
	private String questionContent;
	private List<QuestionChoices> choices;
	private int lessonId; 

	public QuestionAnswer() {
	}

	public QuestionAnswer(int questionId, String questionContent, List<QuestionChoices> choices, int lessonId) {
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
	
	public List<QuestionChoices> getChoices() {
		return choices;
	}
	
	public void setChoices(List<QuestionChoices> choices) {
		this.choices = choices;
	}
	
	public int getLessonId() {
		return lessonId;
	}

	public void setLessonId(int lessonId) {
		this.lessonId = lessonId;
	}
}
