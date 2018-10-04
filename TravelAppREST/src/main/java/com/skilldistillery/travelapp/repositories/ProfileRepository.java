package com.skilldistillery.travelapp.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.travelapp.entities.Profile;

public interface ProfileRepository extends JpaRepository<Profile, Integer> {

}
