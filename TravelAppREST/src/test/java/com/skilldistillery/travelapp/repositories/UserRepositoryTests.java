package com.skilldistillery.travelapp.repositories;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.skilldistillery.travelapp.entities.User;
import com.skilldistillery.travelapp.services.UserService;

@SpringBootTest
@RunWith(SpringRunner.class)
public class UserRepositoryTests {

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private UserService userService;

	@Test
	public void
			test_userService_method_register_registers_user_and_persists_to_DB() {

		System.out.println(userRepo.count());

		String json = "{\"name\": \"Test\", \"password\": \"TestPassword\","
				+ " \"email\": \"Test@Test.com\","
				+ " \"active\": \"true\", \"role\": \"standard\"}";

		User newUser = userService.register(json);

		assertEquals("Test", newUser.getName());

	}

}
