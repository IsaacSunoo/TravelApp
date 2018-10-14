package com.skilldistillery.travelapp.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.travelapp.entities.Comment;
import com.skilldistillery.travelapp.entities.Posts;
import com.skilldistillery.travelapp.repositories.CommentRepository;
import com.skilldistillery.travelapp.repositories.PostsRepository;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentRepository commentRepo;

	@Autowired
	private PostsRepository postRepo;

	// CREATE

	// *pid* in this case is the profile id of who is making the comment
	@Override
	public Comment create(Integer pid, Integer postId, Comment comment) {

		String content = comment.getContent();

		// Get the post associated with the comment with the comments loaded
		Posts managedPostWithCommentsLoaded = postRepo
				.queryForPostByIdWithCommentsLoaded(postId);

		if (managedPostWithCommentsLoaded == null) {
			managedPostWithCommentsLoaded = postRepo.findById(postId).get();
			if (managedPostWithCommentsLoaded == null) {
				return null;
			}
		}

		// Create a new comment with the contents from form
		Comment newComment = new Comment();
		newComment.setProfId(pid);
		newComment.setContent(content);
		newComment.setPost(managedPostWithCommentsLoaded);

		// Add the comment to the post and save and flush that
		managedPostWithCommentsLoaded.addComment(newComment);
		commentRepo.saveAndFlush(newComment);

		return newComment;
	}

	// READ

	// Get comments for a particular post
	
	// UPDATE

	// DELETE

}
