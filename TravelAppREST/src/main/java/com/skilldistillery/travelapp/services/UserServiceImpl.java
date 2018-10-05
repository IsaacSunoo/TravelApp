package com.skilldistillery.travelapp.services;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.skilldistillery.travelapp.entities.Profile;
import com.skilldistillery.travelapp.entities.SettingsDTO;
import com.skilldistillery.travelapp.entities.User;
import com.skilldistillery.travelapp.entities.UserProfileDTO;
import com.skilldistillery.travelapp.repositories.ProfileRepository;
import com.skilldistillery.travelapp.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepo;

	@Autowired
	private ProfileRepository profileRepo;

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

			// Normally should cascade from the entity which has the foreign key (i.e.
			// profile has the foreign key for user_id), but this works too
			profile.setUser(user);

			user.setProfile(profile);

			// Cascade PERSIST exists on the User class, so it should persist the
			// Profile and User together here
			userRepo.saveAndFlush(user);

		} catch (Exception e) {

			System.out.println(e);

		}

		return user;
	}

	// This method takes care of updating User values from the settings form -
	// Here, we are getting the profile id coming in as an argument, not the user
	// id
	@Override
	public User updateSettings(Integer id, SettingsDTO settingsDTO) {

		Optional<Profile> opProfile = profileRepo.findById(id);

		if (opProfile.isPresent()) {
			Profile managedProfile = opProfile.get();

			// Since we had the profile id as an argument, we use the profile to find
			// the associated user
			User managedUser = managedProfile.getUser();

			if (settingsDTO.getName() != null && !settingsDTO.getName().equals("")
					&& settingsDTO.getName() != managedUser.getName()) {
				managedUser.setName(settingsDTO.getName());
			}

			if (settingsDTO.getEmail() != null && !settingsDTO.getEmail().equals("")
					&& settingsDTO.getEmail() != managedUser.getEmail()) {
				managedUser.setEmail(settingsDTO.getEmail());
			}

			if (settingsDTO.getPassword() != null
					&& !settingsDTO.getPassword().equals("")
					&& settingsDTO.getPassword() != managedUser.getPassword()) {
				managedUser.setPassword(settingsDTO.getPassword());
			}

			return managedUser;
		}

		return null;
	}

}
