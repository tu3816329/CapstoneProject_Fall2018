package edu.fpt.capstone.service;

import java.util.List;

import edu.fpt.capstone.entity.Question;
import edu.fpt.capstone.entity.QuestionChoice;

public interface QuestionChoiceService {

	public List<QuestionChoice> getQuestionChoicesByQuestion(Question question);
	
	public void saveQuestionChoice(QuestionChoice choice);
	
	public void deleteQuestionChoice(QuestionChoice choice);
}
