package edu.fpt.capstone.serviceimpl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.entity.Chapter;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Solution;
import edu.fpt.capstone.entity.Question;
import edu.fpt.capstone.entity.Version;
import edu.fpt.capstone.repository.LessonRepository;
import edu.fpt.capstone.service.LessonService;
import edu.fpt.capstone.service.MathFormulasAdminService;
import edu.fpt.capstone.service.SolutionService;
import edu.fpt.capstone.service.QuestionService;
import edu.fpt.capstone.service.VersionService;
import edu.fpt.capstone.utils.WebAdminUtils;

@Service
public class LessonServiceImpl implements LessonService {

	@Autowired
	MathFormulasAdminService service;

	@Autowired
	LessonRepository lessonRepository;

	@Autowired
	SolutionService solutionService;

	@Autowired
	QuestionService questionService;

	@Autowired
	VersionService versionService;

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
	public List<Lesson> getLessonTreeData() {
		List<Lesson> lessons = getAllLessons();
		int index = 0;
		for (Lesson lesson : lessons) {
			lesson = new Lesson(lesson.getId(), lesson.getTitle(), lesson.getChapterId());
			lessons.set(index++, lesson);
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
		List<Solution> solutions = solutionService.getSolutionByLesson(lesson);
		for (Solution s : solutions) {
			solutionService.deleteSolution(s.getId());
		}
		List<Question> questions = questionService.getQuestionsByLesson(lessonId);
		for (Question question : questions) {
			questionService.deleteQuizQuestion(question.getId());
		}
		lessonRepository.delete(lessonId);
		service.generateDeleteQuery(lessonId, WebAdminUtils.LESSON_TABLE);
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

	@Override
	public List<Lesson> getNoneVersionLessons() {
		Version noneVersion = versionService.getVersionById(0);
		List<Lesson> lessons = lessonRepository.findByVersionId(noneVersion);

		int index = 0;
		for (Lesson lesson : lessons) {
			lesson.setContent(null);
			lessons.set(index++, lesson);
		}
		return lessons;
	}
}
