package com.skilldistillery.travelapp.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.travelapp.entities.Tag;

public interface TagRepository extends JpaRepository<Tag, Integer> {

}
