package edu.fpt.capstone.data;

import java.util.List;

import edu.fpt.capstone.entity.Category;
import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.entity.Exercises;
import edu.fpt.capstone.entity.Grade;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Mathform;
import edu.fpt.capstone.entity.Question;
import edu.fpt.capstone.entity.QuestionChoices;
import edu.fpt.capstone.entity.QuestionLevel;

public class ResponseData {
	
	private List<Grade> grades;
	private List<Division> divisions;
	private List<Category> categories;
	private List<Lesson> lessons;
	private List<Mathform> mathforms;
	private List<Exercises> exercises;
	private List<Question> questions;
	private List<QuestionChoices> choices;
	private List<QuestionLevel> levels;
	
	public ResponseData() {
	}

	public ResponseData(List<Grade> grades, List<Division> divisions, List<Category> categories, List<Lesson> lessons,
			List<Mathform> mathforms, List<Exercises> exercises, List<Question> questions,
			List<QuestionChoices> choices, List<QuestionLevel> levels) {
		super();
		this.grades = grades;
		this.divisions = divisions;
		this.categories = categories;
		this.lessons = lessons;
		this.mathforms = mathforms;
		this.exercises = exercises;
		this.questions = questions;
		this.choices = choices;
		this.levels = levels;
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
	
	public List<Category> getCategories() {
		return categories;
	}
	
	public void setCategories(List<Category> categories) {
		this.categories = categories;
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
	
	public List<Exercises> getExercises() {
		return exercises;
	}
	
	public void setExercises(List<Exercises> exercises) {
		this.exercises = exercises;
	}
	
	public List<Question> getQuestions() {
		return questions;
	}
	
	public void setQuestions(List<Question> questions) {
		this.questions = questions;
	}
	
	public List<QuestionChoices> getChoices() {
		return choices;
	}
	
	public void setChoices(List<QuestionChoices> choices) {
		this.choices = choices;
	}
	
	public List<QuestionLevel> getLevels() {
		return levels;
	}
	
	public void setLevels(List<QuestionLevel> levels) {
		this.levels = levels;
	}
}
