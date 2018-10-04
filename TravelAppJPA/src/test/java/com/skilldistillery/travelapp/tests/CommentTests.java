package com.skilldistillery.travelapp.tests;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import com.skilldistillery.travelapp.entities.Comment;

class CommentTests {
	
	private Comment c;

	EntityManagerFactory emf;
	EntityManager em;
	
	@BeforeEach
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("travelapp");
		em = emf.createEntityManager();
		c = em.find(Comment.class, 1);
	}
	
	
	@AfterEach
	public void tearDown() throws Exception {
		em.close();
		emf.close();
	}
	
	@Test
	@DisplayName ("Test comment entity mapping")
	void test_comment_entity() {
		assertEquals("Right on!", c.getContent());
	}

	@Test
	@DisplayName ("Test comment entity mapping with posts")
	void test_comment_posts() {
		assertEquals("<iframe src=\"https://www.thebrokebackpacker.com/backpacking-barcelona-travel-guide/\" width=\"200\" height=\"200\">\n" + 
				"</iframe>", c.getPost().getMessage());
	}
	

}
