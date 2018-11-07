package edu.fpt.capstone.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.data.ResponseData;
import edu.fpt.capstone.entity.Chapter;
import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.entity.Exercise;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Grade;
import edu.fpt.capstone.entity.Mathform;
import edu.fpt.capstone.entity.Question;
import edu.fpt.capstone.entity.QuestionChoice;
import edu.fpt.capstone.entity.Version;
import edu.fpt.capstone.repository.ChapterRepository;
import edu.fpt.capstone.repository.DivisionRepository;
import edu.fpt.capstone.repository.ExerciseRepository;
import edu.fpt.capstone.repository.LessonRepository;
import edu.fpt.capstone.repository.GradeRepository;
import edu.fpt.capstone.repository.MathFormRepository;
import edu.fpt.capstone.repository.QuestionChoiceRepository;
import edu.fpt.capstone.repository.QuestionRepository;
import edu.fpt.capstone.repository.VersionRepository;
import edu.fpt.capstone.service.MathFormulasAdminService;

@Service
public class MathFormulasAdminServiceImpl implements MathFormulasAdminService {
	
	@Autowired
	ChapterRepository chapterRepository;
	@Autowired
	GradeRepository gradeRepository;
	@Autowired
	DivisionRepository divisionRepository;
	@Autowired
	LessonRepository lessonRepository;
	@Autowired
	MathFormRepository mathFormRepository;
	@Autowired
	ExerciseRepository exerciseRepository;
	@Autowired
	QuestionRepository questionRepository;
	@Autowired
	QuestionChoiceRepository questionChoiceRepository;
	@Autowired
	VersionRepository versionRepository;

	@Override
	public void initializeData() {
		Version version = new Version(0, 0, "None Version", true);
		version = versionRepository.save(version);
		Grade grade10 = new Grade(1, "Lớp 10", version);
		Grade grade11 = new Grade(2, "Lớp 11", version);
		Grade grade12 = new Grade(3, "Lớp 12", version);
		gradeRepository.save(grade10);
		gradeRepository.save(grade11);
		gradeRepository.save(grade12);
		Division division1 = new Division(1, "Đại số", version);
		Division division2 = new Division(2, "Hình học", version);
		divisionRepository.save(division1);
		divisionRepository.save(division2);
	}

	@Override
	public void updateDataDbVersion(int latestVersionId) {
		Version noneVersion = versionRepository.findOne(0);
		Version latestVersion = versionRepository.findOne(latestVersionId);
		List<Grade> grades = gradeRepository.findByVersionId(noneVersion);
		for (Grade grade : grades) {
			grade.setVersionId(latestVersion);
			gradeRepository.save(grade);
		}
		List<Division> divisions = divisionRepository.findByVersionId(noneVersion);
		for (Division division : divisions) {
			division.setVersionId(latestVersion);
			divisionRepository.save(division);
		}
		List<Chapter> chapters = chapterRepository.findByVersionId(noneVersion);
		for (Chapter chapter : chapters) {
			chapter.setVersionId(latestVersion);
			chapterRepository.save(chapter);
		}
		List<Lesson> lessons = lessonRepository.findByVersionId(noneVersion);
		for (Lesson lesson : lessons) {
			lesson.setVersionId(latestVersion);
			lessonRepository.save(lesson);
		}
		List<Mathform> mathforms = mathFormRepository.findByVersionId(noneVersion);
		for (Mathform mathform : mathforms) {
			mathform.setVersionId(latestVersion);
			mathFormRepository.save(mathform);
		}
		List<Exercise> exercises = exerciseRepository.findByVersionId(noneVersion);
		for (Exercise exercise : exercises) {
			exercise.setVersionId(latestVersion);
			exerciseRepository.save(exercise);
		}
		List<Question> questions = questionRepository.findByVersionId(noneVersion);
		for (Question question : questions) {
			question.setVersionId(latestVersion);
			questionRepository.save(question);
		}
		List<QuestionChoice> choices = questionChoiceRepository.findByVersionId(noneVersion);
		for (QuestionChoice choice : choices) {
			choice.setVersionId(latestVersion);
			questionChoiceRepository.save(choice);
		}
	}

//	@Override
//	public List<Division> getNewDivisions(int userVersion) {
//		return divisionRepository.getNewDivisions(userVersion);
//	}
//
//	@Override
//	public List<Lesson> getNewLessons(int userVersion) {
//		return lessonRepository.getNewLessons(userVersion);
//	}

	@Override
	public ResponseData getNewData(int userVersion) {
		List<Grade> grades = gradeRepository.getNewGrades(userVersion);
		List<Division> divisions = divisionRepository.getNewDivisions(userVersion);
		List<Chapter> chapters = chapterRepository.getNewChapters(userVersion);
		List<Lesson> lessons = lessonRepository.getNewLessons(userVersion);
		List<Mathform> mathforms = mathFormRepository.getNewMathforms(userVersion);
		List<Exercise> exercises = exerciseRepository.getNewExercises(userVersion);
		List<Question> questions = questionRepository.getNewQuestions(userVersion);
		List<QuestionChoice> choices = questionChoiceRepository.getNewQuestionChoices(userVersion);
		ResponseData data = new ResponseData(grades, divisions, chapters, lessons, mathforms, exercises, questions,
				choices);
		return data;
	}
}
