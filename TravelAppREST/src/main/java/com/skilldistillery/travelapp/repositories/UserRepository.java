package com.skilldistillery.travelapp.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.travelapp.entities.Profile;
import com.skilldistillery.travelapp.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {

	@Query("SELECT p.user FROM Profile p WHERE p.id = :id")
	User queryForUserByProfileId(@Param("id") Integer id);

	User findOneUserByName(String username);
	
	@Query("SELECT u FROM User u JOIN FETCH u.followers WHERE u.id = :id")
	User queryForFollowersByUserId(@Param("id") Integer id);
	
	@Query("SELECT u FROM User u WHERE u.name LIKE :keyword OR u.profile.firstName LIKE :keyword OR u.profile.lastName LIKE :keyword")
	List <User> queryForUsersByKeyword(@Param("keyword") String keyword);
	
	@Query("SELECT p FROM Profile p WHERE p.firstName LIKE :keyword OR p.lastName LIKE :keyword")
	List<Profile> queryForProfilesByKeyword(@Param("keyword") String keyword);
	
}
