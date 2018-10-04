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
	
	private Profile p;
	
	@BeforeEach
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("travelapp");
		em = emf.createEntityManager();
		p = em.find(Profile.class, 1);
	}
	
	
	@AfterEach
	public void tearDown() throws Exception {
		em.close();
		emf.close();
	}
	
	@Test
	@DisplayName ("Test profile entity mapping")
	void test_profile_entity() {
		assertEquals("James", p.getFirstName());
	}
	
	@Test
	@DisplayName ("Test profile entity mapping with location")
	void test_profile_location() {
		assertEquals("Denver", p.getLocation().getCity());
	}
	
	@Test
	@DisplayName ("Test profile entity mapping with posts")
	void test_profile_posts() {
		assertEquals("<iframe src=\"https://www.thebrokebackpacker.com/backpacking-barcelona-travel-guide/\" width=\"200\" height=\"200\">\n" + 
				"</iframe>", p.getPosts().get(0).getMessage());
	}
	
	@Test
	@DisplayName ("Test profile entity mapping with trips")
	void test_profile_trips() {
		assertEquals("Fun Times in Barcelona", p.getTrips().get(0).getTitle());
	}
	
	@Test
	@DisplayName ("Test profile entity mapping with user")
	void test_profile_user() {
		assertEquals("JamesG", p.getUser().getName());
	}
	
	@Test
	@DisplayName ("Test profile entity mapping with favorite trips")
	void test_profile_fav_trips() {
		assertEquals("Krakow", p.getFavoriteTrips().get(0).getDestination().getCity());
	}


}
