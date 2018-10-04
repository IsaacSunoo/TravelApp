package com.skilldistillery.travelapp.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.travelapp.entities.Recommendation;

public interface RecommendationRepository extends JpaRepository<Recommendation, Integer> {

}
