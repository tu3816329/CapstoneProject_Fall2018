package edu.fpt.capstone.serviceimpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.fpt.capstone.entity.DeleteQuery;
import edu.fpt.capstone.repository.DeleteQueryRepository;
import edu.fpt.capstone.service.DeleteQueryService;

@Service
public class DeleteQueryServiceImpl implements DeleteQueryService {

	@Autowired
	DeleteQueryRepository repository;
	
	@Override
	public void saveDeleteQuery(DeleteQuery query) {
		repository.save(query);
	}

}
