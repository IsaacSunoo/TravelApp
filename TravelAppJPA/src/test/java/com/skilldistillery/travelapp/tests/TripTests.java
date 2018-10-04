package com.skilldistillery.travelapp.tests;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.skilldistillery.travelapp.entities.Profile;
import com.skilldistillery.travelapp.entities.Recommendation;
import com.skilldistillery.travelapp.entities.Tag;
import com.skilldistillery.travelapp.entities.Trip;

public class TripTests {

	private EntityManagerFactory emf;
	private EntityManager em;
	private Trip trip;
	private Profile p;
	private Tag t;
	private Recommendation r;

	@BeforeEach
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("travelapp");
		em = emf.createEntityManager();
		trip = em.find(Trip.class, 1);
		p = trip.getProfiles().get(0);
		t = trip.getTags().get(0);
		r = trip.getRecommendations().get(0);
	}

	@AfterEach
	public void tearDown() throws Exception {
		em.close();
		emf.close();
	}

	@Test
	public void test_trip_mappings() {
		assertEquals("Fun Times in Barcelona", trip.getTitle());
	}

	@Test
	public void test_trip_profile_association() {
		assertEquals("James", trip.getProfile().getFirstName());
	}

	@Test
	public void test_trip_profiles_association() {
		assertEquals("Walberg", trip.getProfiles().get(0).getLastName());
	}

	@Test
	public void test_removeProfile_binding() {
		trip.removeProfile(p);
		assertFalse(trip.getProfiles().contains(p));
	}

	@Test
	public void test_addProfile_binding() {
		trip.addProfile(p);
		assertTrue(trip.getProfiles().contains(p));
	}

	@Test
	public void test_trip_tags_association() {
		assertEquals("backpacking", trip.getTags().get(0).getName());
	}

	@Test
	public void test_trip_removeTag_binding() {
		trip.removeTag(t);
		assertFalse(trip.getTags().contains(t));
	}

	@Test
	public void test_trip_addTag_binding() {
		trip.addTag(t);
		assertTrue(trip.getTags().contains(t));
	}

	@Test
	public void test_trip_recommendations_association() {
		assertEquals("warning",
				trip.getRecommendations().get(0).getRecType().getName());
	}

	@Test
	public void test_removeRecommendation_binding() {
		trip.removeRecommendation(r);
		assertFalse(trip.getRecommendations().contains(r));
	}

	@Test
	public void test_addRecommendation_binding() {
		trip.addRecommendation(r);
		assertTrue(trip.getRecommendations().contains(r));
	}

	@Test
	public void test_trip_posts_association() {
		assertEquals("James", trip.getPosts().getProfile().getFirstName());
	}

	@Test
	public void test_trip_destination_association() {
		assertEquals("Barcelona", trip.getDestination().getCity());
	}
}
