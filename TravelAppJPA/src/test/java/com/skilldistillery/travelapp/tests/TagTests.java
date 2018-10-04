package com.skilldistillery.travelapp.tests;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.skilldistillery.travelapp.entities.Tag;

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
	}

	@Test
	public void test_tag_trip_association() {
	}

}
