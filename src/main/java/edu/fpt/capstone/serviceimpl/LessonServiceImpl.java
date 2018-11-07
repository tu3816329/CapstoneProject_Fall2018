package edu.fpt.capstone.serviceimpl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.entity.Chapter;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Mathform;
import edu.fpt.capstone.entity.Question;
import edu.fpt.capstone.repository.LessonRepository;
import edu.fpt.capstone.service.LessonService;
import edu.fpt.capstone.service.MathformService;
import edu.fpt.capstone.service.QuestionService;

@Service
public class LessonServiceImpl implements LessonService {

	@Autowired
	LessonRepository lessonRepository;
	
	@Autowired
	MathformService mathformService;
	
	@Autowired
	QuestionService questionService;
	
	@Override
	public List<Lesson> getAllLessons() {
		Iterator<Lesson> lIterator = lessonRepository.findAll().iterator();
		List<Lesson> lessons = new ArrayList<Lesson>();
		for (Lesson lesson; lIterator.hasNext();) {
			lesson = lIterator.next();
			lessons.add(lesson);
		}
		return lessons;
	}

	@Override
	public void saveLesson(Lesson lesson) {
		lessonRepository.save(lesson);
	}

	@Override
	public void deleteLesson(int lessonId) {
		Lesson lesson = getLessonById(lessonId);
		List<Mathform> mathforms = mathformService.getMathformByLesson(lesson);
		for (Mathform m : mathforms) {
			mathformService.deleteMathform(m.getId());
		}
		List<Question> questions = questionService.getQuestionsByLesson(lessonId);
		for (Question question : questions) {
			questionService.deleteQuizQuestion(question.getId());
		}
		lessonRepository.delete(lessonId);
	}

	@Override
	public List<Lesson> getLessonsByChapter(Chapter chapter) {
		List<Lesson> lessons = lessonRepository.findByChapterId(chapter);
		return lessons;
	}

	@Override
	public Lesson getLessonById(int id) {
		return lessonRepository.findOne(id);
	}
}
