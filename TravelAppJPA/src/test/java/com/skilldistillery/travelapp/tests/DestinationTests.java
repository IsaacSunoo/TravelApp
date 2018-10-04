package com.skilldistillery.travelapp.tests;

import static org.junit.jupiter.api.Assertions.assertEquals;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import com.skilldistillery.travelapp.entities.Comment;
import com.skilldistillery.travelapp.entities.Destination;

class DestinationTests {

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
	@DisplayName ("Test Destination entity mapping")
	void test_destination_entity() {
		Destination d = em.find(Destination.class, 1);
		assertEquals("Barcelona", d.getCity());
	}
	
	@Test
	@DisplayName ("Test Destination entity mapping")
	void test_destination_entity2() {
		Destination d = em.find(Destination.class, 8);
		assertEquals("Rome", d.getCity());
	}
}
