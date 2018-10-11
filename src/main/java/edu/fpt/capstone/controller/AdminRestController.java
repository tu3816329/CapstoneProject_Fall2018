package edu.fpt.capstone.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import edu.fpt.capstone.data.MathFormTable;
import edu.fpt.capstone.entity.Category;
import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.entity.Exercises;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Grade;
import edu.fpt.capstone.entity.Mathform;
import edu.fpt.capstone.entity.Version;
import edu.fpt.capstone.service.MathFormulasAdminService;

@RestController
public class AdminRestController {
	
//	private static final Logger logger = LoggerFactory.getLogger(AdminRestController.class);
	
	@Autowired
	MathFormulasAdminService mathFormulasAdminService;
	
	@RequestMapping(value = "check-database-version", method = RequestMethod.GET)
	@ResponseBody
	public List<Version> returnNewVersions(@RequestParam("currentVersion") int userCurrentVersion) {
		return mathFormulasAdminService.getNewVersions(userCurrentVersion);
	}
	
	@RequestMapping(value = "get-new-divisions", method = RequestMethod.GET)
	@ResponseBody
	public List<Division> returnNewDivisions(@RequestParam("currentVersion") int userCurrentVersion) {
		return mathFormulasAdminService.getNewDivisions(userCurrentVersion);
	}
	
	@RequestMapping(value = "get-new-categories", method = RequestMethod.GET)
	@ResponseBody
	public List<Category> returnNewCategories(@RequestParam("currentVersion") int userCurrentVersion) {
		return mathFormulasAdminService.getNewCategories(userCurrentVersion);
	}
	
	@RequestMapping(value = "get-new-lessons", method = RequestMethod.GET)
	@ResponseBody
	public List<Lesson> returnNewFormulas(@RequestParam("currentVersion") int userCurrentVersion) {
		return mathFormulasAdminService.getNewLessons(userCurrentVersion);
	}
	
	@RequestMapping(value = "get-grades", method = RequestMethod.GET)
	@ResponseBody
	public List<Grade> getAllGrades() {
		return mathFormulasAdminService.getAllGrades();
	}
	
	@RequestMapping(value = "get-divisions", method = RequestMethod.GET)
	@ResponseBody
	public List<Division> getAllDivision() {
		return mathFormulasAdminService.getAllDivisions();
	}
	
	@RequestMapping(value = "load-categories-table", method = RequestMethod.GET)
	@ResponseBody
	public List<Category> getAllCategories() {
		return mathFormulasAdminService.getAllCategories();
	}
	
	@RequestMapping(value = "save-categories-table", method = RequestMethod.POST)
	@ResponseBody
	public boolean saveCategories(@RequestBody List<Category> categories) {
		boolean isSuccess = true;
		try {
			mathFormulasAdminService.saveCategories(categories);
		} catch (Exception e) {
			e.printStackTrace();
			isSuccess = false;
		}
		return isSuccess;
	}
	
	@RequestMapping(value = "get-categories-by-division", method = RequestMethod.GET)
	@ResponseBody
	public List<Category> getCategoriesByDivision(@RequestParam("divId") int divId) {
		Division division = mathFormulasAdminService.getDivisionById(divId);
		List<Category> categories = mathFormulasAdminService.getCategoriesByDivision(division);
		return categories;
	}
	
	@RequestMapping(value = "get-lessons-by-category", method = RequestMethod.GET)
	@ResponseBody
	public List<Lesson> getFormulasByCategory(@RequestParam("categoryId") int categoryId) {
		Category category = mathFormulasAdminService.getCategoryById(categoryId);
		List<Lesson> lessons = mathFormulasAdminService.getLessonsByCategory(category);
		return lessons;
	}
	
	@RequestMapping(value = "get-formula-by-id", method = RequestMethod.GET, produces="application/json;charset=UTF-8")
	@ResponseBody
	public Lesson getFormulaById(@RequestParam("lessonId") int id) {
		Lesson lesson = mathFormulasAdminService.getLessonById(id);
		return lesson;
	}
	
	@RequestMapping(value = "load-mathforms-table", method = RequestMethod.GET)
	@ResponseBody
	public List<MathFormTable> loadMathformsTable(@RequestParam("lessonId") int lessonId) {
		Lesson lesson = mathFormulasAdminService.getLessonById(lessonId);
		List<MathFormTable> data = 
				mathFormulasAdminService.getMathformTableDataByLesson(lesson);
		return data;
	}
	
	@RequestMapping(value = "get-exercises-by-mathform", method = RequestMethod.GET)
	@ResponseBody
	public List<Exercises> getMathformData(@RequestParam("mathformId") int mathformId) {
		Mathform mathform = mathFormulasAdminService.getMathformById(mathformId);
		List<Exercises> exercises = mathFormulasAdminService.getExercisesByMathForm(mathform);
		return exercises;
	}
	
	@RequestMapping(value = "load-versions-table", method = RequestMethod.GET)
	@ResponseBody
	public List<Version> loadVersionsTable() {
		return mathFormulasAdminService.getAllVersion();
	}
}
