package com.skilldistillery.travelapp.services;

import com.skilldistillery.travelapp.entities.Comment;
import com.skilldistillery.travelapp.entities.Posts;

public interface CommentService {

//	public Comment create(Integer pid, Integer postId, String content);

	public Comment create(Integer pid, Integer postId, Comment comment);

	public Posts commentIndexForPostById(Integer postId);

}
