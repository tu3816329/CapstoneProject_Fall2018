package edu.fpt.capstone.serviceimpl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.entity.Division;
import edu.fpt.capstone.repository.DivisionRepository;
import edu.fpt.capstone.service.DivisionService;

@Service
public class DivisionServiceImpl implements DivisionService {
	
	@Autowired
	DivisionRepository divisionRepository;
	
	@Override
	public List<Division> getAllDivisions() {
		Iterator<Division> dIterator = divisionRepository.findAll().iterator();
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
