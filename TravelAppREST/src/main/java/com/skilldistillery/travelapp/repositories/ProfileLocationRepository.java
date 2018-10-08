package com.skilldistillery.travelapp.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.travelapp.entities.ProfileLocation;

public interface ProfileLocationRepository
		extends JpaRepository<ProfileLocation, Integer> {

	public List<ProfileLocation> findByCityAndStateAndCountry(String city,
			String state, String country);

}
