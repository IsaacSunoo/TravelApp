package com.skilldistillery.travelapp.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.travelapp.entities.Posts;
import com.skilldistillery.travelapp.repositories.PostsRepository;

@Service
public class PostServiceImpl implements PostService {
	
	@Autowired
	private PostsRepository postRepo;
	
	// READ ************************************************************
	
	@Override
	public List<Posts> index() {
		return postRepo.findAll();
	}
	
	@Override
	public Posts show(Integer id) {
		Optional<Posts> post = postRepo.findById(id);
		
		if(post.isPresent()) {
			return post.get();
		}
		
		return null;
	}
	
	// CREATE ***********************************************************
	
	@Override 
	public Posts create(Posts post) {
		return postRepo.saveAndFlush(post);
	}
	
	
	// DELETE ***********************************************************
	
	@Override
	public Boolean delete(Integer id) {
		
		try {
			postRepo.deleteById(id);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	
	

}
