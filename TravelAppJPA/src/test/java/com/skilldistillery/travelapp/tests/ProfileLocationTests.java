package com.skilldistillery.travelapp.tests;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import com.skilldistillery.travelapp.entities.Profile;
import com.skilldistillery.travelapp.entities.ProfileLocation;

class ProfileLocationTests {

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
	@DisplayName ("Test profileLocation entity mapping")
	void test_profileLocation_entity() {
		ProfileLocation pl = em.find(ProfileLocation.class, 1);
		assertEquals("Denver", pl.getCity());
		assertEquals("CO", pl.getState());
		
	}
	
	@Test
	public void test_mappings_to_profile() {
		ProfileLocation pl = em.find(ProfileLocation.class, 1);
		assertEquals(1, pl.getProfiles().size());
		
	}
	
	@Test
	public void test_addProfile_method() {
		ProfileLocation pl = em.find(ProfileLocation.class, 1);
		Profile p = pl.getProfiles().get(0);
		pl.addProfile(p);
		assertTrue(pl.getProfiles().contains(p));
		
	}
	
	@Test
	public void test_removeProfile_method() {
		ProfileLocation pl = em.find(ProfileLocation.class, 1);
		Profile p = pl.getProfiles().get(0);
		pl.removeProfile(p);
		assertFalse(pl.getProfiles().contains(p));
		
	}
	

}
