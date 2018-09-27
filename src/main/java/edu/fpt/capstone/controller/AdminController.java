package edu.fpt.capstone.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.service.MathFormulasAdminService;

/**
 * Handles requests for the application home page.
 */
@Controller
@SessionAttributes(value = {"INPUT"})
public class AdminController {
	
	@Autowired
	MathFormulasAdminService mathFormulasAdminService;
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		List<Division> divisions = mathFormulasAdminService.getAllDivisions();
		model.addAttribute("DIVISIONS", divisions);
		return "home";
	}
}
