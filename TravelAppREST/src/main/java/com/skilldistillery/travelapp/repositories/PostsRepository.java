package com.skilldistillery.travelapp.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.travelapp.entities.Posts;

public interface PostsRepository extends JpaRepository<Posts, Integer> {
	
	@Query("SELECT p from Posts p WHERE p.profile.id = :pid")
	List<Posts> queryAllPostsForOneProfile (@Param("pid") Integer pid);

}
