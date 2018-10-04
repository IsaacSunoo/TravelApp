package com.skilldistillery.travelapp.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.travelapp.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {

}
