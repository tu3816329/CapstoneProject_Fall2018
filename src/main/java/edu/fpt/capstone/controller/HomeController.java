package edu.fpt.capstone.controller;

import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import edu.fpt.capstone.entity.Category;
import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.entity.FormulaDetail;
import edu.fpt.capstone.service.CategoryService;
import edu.fpt.capstone.service.DivisionService;
import edu.fpt.capstone.service.FormulaDetailService;

/**
 * Handles requests for the application home page.
 */
@Controller
@SessionAttributes(value = {"INPUT"})
public class HomeController {
	
	@Autowired
	DivisionService divisionService;
	
	@Autowired
	CategoryService categoryService;
	
	@Autowired
	FormulaDetailService formulaDetailService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		List<Division> divisions = divisionService.getAllDivisions();
		model.addAttribute("DIVISIONS", divisions);
		return "home";
	}
	
	@RequestMapping(value = "get-iframe-content", method = RequestMethod.POST)
	public String getFrameContent(@RequestBody String data, RedirectAttributes redirectAttributes) {
		JsonParser parser = new JsonParser();
		JsonObject jsonObject = (JsonObject) parser.parse(data);
		data = jsonObject.get("data").getAsString();
		redirectAttributes.addFlashAttribute("INPUT", data);
		return "redirect:showFormula";
	}
	
	@RequestMapping(value = "showFormula", method = RequestMethod.GET)
	public String displayFormula(@ModelAttribute("INPUT") String input, Model model) {
		logger.info("input: {}", input);
		model.addAttribute("INPUT", input);
		return "formula_frame";
	}
	
	@RequestMapping(value = "get-categories-by-division", method = RequestMethod.GET)
	@ResponseBody
	public String getCategoriesByDivision(@RequestParam("divId") int divId) {
		JsonObject jsonObject = new JsonObject();
		Division division = divisionService.getDivisionById(divId);
		List<Category> categories = categoryService.getCategoriesByDivision(division);
		jsonObject.addProperty("categories", new Gson().toJson(categories));
		return jsonObject.toString();
	}
	
	@RequestMapping(value = "save-formula", method = RequestMethod.POST)
	@ResponseBody
	public String saveFormula(@RequestParam("catId") int categoryId, 
								@RequestBody FormulaDetail formulaDetail) {
		JsonObject jsonObject = new JsonObject();
		Category category = categoryService.getCategoryById(categoryId);
		formulaDetail.setCategoryId(category);
		formulaDetailService.saveFormula(formulaDetail);
		return jsonObject.toString();
	}
}
