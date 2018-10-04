package com.skilldistillery.travelapp.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.travelapp.entities.Destination;

public interface DestinationRepository extends JpaRepository<Destination, Integer> {

}
