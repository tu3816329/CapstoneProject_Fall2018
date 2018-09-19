package edu.fpt.capstone.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.entity.FormulaDetail;
import edu.fpt.capstone.repository.FormulaDetailRepository;
import edu.fpt.capstone.service.FormulaDetailService;

@Service
public class FormulaDetailServiceImpl implements FormulaDetailService {

	@Autowired
	FormulaDetailRepository formulaDetailRepository;
	
	@Override
	public void saveFormula(FormulaDetail formula) {
		formulaDetailRepository.save(formula);
	}
	
}
