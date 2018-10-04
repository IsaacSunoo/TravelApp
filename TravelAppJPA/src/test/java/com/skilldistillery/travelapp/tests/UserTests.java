package com.skilldistillery.travelapp.tests;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.skilldistillery.travelapp.entities.User;

public class UserTests {

	private EntityManagerFactory emf;
	private EntityManager em;
	private User user;

	@BeforeEach
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("travelapp");
		em = emf.createEntityManager();
		user = em.find(User.class, 1);
	}

	@AfterEach
	public void tearDown() throws Exception {
		em.close();
		emf.close();
	}

	@Test
	public void test_user_mappings() {
		assertEquals("JamesG", user.getName());
		assertEquals("password", user.getPassword());
		assertEquals("JG@wander.com", user.getEmail());
		assertEquals("standard", user.getRole());
		assertEquals(true, user.isActive());
	}

	@Test
	public void test_user_followers_mappings() {
		assertNotEquals(0, user.getFollowers().size());
	}

	@Test
	public void test_user_profile_mappings() {
		assertEquals("James", user.getProfile().getFirstName());
		assertEquals("Gill", user.getProfile().getLastName());
		assertEquals("images/UserPics/James_Gill.png", user.getProfile().getImgLink());
	}
	
	@Test
	public void test_user_addFollower_method() {
		User u = user.getFollowers().get(0);
		user.addFollower(u);
		assertTrue(user.getFollowers().contains(u));
	}
	
	@Test
	public void test_user_removeFollower_method() {
		User u = user.getFollowers().get(0);
		user.removeFollower(u);
		assertFalse(user.getFollowers().contains(u));
	}

}
