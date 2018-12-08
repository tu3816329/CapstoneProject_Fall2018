package edu.fpt.capstone.service;

import java.util.List;

import edu.fpt.capstone.entity.Subject;

public interface SubjectService {

	public List<Subject> getAllSubjects();
	
	public Subject getSubjectById(int id);
	
}
