package com.skilldistillery.travelapp.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.travelapp.entities.Comment;

public interface CommentRepository extends JpaRepository<Comment, Integer> {

}
