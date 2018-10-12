package com.skilldistillery.travelapp.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.travelapp.entities.Profile;

public interface ProfileRepository extends JpaRepository<Profile, Integer> {

	@Query("SELECT p FROM Profile p JOIN FETCH p.favoriteTrips WHERE p.id = :id")
	public Profile queryForFavoriteTripsByProfileId(@Param("id") Integer pid);
	
	
	
	
}
