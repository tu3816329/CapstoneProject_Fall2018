package edu.fpt.capstone.service;

import java.util.List;

import edu.fpt.capstone.entity.Division;

public interface DivisionService {

	public List<Division> getAllDivisions();
	
	public Division getDivisionById(int id);
	
}
