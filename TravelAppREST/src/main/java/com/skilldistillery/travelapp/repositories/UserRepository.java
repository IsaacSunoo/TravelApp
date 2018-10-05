package com.skilldistillery.travelapp.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.travelapp.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {

	@Query("SELECT p.user FROM Profile p WHERE p.id = :id")
	User queryForUserByProfileId(@Param("id") Integer id);

}
