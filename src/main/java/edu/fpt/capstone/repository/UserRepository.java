package edu.fpt.capstone.repository;

import org.springframework.data.repository.CrudRepository;

import edu.fpt.capstone.entity.User;

public interface UserRepository extends CrudRepository<User, Integer> {

}
