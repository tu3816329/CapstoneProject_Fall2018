package edu.fpt.capstone.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.data.ResponseData;
import edu.fpt.capstone.entity.Chapter;
import edu.fpt.capstone.entity.DeleteQuery;
import edu.fpt.capstone.entity.Subject;
import edu.fpt.capstone.entity.User;
import edu.fpt.capstone.entity.Exercise;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Grade;
import edu.fpt.capstone.entity.Solution;
import edu.fpt.capstone.entity.Question;
import edu.fpt.capstone.entity.QuestionChoice;
import edu.fpt.capstone.entity.Version;
import edu.fpt.capstone.repository.ChapterRepository;
import edu.fpt.capstone.repository.DeleteQueryRepository;
import edu.fpt.capstone.repository.SubjectRepository;
import edu.fpt.capstone.repository.UserRepository;
import edu.fpt.capstone.repository.ExerciseRepository;
import edu.fpt.capstone.repository.LessonRepository;
import edu.fpt.capstone.repository.GradeRepository;
import edu.fpt.capstone.repository.SolutionRepository;
import edu.fpt.capstone.repository.QuestionChoiceRepository;
import edu.fpt.capstone.repository.QuestionRepository;
import edu.fpt.capstone.repository.VersionRepository;
import edu.fpt.capstone.service.DeleteQueryService;
import edu.fpt.capstone.service.MathFormulasAdminService;
import edu.fpt.capstone.utils.WebAdminUtils;

@Service
public class MathFormulasAdminServiceImpl implements MathFormulasAdminService {
	
	@Autowired
	ChapterRepository chapterRepository;
	@Autowired
	GradeRepository gradeRepository;
	@Autowired
	SubjectRepository subjectRepository;
	@Autowired
	LessonRepository lessonRepository;
	@Autowired
	SolutionRepository solutionRepository;
	@Autowired
	ExerciseRepository exerciseRepository;
	@Autowired
	QuestionRepository questionRepository;
	@Autowired
	QuestionChoiceRepository questionChoiceRepository;
	@Autowired
	VersionRepository versionRepository;
	@Autowired
	DeleteQueryRepository deleteQueryRepository;
	@Autowired
	DeleteQueryService deleteQueryService;
	@Autowired
	UserRepository userRepository;

	@Override
	public void initializeData() {
		User user = userRepository.findOne(1);
		Version version = new Version(0, "None Version", true, user);
		version = versionRepository.save(version);
		Grade grade10 = new Grade(1, "Lớp 10", version);
		Grade grade11 = new Grade(2, "Lớp 11", version);
		Grade grade12 = new Grade(3, "Lớp 12", version);
		gradeRepository.save(grade10);
		gradeRepository.save(grade11);
		gradeRepository.save(grade12);
		Subject division1 = new Subject(1, "Đại số", version);
		Subject division2 = new Subject(2, "Hình học", version);
		subjectRepository.save(division1);
		subjectRepository.save(division2);
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
		List<Subject> subjects = subjectRepository.findByVersionId(noneVersion);
		for (Subject subject : subjects) {
			subject.setVersionId(latestVersion);
			subjectRepository.save(subject);
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
		List<Solution> solutions = solutionRepository.findByVersionId(noneVersion);
		for (Solution solution : solutions) {
			solution.setVersionId(latestVersion);
			solutionRepository.save(solution);
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
		List<DeleteQuery> queries = deleteQueryRepository.findByVersionId(noneVersion);
		for(DeleteQuery query : queries) {
			query.setVersionId(latestVersion);
			deleteQueryRepository.save(query);
		}
	}

	// @Override
	// public List<Division> getNewDivisions(int userVersion) {
	// return divisionRepository.getNewDivisions(userVersion);
	// }
	//
	// @Override
	// public List<Lesson> getNewLessons(int userVersion) {
	// return lessonRepository.getNewLessons(userVersion);
	// }

	@Override
	public ResponseData getNewData(int userVersion) {
		List<Grade> grades = gradeRepository.getNewGrades(userVersion);
		List<Subject> subjects = subjectRepository.getNewSubjects(userVersion);
		List<Chapter> chapters = chapterRepository.getNewChapters(userVersion);
		List<Lesson> lessons = lessonRepository.getNewLessons(userVersion);
		List<Solution> solutions = solutionRepository.getNewSolutions(userVersion);
		List<Exercise> exercises = exerciseRepository.getNewExercises(userVersion);
		List<Question> questions = questionRepository.getNewQuestions(userVersion);
		List<QuestionChoice> choices = questionChoiceRepository.getNewQuestionChoices(userVersion);
		List<DeleteQuery> queries = deleteQueryRepository.getNewDeleteQueries(userVersion);
		ResponseData data = new ResponseData(grades, subjects, chapters, lessons, solutions, 
				exercises, questions, choices, queries);
		return data;
	}

	@Override
	public void generateDeleteQuery(int id, String tableName) {
		Version noneVersion = versionRepository.findOne(0);
		String queryString = "DELETE FROM " + tableName + " where id = " + id;
		if(tableName == WebAdminUtils.USER_CHOICE_TABLE) {
			queryString = "DELETE FROM " + tableName + " where question_id = " + id;
		}
		DeleteQuery query = new DeleteQuery(queryString, noneVersion);
		deleteQueryService.saveDeleteQuery(query);
	}
}
