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
	
	private Posts p;
	
	@BeforeEach
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("travelapp");
		em = emf.createEntityManager();
		p = em.find(Posts.class, 1);
	}
	
	
	@AfterEach
	public void tearDown() throws Exception {
		em.close();
		emf.close();
	}
	
	@Test
	@DisplayName ("Test posts entity mapping")
	void test_posts_entity() {
		assertEquals("<iframe src=\"https://www.thebrokebackpacker.com/backpacking-barcelona-travel-guide/\" width=\"200\" height=\"200\">\n" + 
				"</iframe>", p.getMessage());
		
	}
	
	@Test
	@DisplayName ("Test posts entity mapping with Comments")
	void test_posts_comments() {
		assertEquals("Right on!", p.getComments().get(0).getContent());
		
	}
	
	@Test
	@DisplayName ("Test posts entity mapping with trips")
	void test_posts_trip() {
		assertEquals("Fun Times in Barcelona" , p.getTrip().getTitle());
	}
	
	@Test
	@DisplayName ("Test posts entity mapping with Profile")
	void test_posts_profile() {
		assertEquals("I like turtles and hockey.  I love trying new foods and meeting new people.  I’ve never been to Argentina but I have been to Alaska and that was fun." , p.getProfile().getBio());
	}
	
	


}
