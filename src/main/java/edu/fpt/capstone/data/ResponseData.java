package edu.fpt.capstone.data;

import java.util.List;

import edu.fpt.capstone.entity.Chapter;
import edu.fpt.capstone.entity.DeleteQuery;
import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.entity.Exercise;
import edu.fpt.capstone.entity.Grade;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Mathform;
import edu.fpt.capstone.entity.Question;
import edu.fpt.capstone.entity.QuestionChoice;

public class ResponseData {
	
	private List<Grade> grades;
	private List<Division> divisions;
	private List<Chapter> chapters;
	private List<Lesson> lessons;
	private List<Mathform> mathforms;
	private List<Exercise> exercises;
	private List<Question> questions;
	private List<QuestionChoice> choices;
	private List<DeleteQuery> queries;
	
	public ResponseData() {
	}

	public ResponseData(List<Grade> grades, List<Division> divisions, List<Chapter> chapters, List<Lesson> lessons,
			List<Mathform> mathforms, List<Exercise> exercises, List<Question> questions,
			List<QuestionChoice> choices, List<DeleteQuery> queries) {
		super();
		this.grades = grades;
		this.divisions = divisions;
		this.chapters = chapters;
		this.lessons = lessons;
		this.mathforms = mathforms;
		this.exercises = exercises;
		this.questions = questions;
		this.choices = choices;
		this.queries = queries;
	}

	public List<Grade> getGrades() {
		return grades;
	}
	
	public void setGrades(List<Grade> grades) {
		this.grades = grades;
	}
	
	public List<Division> getDivisions() {
		return divisions;
	}
	
	public void setDivisions(List<Division> divisions) {
		this.divisions = divisions;
	}
	
	public List<Chapter> getChapters() {
		return chapters;
	}
	
	public void setChapters(List<Chapter> chapters) {
		this.chapters = chapters;
	}
	
	public List<Lesson> getLessons() {
		return lessons;
	}
	
	public void setLessons(List<Lesson> lessons) {
		this.lessons = lessons;
	}
	
	public List<Mathform> getMathforms() {
		return mathforms;
	}
	
	public void setMathforms(List<Mathform> mathforms) {
		this.mathforms = mathforms;
	}
	
	public List<Exercise> getExercises() {
		return exercises;
	}
	
	public void setExercises(List<Exercise> exercises) {
		this.exercises = exercises;
	}
	
	public List<Question> getQuestions() {
		return questions;
	}
	
	public void setQuestions(List<Question> questions) {
		this.questions = questions;
	}
	
	public List<QuestionChoice> getChoices() {
		return choices;
	}
	
	public void setChoices(List<QuestionChoice> choices) {
		this.choices = choices;
	}
	
	public List<DeleteQuery> getQueries() {
		return queries;
	}
	
	public void setQueries(List<DeleteQuery> queries) {
		this.queries = queries;
	}
}
