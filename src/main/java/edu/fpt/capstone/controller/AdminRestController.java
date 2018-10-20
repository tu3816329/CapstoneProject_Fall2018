package edu.fpt.capstone.controller;

import java.io.IOException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import edu.fpt.capstone.data.MathformTable;
import edu.fpt.capstone.entity.Category;
import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.entity.Lesson;
import edu.fpt.capstone.entity.Grade;
import edu.fpt.capstone.entity.Version;
import edu.fpt.capstone.service.MathFormulasAdminService;

@RestController
public class AdminRestController {
	
	private static final Logger log = Logger.getLogger(AdminRestController.class);
	
	@Autowired
	MathFormulasAdminService mathFormulasAdminService;
	
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
	
	@RequestMapping(value = "load-mathforms-table", method = RequestMethod.GET)
	@ResponseBody
	public List<MathformTable> loadMathformsTable(@RequestParam("lessonId") int lessonId) {
		Lesson lesson = mathFormulasAdminService.getLessonById(lessonId);
		List<MathformTable> data = 
				mathFormulasAdminService.getMathformTableDataByLesson(lesson);
		return data;
	}
	
	@RequestMapping(value = "load-versions-table", method = RequestMethod.GET)
	@ResponseBody
	public List<Version> loadVersionsTable() {
		return mathFormulasAdminService.getAllVersion();
	}
	
	@RequestMapping(value = "save-category-image", method = RequestMethod.POST)
	@ResponseBody
	public String saveCategoryImage(@RequestParam("categoryId") int categoryId, 
									@RequestParam("imageFile") MultipartFile imgFile) {
		Category category = mathFormulasAdminService.getCategoryById(categoryId);
		Version noneVersion = mathFormulasAdminService.getVersionById(0);
		try {
			category.setCategoryIcon(imgFile.getBytes());
			category.setVersionId(noneVersion);
			mathFormulasAdminService.saveCategory(category);
		} catch (IOException e) {
			log.error(e.getLocalizedMessage());
			return "error";
		}
		return "success";
	}
}
