package edu.fpt.capstone.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.data.MathformTable;
import edu.fpt.capstone.data.QuestionAnswer;
import edu.fpt.capstone.data.Quizes;
import edu.fpt.capstone.data.ResponseData;
import edu.fpt.capstone.entity.Category;
import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.entity.Exercises;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Grade;
import edu.fpt.capstone.entity.Mathform;
import edu.fpt.capstone.entity.Question;
import edu.fpt.capstone.entity.QuestionChoices;
import edu.fpt.capstone.entity.QuestionLevel;
import edu.fpt.capstone.entity.Version;
import edu.fpt.capstone.repository.CategoryRepository;
import edu.fpt.capstone.repository.DivisionRepository;
import edu.fpt.capstone.repository.ExercisesRepository;
import edu.fpt.capstone.repository.LessonRepository;
import edu.fpt.capstone.repository.GradeRepository;
import edu.fpt.capstone.repository.MathFormRepository;
import edu.fpt.capstone.repository.QuestionChoicesRepository;
import edu.fpt.capstone.repository.QuestionLevelRepository;
import edu.fpt.capstone.repository.QuestionRepository;
import edu.fpt.capstone.repository.VersionRepository;
import edu.fpt.capstone.service.MathFormulasAdminService;

@Service
public class MathFormulasAdminServiceImpl implements MathFormulasAdminService {

	@Autowired
	GradeRepository gradeRepository;
	@Autowired
	DivisionRepository divisionRepository;
	@Autowired
	CategoryRepository categoryRepository;
	@Autowired
	LessonRepository lessonRepository;
	@Autowired
	MathFormRepository mathFormRepository;
	@Autowired
	ExercisesRepository exercisesRepository;
	@Autowired
	QuestionRepository questionRepository;
	@Autowired
	QuestionChoicesRepository questionChoicesRepository;
	@Autowired
	QuestionLevelRepository questionLevelRepository;
	@Autowired
	VersionRepository versionRepository;
	
	@Override
	public List<Grade> getAllGrades() {
		Iterator<Grade> dIterator = gradeRepository.findAll().iterator();
		List<Grade> grades = new ArrayList<Grade>();
		for (Grade grade; dIterator.hasNext();) {
			grade = dIterator.next();
			grades.add(grade);
		}
		return grades;
	}
	
	@Override
	public List<Division> getAllDivisions() {
		Iterator<Division> dIterator = divisionRepository.findAll().iterator();
		List<Division> divisions = new ArrayList<Division>();
		for (Division division; dIterator.hasNext();) {
			division = dIterator.next();
			divisions.add(division);
		}
		return divisions;
	}
	
	@Override
	public List<Category> getAllCategories() {
		Iterator<Category> cIterator = categoryRepository.findAll().iterator();
		List<Category> categories = new ArrayList<Category>();
		for(Category category; cIterator.hasNext();) {
			category = cIterator.next();
			categories.add(category);
		}
		return categories;
	}

	@Override
	public Division getDivisionById(int id) {
		return divisionRepository.findOne(id);
	}
	
	@Override
	public List<Category> getCategoriesByDivision(Division division) {
		List<Category> categories = categoryRepository.findByDivisionId(division);
		return categories;
	}

	@Override
	public Category getCategoryById(int id) {
		return categoryRepository.findOne(id);
	}
	
	@Override
	public boolean isEqualCategory(Category oldCategory, Category newCategory) {
		return (oldCategory.getCategoryName().equals(newCategory.getCategoryName().trim()))
				&& (oldCategory.getDivisionId().getId() == newCategory.getDivisionId().getId())
				&& (oldCategory.getGradeId().getId() == newCategory.getGradeId().getId());
	}
	
	@Override
	public void saveCategories(List<Category> categories) {
		for(Category newCategory : categories) {
			Version noneVersion = getVersionById(0);
			if(newCategory.getId() != 0) {
				Category oldCategory = getCategoryById(newCategory.getId());
				if(!isEqualCategory(oldCategory, newCategory)) {
					newCategory.setCategoryIcon(oldCategory.getCategoryIcon());
					newCategory.setVersionId(noneVersion);
					categoryRepository.save(newCategory);
				}
			} else {
				newCategory.setVersionId(noneVersion);
				categoryRepository.save(newCategory);
			}
		}
	}
	
	@Override
	public void deleteCategory(int categoryId) {
		Category category = getCategoryById(categoryId);
		List<Lesson> lessons = getLessonsByCategory(category);
		for(Lesson l : lessons) {
			deleteLesson(l.getId());
		}
		List<Question> questions = getQuestionsByCategory(categoryId);
		for(Question q : questions) {
			deleteQuizQuestion(q.getId());
		}
		categoryRepository.delete(categoryId);
	}
	
	@Override
	public void saveCategory(Category category) {
		categoryRepository.save(category);
	}
	
	@Override
	public void saveLesson(Lesson lesson) {
		lessonRepository.save(lesson);
	}
	
