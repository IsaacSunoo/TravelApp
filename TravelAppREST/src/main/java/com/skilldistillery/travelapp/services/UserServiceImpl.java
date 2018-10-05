package com.skilldistillery.travelapp.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.skilldistillery.travelapp.entities.Profile;
import com.skilldistillery.travelapp.entities.User;
import com.skilldistillery.travelapp.entities.UserProfileDTO;
import com.skilldistillery.travelapp.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepo;

	// CREATE

	@Override
	public User register(String json) {

		ObjectMapper om = new ObjectMapper();
		UserProfileDTO userProfileDTO = null;
		User user = new User();

		try {

			userProfileDTO = om.readValue(json, UserProfileDTO.class);
			if (userProfileDTO == null) {
				return null;
			}

			// Come back to security later
//			String encodedPW = encoder.encode(user.getPassword());
//			user.setPassword(encodedPW);

			// This will have to change to the above technique when we add security
			user.setPassword(userProfileDTO.getPassword());
			user.setName(userProfileDTO.getName());
			user.setEmail(userProfileDTO.getEmail());
			user.setActive(true);
			user.setRole("standard");

			Profile profile = new Profile();
			profile.setFirstName(userProfileDTO.getFirstName());
			profile.setLastName(userProfileDTO.getLastName());

			user.setProfile(profile);

			// Cascade PERSIST exists on the User class, so it should persist the
			// Profile and User together here
			userRepo.saveAndFlush(user);

		} catch (Exception e) {

			System.out.println(e);

		}

		return user;
	}

}
