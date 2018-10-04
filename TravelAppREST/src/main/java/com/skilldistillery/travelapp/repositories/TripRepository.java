package com.skilldistillery.travelapp.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.travelapp.entities.Trip;

public interface TripRepository extends JpaRepository<Trip, Integer> {

}
