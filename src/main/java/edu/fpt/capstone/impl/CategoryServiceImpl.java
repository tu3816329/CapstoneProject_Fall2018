package edu.fpt.capstone.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.entity.Category;
import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.repository.CategoryRepository;
import edu.fpt.capstone.service.CategoryService;

@Service
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	CategoryRepository categoryRepository;
	
	@Override
	public List<Category> getCategoriesByDivision(Division division) {
		List<Category> categories = categoryRepository.findByDivisionId(division);
		return categories;
	}

	@Override
	public Category getCategoryById(int id) {
		return categoryRepository.findOne(id);
	}

}
