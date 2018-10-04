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
import com.skilldistillery.travelapp.entities.Profile;

class ProfileTests {

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
	@DisplayName ("Test profile entity mapping")
	void test_profile_entity() {
		Profile p = em.find(Profile.class, 1);
		assertEquals("James", p.getFirstName());
		
		
	}


}
