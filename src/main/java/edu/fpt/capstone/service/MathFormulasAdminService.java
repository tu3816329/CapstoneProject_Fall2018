package edu.fpt.capstone.service;

import java.util.List;

import edu.fpt.capstone.entity.Category;
import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.entity.FormulaDetail;

public interface MathFormulasAdminService {
	
	public List<Division> getAllDivisions();
	
	public Division getDivisionById(int id);
	
	public List<Category> getCategoriesByDivision(Division division);
	
	public Category getCategoryById(int id);
	
	public void saveFormula(FormulaDetail formula);
	
	public List<FormulaDetail> getFormulasByCategory(Category category);
	
	public FormulaDetail getFormulaById(int id);
}
