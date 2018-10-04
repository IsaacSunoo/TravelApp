package com.skilldistillery.travelapp.tests;

import static org.junit.jupiter.api.Assertions.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.skilldistillery.travelapp.entities.RecType;

public class RecTypeTests {

	private EntityManagerFactory emf;
	private EntityManager em;
	private RecType rt;

	@BeforeEach
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("travelapp");
		em = emf.createEntityManager();
		rt = em.find(RecType.class, 1);
	}

	@AfterEach
	public void tearDown() throws Exception {
		em.close();
		emf.close();
	}

	@Test
	public void test_recType_mappings() {
		assertEquals("warning", rt.getName());
	}
	
	@Test
	public void test_recType_recommendation_association() {
		assertEquals("https://www.gov.uk/foreign-travel-advice/spain", rt.getRecommendations().get(0).getContent());
	}

}
