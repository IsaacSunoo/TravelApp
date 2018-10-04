package com.skilldistillery.travelapp.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.travelapp.entities.RecType;

public interface RecTypeRepository extends JpaRepository<RecType, Integer> {

}
