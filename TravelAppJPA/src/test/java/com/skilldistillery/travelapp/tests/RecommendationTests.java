package com.skilldistillery.travelapp.tests;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.skilldistillery.travelapp.entities.Recommendation;

public class RecommendationTests {

	private EntityManagerFactory emf;
	private EntityManager em;
	private Recommendation recommendation;

	@BeforeEach
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("travelapp");
		em = emf.createEntityManager();
		recommendation = em.find(Recommendation.class, 1);
	}

	@AfterEach
	public void tearDown() throws Exception {
		em.close();
		emf.close();
	}

	@Test
	public void test_recommendation_mappings() {
	}

	@Test
	public void test_recommendation_recType_association() {
	}

	@Test
	public void test_recommendation_trip_association() {
	}

}
