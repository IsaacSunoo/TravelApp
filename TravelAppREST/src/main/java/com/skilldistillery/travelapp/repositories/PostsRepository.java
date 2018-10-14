package com.skilldistillery.travelapp.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.skilldistillery.travelapp.entities.Posts;

public interface PostsRepository extends JpaRepository<Posts, Integer> {

	@Query("SELECT p from Posts p WHERE p.profile.id = :pid")
	public List<Posts> queryAllPostsForOneProfile(@Param("pid") Integer pid);

	@Query("SELECT p FROM Posts p WHERE p.profile.id = :pid AND p.trip.id = :tid")
	public Posts queryForPostByProfileAndTripId(@Param("pid") Integer pid,
			@Param("tid") Integer tid);

	@Query("SELECT p FROM Posts p JOIN FETCH p.comments WHERE p.id = :postId")
	public Posts
			queryForPostByIdWithCommentsLoaded(@Param("postId") Integer postId);
}