	@Override
	public void deleteLesson(int lessonId) {
		Lesson lesson = getLessonById(lessonId);
		List<Mathform> mathforms = mathFormRepository.findByLessonId(lesson);
		for(Mathform m : mathforms) {
			deleteMathform(m.getId());
		}
		lessonRepository.delete(lessonId);
	}

	@Override
	public List<Lesson> getLessonsByCategory(Category category) {
		List<Lesson> lessons = lessonRepository.findByCategoryId(category);
		return lessons;
	}

	@Override
	public Lesson getLessonById(int id) {
		return lessonRepository.findOne(id);
	}
	
	@Override
	public Mathform getMathformById(int mathformId) {
		return mathFormRepository.findOne(mathformId);
	}
	
	@Override
	public void saveMathform(Mathform mathform) {
		mathFormRepository.save(mathform);
	}
	
	@Override
	public void deleteMathform(int mathformId) {
		Mathform mathform = getMathformById(mathformId);
		List<Exercises> exercises = getExercisesByMathform(mathform);
		for (Exercises e : exercises) {
			exercisesRepository.delete(e);
		}
		mathFormRepository.delete(mathform);
	}
	
	@Override
	public List<MathformTable> getMathformTableDataByLesson(Lesson lesson) {
		List<Mathform> mathforms = mathFormRepository.findByLessonId(lesson);
		List<MathformTable> mathFormTables = new ArrayList<MathformTable>();
		for (Mathform mathform : mathforms) {
			int numOfExs = exercisesRepository.findByMathformId(mathform).size();
			MathformTable data = new MathformTable(
					mathform.getId(), mathform.getMathformTitle(), 
					numOfExs, mathform.getVersionId()
			);
			mathFormTables.add(data);
		}
		return mathFormTables;
	}
	
	@Override
	public Exercises getExerciseById(int exerciseId) {
		return exercisesRepository.findOne(exerciseId);
	}
	
	@Override
	public List<Exercises> getExercisesByMathform(Mathform mathform) {
		return exercisesRepository.findByMathformId(mathform);
	}

	@Override
	public void saveExercise(Exercises exercise) {
		exercisesRepository.save(exercise);
	}
	
	@Override
	public void deleteExercise(int exerciseId) {
		exercisesRepository.delete(exerciseId);
	}
	
	@Override
	public List<Quizes> getQuizesData(int categoryId) {
		List<Quizes> data = new ArrayList<Quizes>();
		if(categoryId == 0) {
			List<Category> categories = getAllCategories();
			for (Category category : categories) {
				int numOfQuestions = questionRepository.findByCategoryId(category).size();
				Quizes q = new Quizes(category.getId(), category.getCategoryName(), 
						category.getCategoryIcon(), numOfQuestions);;
				data.add(q);
			}
		} else {
			Category category = getCategoryById(categoryId);
			int numOfQuestions = questionRepository.findByCategoryId(category).size();
			Quizes q = new Quizes(category.getId(), category.getCategoryName(), 
					category.getCategoryIcon(), numOfQuestions);
			data.add(q);
		}
		return data;
	}
	
	@Override
	public List<Question> getQuestionsByCategory(int categoryId) {
		Category category = categoryRepository.findOne(categoryId);
		return questionRepository.findByCategoryId(category);
	}
	
	@Override
	public List<QuestionChoices> getQuestionChoicesByQuestion(Question question) {
		return questionChoicesRepository.findByQuestionId(question);
	}
	
	@Override
	public void saveQuizQuestion(QuestionAnswer qa) {
		Category category = getCategoryById(qa.getCategoryId());
		Version noneVersion = getVersionById(0);
		Question question = new Question(qa.getQuestionId(), qa.getQuestionContent(), category, noneVersion);
		question = questionRepository.save(question);
		for (QuestionChoices c : qa.getChoices()) {
			c = new QuestionChoices(c.getId(), c.getContent(), c.getIsCorrect(), question, noneVersion);
			questionChoicesRepository.save(c);
		}
	}
	
	@Override
	public void deleteQuizQuestion(int questionId) {
		Question question = questionRepository.findOne(questionId);
		List<QuestionChoices> choices = getQuestionChoicesByQuestion(question);
		for(QuestionChoices c : choices) {
			questionChoicesRepository.delete(c);
		}
		questionRepository.delete(question);
	}
	
	@Override
	public List<QuestionAnswer> getQuizQuestionsByCategory(int categoryId) {
		List<QuestionAnswer> qas = new ArrayList<QuestionAnswer>();
		List<Question> questions = getQuestionsByCategory(categoryId);
		for (Question question : questions) {
			List<QuestionChoices> choices = getQuestionChoicesByQuestion(question);
			QuestionAnswer qa = new QuestionAnswer(question.getId(), question.getContent(), choices, categoryId);
			qas.add(qa);
		}
		return qas;
	}
	
