package com.skilldistillery.travelapp.services;

import java.util.List;

import com.skilldistillery.travelapp.entities.Posts;

public interface PostService {

	List<Posts> index();

	Posts show(Integer id);

	Posts create(Posts post);

	Boolean delete(Integer id);

}
