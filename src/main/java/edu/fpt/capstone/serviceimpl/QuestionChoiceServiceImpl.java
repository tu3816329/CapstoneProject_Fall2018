package edu.fpt.capstone.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.entity.Question;
import edu.fpt.capstone.entity.QuestionChoice;
import edu.fpt.capstone.repository.QuestionChoiceRepository;
import edu.fpt.capstone.service.QuestionChoiceService;

@Service
public class QuestionChoiceServiceImpl implements QuestionChoiceService {

	@Autowired
	QuestionChoiceRepository questionChoiceRepository;
	
	@Override
	public List<QuestionChoice> getQuestionChoicesByQuestion(Question question) {
		return questionChoiceRepository.findByQuestionId(question);
	}

	@Override
	public void saveQuestionChoice(QuestionChoice choice) {
		questionChoiceRepository.save(choice);
	}

	@Override
	public void deleteQuestionChoice(QuestionChoice choice) {
		questionChoiceRepository.delete(choice.getId());
	}
}
