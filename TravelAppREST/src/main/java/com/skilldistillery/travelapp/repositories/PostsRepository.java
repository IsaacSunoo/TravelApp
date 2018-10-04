package com.skilldistillery.travelapp.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.travelapp.entities.Posts;

public interface PostsRepository extends JpaRepository<Posts, Integer> {

}
