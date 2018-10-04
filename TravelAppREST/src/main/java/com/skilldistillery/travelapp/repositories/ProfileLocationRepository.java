package com.skilldistillery.travelapp.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.travelapp.entities.ProfileLocation;

public interface ProfileLocationRepository extends JpaRepository<ProfileLocation, Integer> {

}
