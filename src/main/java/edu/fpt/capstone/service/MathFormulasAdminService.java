package edu.fpt.capstone.service;

import java.util.List;

import edu.fpt.capstone.data.MathFormTable;
import edu.fpt.capstone.data.QuestionAnswer;
import edu.fpt.capstone.data.Quizes;
import edu.fpt.capstone.entity.Category;
import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.entity.Exercises;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Grade;
import edu.fpt.capstone.entity.Mathform;
import edu.fpt.capstone.entity.Question;
import edu.fpt.capstone.entity.QuestionChoices;
import edu.fpt.capstone.entity.Version;

public interface MathFormulasAdminService {
	
	public List<Grade> getAllGrades();
	
	public List<Division> getAllDivisions();
	
	public List<Category> getAllCategories();
	
	public Division getDivisionById(int id);
	
	public List<Category> getCategoriesByDivision(Division division);
	
	public Category getCategoryById(int id);
	
	public boolean isEqualCategory(Category oldCategory, Category newCategory);
	
	public void saveCategories(List<Category> categories);
	
	public void saveLesson(Lesson lesson);
	
	public List<Lesson> getLessonsByCategory(Category category);
	
	public Lesson getLessonById(int id);
	
	public Mathform getMathformById(int mathformId);
	
	public void saveMathform(Mathform mathform);
	
	public List<MathFormTable> getMathformTableDataByLesson(Lesson lesson);
	
	public Exercises getExerciseById(int exerciseId);
	
	public List<Exercises> getExercisesByMathForm(Mathform mathform);
	
	public void saveExercise(Exercises exercise);
	
	public List<Quizes> getQuizesData(int categoryId);
	
	public List<Question> getQuestionsByCategory(int categoryId);
	
	public List<QuestionChoices> getQuestionChoicesByQuestion(Question question);
	
	public void saveQuizQuestion(QuestionAnswer qa);
	
	public void deleteQuizQuestion(int questionId);
	
	public List<QuestionAnswer> getQuizQuestionsByCategory(int categoryId);
	
	public QuestionAnswer getQuizQuestionByQuestionId(int questionId);
	
	public List<Version> getAllVersion();
	
	public Version getVersionById(int versionId);
	
	public Version addVersion(Version version);
	
	public void updateDataDbVersion(int latestVersionId);
	
	public Version getCurrentVersion();
	
	//check if admin version is different from user version
	public List<Version> getNewVersions(int userVersion);
	
	//return new data to android request 
	public List<Division> getNewDivisions(int userVersion);
	
	public List<Category> getNewCategories(int userVersion);
	
	public List<Lesson> getNewLessons(int userVersion);
		
	public int countVersion();
}
