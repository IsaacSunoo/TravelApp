package com.skilldistillery.travelapp.tests;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.skilldistillery.travelapp.entities.Trip;

public class TripTests {

	private EntityManagerFactory emf;
	private EntityManager em;
	private Trip trip;

	@BeforeEach
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("travelapp");
		em = emf.createEntityManager();
		trip = em.find(Trip.class, 1);
	}

	@AfterEach
	public void tearDown() throws Exception {
		em.close();
		emf.close();
	}

	@Test
	public void test_test_mappings() {
	}

}
