package edu.fpt.capstone.service;

import java.util.List;

import edu.fpt.capstone.data.QuestionAnswer;
import edu.fpt.capstone.data.Quizes;
import edu.fpt.capstone.entity.Question;

public interface QuestionService {

public List<Quizes> getQuizesData(int lessonId);
	
	public List<Question> getQuestionsByLesson(int lessonId);
	
	public void saveQuizQuestion(QuestionAnswer qa);
	
	public void deleteQuizQuestion(int questionId);
	
	public List<QuestionAnswer> getQuizQuestionsByLesson(int lessonId);
	
	public QuestionAnswer getQuizQuestionByQuestionId(int questionId);
}
