package com.skilldistillery.travelapp.services;

import java.util.List;

import com.skilldistillery.travelapp.entities.NewTripPostDTO;
import com.skilldistillery.travelapp.entities.Posts;

public interface PostService {

	public List<Posts> index();

	public Posts show(Integer id);

	public Posts create(Posts post);

	public Boolean delete(Integer id);

	public Posts createTripPost(Integer id, NewTripPostDTO newTripPostDTO);

	public List<Posts> getAllPostsForOneProfile(Integer pid);

}
