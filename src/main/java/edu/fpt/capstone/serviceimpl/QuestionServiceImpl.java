package edu.fpt.capstone.serviceimpl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.data.QuestionAnswer;
import edu.fpt.capstone.data.Quizes;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Question;
import edu.fpt.capstone.entity.QuestionChoice;
import edu.fpt.capstone.entity.Version;
import edu.fpt.capstone.repository.QuestionRepository;
import edu.fpt.capstone.service.LessonService;
import edu.fpt.capstone.service.QuestionChoiceService;
import edu.fpt.capstone.service.QuestionService;
import edu.fpt.capstone.service.VersionService;

@Service
public class QuestionServiceImpl implements QuestionService {

	@Autowired
	QuestionRepository questionRepository;
	
	@Autowired
	LessonService lessonService;
	
	@Autowired
	QuestionChoiceService questionChoiceService;
	
	@Autowired
	VersionService versionService;
	
	@Override
	public List<Quizes> getQuizesData(int lessonId) {
		List<Quizes> data = new ArrayList<Quizes>();
		if (lessonId == 0) {
			List<Lesson> lessons = lessonService.getAllLessons();
			for (Lesson lesson : lessons) {
				int numOfQuestions = questionRepository.findByLessonId(lesson).size();
				Quizes q = new Quizes(lesson.getId(), lesson.getLessonTitle(), numOfQuestions);
				data.add(q);
			}
		} else {
			Lesson lesson = lessonService.getLessonById(lessonId);
			int numOfQuestions = questionRepository.findByLessonId(lesson).size();
			Quizes q = new Quizes(lesson.getId(), lesson.getLessonTitle(), numOfQuestions);
			data.add(q);
		}
		return data;
	}

	@Override
	public List<Question> getQuestionsByLesson(int lessonId) {
		Lesson lesson = lessonService.getLessonById(lessonId);
		return questionRepository.findByLessonId(lesson);
	}

	@Override
	public void saveQuizQuestion(QuestionAnswer qa) {
		Lesson lesson = lessonService.getLessonById(qa.getLessonId());
		Version noneVersion = versionService.getVersionById(0);
		Question question = new Question(qa.getQuestionId(), qa.getQuestionContent(), lesson, noneVersion);
		question = questionRepository.save(question);
		for (QuestionChoice choice : qa.getChoices()) {
			choice.setQuestionId(question);
			choice.setVersionId(noneVersion);
			questionChoiceService.saveQuestionChoice(choice);
		}
	}

	@Override
	public void deleteQuizQuestion(int questionId) {
		Question question = questionRepository.findOne(questionId);
		List<QuestionChoice> choices = questionChoiceService.getQuestionChoicesByQuestion(question);
		for (QuestionChoice choice : choices) {
			questionChoiceService.deleteQuestionChoice(choice);
		}
		questionRepository.delete(question);
	}

	@Override
	public List<QuestionAnswer> getQuizQuestionsByLesson(int lessonId) {
		List<QuestionAnswer> qas = new ArrayList<QuestionAnswer>();
		List<Question> questions = getQuestionsByLesson(lessonId);
		for (Question question : questions) {
			List<QuestionChoice> choices = questionChoiceService.getQuestionChoicesByQuestion(question);
			QuestionAnswer qa = new QuestionAnswer(question.getId(), question.getContent(), choices, lessonId);
			qas.add(qa);
		}
		return qas;
	}

	@Override
	public QuestionAnswer getQuizQuestionByQuestionId(int questionId) {
		Question question = questionRepository.findOne(questionId);
		List<QuestionChoice> choices = questionChoiceService.getQuestionChoicesByQuestion(question);
		QuestionAnswer qa = new QuestionAnswer(questionId, question.getContent(), choices,
				question.getLessonId().getId());
		return qa;
	}
}
