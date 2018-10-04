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
import com.skilldistillery.travelapp.entities.Trip;

class DestinationTests {
	
	private Destination d;

	EntityManagerFactory emf;
	EntityManager em;
	
	@BeforeEach
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("travelapp");
		em = emf.createEntityManager();
		d = em.find(Destination.class, 1);
	}
	
	
	@AfterEach
	public void tearDown() throws Exception {
		em.close();
		emf.close();
	}
	
	@Test
	@DisplayName ("Test Destination entity mapping")
	void test_destination_entity() {
		assertEquals("Barcelona", d.getCity());
	}
	
	@Test
	@DisplayName("Test Destination to if it is mapped to trips")
	void test_destination_to_trips() {
		assertEquals("Fun Times in Barcelona", d.getTrips().get(0).getTitle());
		
	}
}
