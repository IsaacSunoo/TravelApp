package com.skilldistillery.travelapp.tests;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

class PostsTests {

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
	@DisplayName ("Test posts entity mapping")
	void test_posts_entity() {
		
	}


}
