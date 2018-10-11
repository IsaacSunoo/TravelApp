package com.skilldistillery.travelapp.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.travelapp.entities.Trip;

public interface TripRepository extends JpaRepository<Trip, Integer> {
	
	@Query("SELECT t from Trip t WHERE t.profile.id = :id")
	List<Trip> queryForTripsByProfileId(@Param("id") Integer pid);
	

}
