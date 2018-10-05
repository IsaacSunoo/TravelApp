package com.skilldistillery.travelapp.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.skilldistillery.travelapp.entities.User;
import com.skilldistillery.travelapp.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepo;

	@Override
	public User register(String json) {

		ObjectMapper om = new ObjectMapper();
		User user = null;

		try {

			user = om.readValue(json, User.class);

			// Come back to security later
//			String encodedPW = encoder.encode(user.getPassword());
//			user.setPassword(encodedPW);

			// This will have to change to the above technique when we add security
			user.setPassword(user.getPassword());
			user.setActive(true);
			user.setRole("standard");
			userRepo.saveAndFlush(user);

		} catch (Exception e) {

			System.out.println(e);

		}

		return user;
	}

}
