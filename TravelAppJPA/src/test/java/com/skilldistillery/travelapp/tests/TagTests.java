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

import com.skilldistillery.travelapp.entities.Tag;
import com.skilldistillery.travelapp.entities.Trip;

public class TagTests {

	private EntityManagerFactory emf;
	private EntityManager em;
	private Tag tag;

	@BeforeEach
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("travelapp");
		em = emf.createEntityManager();
		tag = em.find(Tag.class, 1);
	}

	@AfterEach
	public void tearDown() throws Exception {
		em.close();
		emf.close();
	}

	@Test
	public void test_tag_mappings() {
		assertEquals("backpacking", tag.getName());
	}

	@Test
	public void test_tag_trip_association() {
		Trip trip = em.find(Trip.class, 1);
		assertEquals("backpacking", trip.getTags().get(0).getName());
	}

	@Test
	public void test_tag_method_add_trip() {
		Trip trip = tag.getTrips().get(0);
		tag.addTrip(trip);
		assertTrue(tag.getTrips().contains(trip));

	}

	@Test
	public void test_tag_method_removeTrip_removes_trip_from_trip_list() {
		Trip trip = tag.getTrips().get(0);
		tag.removeTrip(trip);
		assertFalse(tag.getTrips().contains(trip));
	}

}
