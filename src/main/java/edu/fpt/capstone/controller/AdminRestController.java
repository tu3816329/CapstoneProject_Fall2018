package edu.fpt.capstone.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import edu.fpt.capstone.entity.Category;
import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.entity.FormulaDetail;
import edu.fpt.capstone.service.MathFormulasAdminService;

@RestController
public class AdminRestController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminRestController.class);
	
	@Autowired
	MathFormulasAdminService mathFormulasAdminService;
	
	@RequestMapping(value = "get-divisions", method = RequestMethod.GET)
	@ResponseBody
	public List<Division> getAllDivision() {
		return mathFormulasAdminService.getAllDivisions();
	}
	
	@RequestMapping(value = "get-categories-by-division", method = RequestMethod.GET)
	@ResponseBody
	public List<Category> getCategoriesByDivision(@RequestParam("divId") int divId) {
		Division division = mathFormulasAdminService.getDivisionById(divId);
		List<Category> categories = mathFormulasAdminService.getCategoriesByDivision(division);
		return categories;
	}
	
	@RequestMapping(value = "get-formulas-by-category", method = RequestMethod.GET)
	@ResponseBody
	public List<FormulaDetail> getFormulasByCategory(@RequestParam("categoryId") int categoryId) {
		Category category = mathFormulasAdminService.getCategoryById(categoryId);
		List<FormulaDetail> formulas = mathFormulasAdminService.getFormulasByCategory(category);
		return formulas;
	}
	
	@RequestMapping(value = "get-formula-by-id", method = RequestMethod.GET, produces="application/json;charset=UTF-8")
	@ResponseBody
	public FormulaDetail getFormulaById(@RequestParam("formulaId") int id) {
		FormulaDetail formula = mathFormulasAdminService.getFormulaById(id);
		return formula;
	}
	
	@RequestMapping(value = "save-formula", method = RequestMethod.POST)
	@ResponseBody
	public String saveFormula(@RequestParam("catId") int categoryId, 
								@RequestBody FormulaDetail formulaDetail) {
		JsonObject jsonObject = new JsonObject();
		try {
			Category category = mathFormulasAdminService.getCategoryById(categoryId);
			formulaDetail.setCategoryId(category);
			mathFormulasAdminService.saveFormula(formulaDetail);
			jsonObject.addProperty("status", "success");
		} catch (Exception e) {
			logger.error(e.getMessage());
			jsonObject.addProperty("status", "error");
		}
		return jsonObject.toString();
	}
}
