package com.skilldistillery.travelapp.tests;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import com.skilldistillery.travelapp.entities.Comment;

class CommentTests {

	EntityManagerFactory emf;
	EntityManager em;
	
	@BeforeEach
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("todoPU");
		em = emf.createEntityManager();
	}
	
	
	@AfterEach
	public void tearDown() throws Exception {
		em.close();
		emf.close();
	}
	
	@Test
	@DisplayName ("Test comment entity mapping")
	void test_comment_entity() {
		Comment comment = em.find(Comment.class, 1);
	}

}
