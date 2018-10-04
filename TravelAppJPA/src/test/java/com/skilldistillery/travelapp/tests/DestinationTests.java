package com.skilldistillery.travelapp.tests;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;

class DestinationTests {

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
}
