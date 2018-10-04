package com.skilldistillery.travelapp.tests;

import static org.junit.jupiter.api.Assertions.assertEquals;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import com.skilldistillery.travelapp.entities.Destination;
import com.skilldistillery.travelapp.entities.Posts;

class PostsTests {

	EntityManagerFactory emf;
	EntityManager em;
	
	@BeforeEach
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("travelapp");
		em = emf.createEntityManager();
	}
	
	
	@AfterEach
	public void tearDown() throws Exception {
		em.close();
		emf.close();
	}
	
	@Test
	@DisplayName ("Test posts entity mapping")
	void test_posts_entity() {
		Posts p = em.find(Posts.class, 1);
		assertEquals("<iframe src=\"https://www.thebrokebackpacker.com/backpacking-barcelona-travel-guide/\" width=\"200\" height=\"200\">\n" + 
				"</iframe>", p.getMessage());
		
	}


}
