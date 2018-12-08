package edu.fpt.capstone.serviceimpl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.entity.Subject;
import edu.fpt.capstone.repository.SubjectRepository;
import edu.fpt.capstone.service.SubjectService;

@Service
public class SubjectServiceImpl implements SubjectService {
	
	@Autowired
	SubjectRepository subjectRepository;
	
	@Override
	public List<Subject> getAllSubjects() {
		Iterator<Subject> dIterator = subjectRepository.findAll().iterator();
		List<Subject> subjects = new ArrayList<Subject>();
		for (Subject subject; dIterator.hasNext();) {
			subject = dIterator.next();
			subjects.add(subject);
		}
		return subjects;
	}
	
	@Override
	public Subject getSubjectById(int id) {
		return subjectRepository.findOne(id);
	}
}
