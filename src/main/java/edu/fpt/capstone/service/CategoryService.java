package edu.fpt.capstone.service;

import java.util.List;

import edu.fpt.capstone.entity.Category;
import edu.fpt.capstone.entity.Division;

public interface CategoryService {
	
	public List<Category> getCategoriesByDivision(Division division);
	
	public Category getCategoryById(int id);
}
