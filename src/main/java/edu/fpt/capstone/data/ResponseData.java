package edu.fpt.capstone.data;

import java.util.List;

import edu.fpt.capstone.entity.Chapter;
import edu.fpt.capstone.entity.DeleteQuery;
import edu.fpt.capstone.entity.Subject;
import edu.fpt.capstone.entity.Exercise;
import edu.fpt.capstone.entity.Grade;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Solution;
import edu.fpt.capstone.entity.Question;
import edu.fpt.capstone.entity.QuestionChoice;

public class ResponseData {
	
	private List<Grade> grades;
	private List<Subject> subjects;
	private List<Chapter> chapters;
	private List<Lesson> lessons;
	private List<Solution> solutions;
	private List<Exercise> exercises;
	private List<Question> questions;
	private List<QuestionChoice> choices;
	private List<DeleteQuery> queries;
	
	public ResponseData() {
	}

	public ResponseData(List<Grade> grades, List<Subject> subjects, List<Chapter> chapters, List<Lesson> lessons,
			List<Solution> solutions, List<Exercise> exercises, List<Question> questions,
			List<QuestionChoice> choices, List<DeleteQuery> queries) {
		super();
		this.grades = grades;
		this.subjects = subjects;
		this.chapters = chapters;
		this.lessons = lessons;
		this.solutions = solutions;
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
	
	public List<Subject> getSubjects() {
		return subjects;
	}
	
	public void setSubjects(List<Subject> subjects) {
		this.subjects = subjects;
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
	
	public List<Solution> getSolutions() {
		return solutions;
	}
	
	public void setSolutions(List<Solution> solutions) {
		this.solutions = solutions;
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
