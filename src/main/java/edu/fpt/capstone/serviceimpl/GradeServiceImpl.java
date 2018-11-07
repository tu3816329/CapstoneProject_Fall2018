package edu.fpt.capstone.serviceimpl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.entity.Grade;
import edu.fpt.capstone.repository.GradeRepository;
import edu.fpt.capstone.service.GradeService;

@Service
public class GradeServiceImpl implements GradeService {

	@Autowired
	GradeRepository gradeRepository;
	
	@Override
	public List<Grade> getAllGrades() {
		Iterator<Grade> dIterator = gradeRepository.findAll().iterator();
		List<Grade> grades = new ArrayList<Grade>();
		for (Grade grade; dIterator.hasNext();) {
			grade = dIterator.next();
			grades.add(grade);
		}
		return grades;
	}
}
