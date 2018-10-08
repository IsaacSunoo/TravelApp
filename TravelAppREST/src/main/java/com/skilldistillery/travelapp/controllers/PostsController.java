package com.skilldistillery.travelapp.controllers;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.travelapp.entities.Posts;
import com.skilldistillery.travelapp.services.PostService;

@RestController
@RequestMapping("api")
@CrossOrigin({ "*", "http://localhost:4201" })
public class PostsController {
	
	@Autowired
	private PostService postService;
	
	@RequestMapping(path="/posts", method = RequestMethod.GET)
	public List<Posts> index() {
		return postService.index();
	}
	
	@RequestMapping(path="/posts", method = RequestMethod.POST)
	public Posts createPost(@RequestBody Posts post, HttpServletResponse res) {
		Posts p = postService.create(post);
		
		if (p == null) {
			res.setStatus(500);
		}
		else {
			res.setStatus(201);
		}
		return p;
	}

}
