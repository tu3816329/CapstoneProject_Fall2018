package edu.fpt.capstone.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.repository.DivisionRepository;
import edu.fpt.capstone.service.DivisionService;

@Service
@Transactional
public class DivisionServiceImpl implements DivisionService {

	@Autowired
	DivisionRepository divisionRepository;
	
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
	
}