	@Override
	public QuestionAnswer getQuizQuestionByQuestionId(int questionId) {
		Question question = questionRepository.findOne(questionId);
		List<QuestionChoices> choices = getQuestionChoicesByQuestion(question);
		QuestionAnswer qa = new QuestionAnswer(questionId, question.getContent(), choices, question.getCategoryId().getId());
		return qa;
	}
	
	@Override
	public List<Version> getAllVersion() {
		Iterator<Version> vIterator = versionRepository.findAll().iterator();
		List<Version> versions = new ArrayList<Version>();
		for(Version v; vIterator.hasNext();) {
			v = vIterator.next();
			versions.add(v);
		}
		return versions;
	}

	@Override
	public Version upgradeVersion(Version version) {
		versionRepository.deactiveOldVersions(false);
		version.setIsCurrent(true);
		version.setId(versionRepository.getBiggestVersionId() + 1);
		return versionRepository.save(version);
	}
	
	@Override
	public void initializeData() {
		Version version = new Version(0, 0, "None Version", true);
		version = versionRepository.save(version);
		Grade grade10 = new Grade(1, "Lớp 10", version);
		Grade grade11 = new Grade(2, "Lớp 10", version);
		Grade grade12 = new Grade(3, "Lớp 10", version);
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
		for(Grade grade : grades) {
			grade.setVersionId(latestVersion);
			gradeRepository.save(grade);
		}
		List<Division> divisions = divisionRepository.findByVersionId(noneVersion);
		for(Division division : divisions) {
			division.setVersionId(latestVersion);
			divisionRepository.save(division);
		}
		List<Category> categories = categoryRepository.findByVersionId(noneVersion);
		for(Category category : categories) {
			category.setVersionId(latestVersion);
			categoryRepository.save(category);
		}
		List<Lesson> lessons = lessonRepository.findByVersionId(noneVersion);
		for(Lesson lesson : lessons) {
			lesson.setVersionId(latestVersion);
			lessonRepository.save(lesson);
		}
		List<Mathform> mathforms = mathFormRepository.findByVersionId(noneVersion);
		for(Mathform mathform : mathforms) {
			mathform.setVersionId(latestVersion);
			mathFormRepository.save(mathform);
		}
		List<Exercises> exercises = exercisesRepository.findByVersionId(noneVersion);
		for(Exercises exercise : exercises) {
			exercise.setVersionId(latestVersion);
			exercisesRepository.save(exercise);
		}
		List<Question> questions = questionRepository.findByVersionId(noneVersion);
		for(Question question : questions) {
			question.setVersionId(latestVersion);
			questionRepository.save(question);
		}
		List<QuestionChoices> choices = questionChoicesRepository.findByVersionId(noneVersion);
		for(QuestionChoices choice : choices) {
			choice.setVersionId(latestVersion);
			questionChoicesRepository.save(choice);
		}
		List<QuestionLevel> levels = questionLevelRepository.findByVersionId(noneVersion);
		for(QuestionLevel level : levels) {
			level.setVersionId(latestVersion);
			questionLevelRepository.save(level);
		}
	}

	@Override
	public List<Version> getNewVersions(int userVersion) {
		return versionRepository.getNewVersions(userVersion);
	}

	@Override
	public List<Division> getNewDivisions(int userVersion) {
		return divisionRepository.getNewDivisions(userVersion);
	}

	@Override
	public List<Category> getNewCategories(int userVersion) {
		return categoryRepository.getNewCategories(userVersion);
	}

	@Override
	public List<Lesson> getNewLessons(int userVersion) {
		return lessonRepository.getNewLessons(userVersion);
	}

	@Override
	public int countVersion() {
		return (int) versionRepository.count();
	}

	@Override
	public Version getVersionById(int versionId) {
		return versionRepository.findOne(versionId);
	}
	
	@Override
	public Version getCurrentVersion() {
		return versionRepository.getCurrentVersion();
	}
	
	@Override
	public ResponseData getNewData(int userVersion) {
		List<Grade> grades = gradeRepository.getNewGrades(userVersion);
		List<Division> divisions = divisionRepository.getNewDivisions(userVersion);
		List<Category> categories = categoryRepository.getNewCategories(userVersion);
		List<Lesson> lessons = lessonRepository.getNewLessons(userVersion);
		List<Mathform> mathforms = mathFormRepository.getNewMathforms(userVersion);
		List<Exercises> exercises  = exercisesRepository.getNewExercises(userVersion);
		List<Question> questions = questionRepository.getNewQuestions(userVersion);
		List<QuestionChoices> choices = questionChoicesRepository.getNewQuestionChoices(userVersion);
		List<QuestionLevel> levels = questionLevelRepository.getNewLevels(userVersion);
		ResponseData data = new ResponseData(
				grades, divisions, categories, lessons, mathforms, exercises, questions, 
				choices, levels
		);
		return data;
	}
}
