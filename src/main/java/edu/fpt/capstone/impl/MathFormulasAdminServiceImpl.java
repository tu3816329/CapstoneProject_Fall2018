package edu.fpt.capstone.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.entity.Category;
import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.entity.FormulaDetail;
import edu.fpt.capstone.repository.CategoryRepository;
import edu.fpt.capstone.repository.DivisionRepository;
import edu.fpt.capstone.repository.FormulaDetailRepository;
import edu.fpt.capstone.service.MathFormulasAdminService;

@Service
public class MathFormulasAdminServiceImpl implements MathFormulasAdminService {

	@Autowired
	DivisionRepository divisionRepository;
	@Autowired
	CategoryRepository categoryRepository;
	@Autowired
	FormulaDetailRepository formulaDetailRepository;
	
	@Override
	public List<Division> getAllDivisions() {
		Iterable<Division> dIterable = divisionRepository.findAll();
		Iterator<Division> dIterator = dIterable.iterator();
		List<Division> divisions = new ArrayList<Division>();
		for (Division division; dIterator.hasNext();) {
			division = dIterator.next();
			divisions.add(division);
		}
		return divisions;
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
	public void saveFormula(FormulaDetail formula) {
		formulaDetailRepository.save(formula);
	}

	@Override
	public List<FormulaDetail> getFormulasByCategory(Category category) {
		List<FormulaDetail> formulas = formulaDetailRepository.findByCategoryId(category);
		return formulas;
	}

	@Override
	public FormulaDetail getFormulaById(int id) {
		return formulaDetailRepository.findOne(id);
	}
}
