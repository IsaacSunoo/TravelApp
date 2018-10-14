package com.skilldistillery.travelapp.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.travelapp.entities.Profile;
import com.skilldistillery.travelapp.entities.Trip;

public interface TripRepository extends JpaRepository<Trip, Integer> {
	
	@Query("SELECT t from Trip t WHERE t.profile.id = :id")
	List<Trip> queryForTripsByProfileId(@Param("id") Integer pid);
	
	@Query("SELECT t from Trip t WHERE t.title LIKE :keyword")
	List<Trip> queryForTripByKeyword(@Param("keyword") String keyword);
	
	@Query("SELECT p from Profile p JOIN FETCH p.trips WHERE p.id = :id ")
	Profile queryForProfileWithTrips(@Param("id") Integer id);
	
}
