package com.skilldistillery.travelapp.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.travelapp.entities.Destination;

public interface DestinationRepository
		extends JpaRepository<Destination, Integer> {

	public List<Destination> findByCityAndStateAndCountry(String city,
			String state, String country);

}
